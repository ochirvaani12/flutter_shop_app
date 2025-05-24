import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/global_provider.dart';
import 'bags_screen.dart';
import 'shop_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, provider, child) {
      List<Widget> pages = [
        const ShopScreen(),
        const BagsScreen(),
        const FavoriteScreen(),
        provider.isLogged ?
        ProfileScreen(
          providers: const [],
          actions: [
            SignedOutAction((context) {
              context.pushReplacement('/');
            }),
          ],
        ) :
        SignInScreen(
          actions: [
            ForgotPasswordAction(((context, email) {
              final uri = Uri(
                path: '/sign-in/forgot-password',
                queryParameters: <String, String?>{
                  'email': email,
                },
              );
              context.push(uri.toString());
            })),
            AuthStateChangeAction(((context, state) {
              final user = switch (state) {
                SignedIn state => state.user,
                UserCreated state => state.credential.user,
                _ => null
              };
              if (user == null) {
                return;
              }
              if (state is UserCreated) {
                user.updateDisplayName(user.email!.split('@')[0]);
              }
              if (!user.emailVerified) {
                user.sendEmailVerification();
                const snackBar = SnackBar(
                    content: Text(
                        'Please check your email to verify your email address'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              context.pushReplacement('/');
            })),
          ],
        )
      ];

      return Scaffold(
        body: pages[provider.currentIdx],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIdx,
            onTap: provider.changeCurrentIdx,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.shop), label: 'menu_shopping'.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket), label: 'menu_cart'.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'menu_favorite'.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'menu_profile'.tr()),
            ]),
      );
    });
  }
}
