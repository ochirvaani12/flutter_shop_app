import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/global_provider.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'bags_screen.dart';
import 'shop_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, provider, child) {
      List<Widget> pages = [
        const ShopScreen(),
        BagsScreen(),
        const FavoriteScreen(),
        provider.currentUser == null ? const LoginScreen() :const ProfileScreen()
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
