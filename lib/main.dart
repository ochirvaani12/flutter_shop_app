import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/global_provider.dart';
import 'package:shop_app/screens/login_screen.dart';
import '../../../screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final localeCode = prefs.getString('locale') ?? 'mn';

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('mn'), Locale('en')],
      path: 'assets/lang',
      fallbackLocale: Locale('mn'),
      startLocale: Locale(localeCode),
      child: ChangeNotifierProvider(
          create: (context) => GlobalProvider(), child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(useMaterial3: false),
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
