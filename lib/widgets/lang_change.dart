import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageToggle extends StatelessWidget {
  Future<void> _setLocale(BuildContext context, String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);
    await context.setLocale(Locale(code));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => _setLocale(context, 'en'),
          icon: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
        ),
        IconButton(
          onPressed: () => _setLocale(context, 'mn'),
          icon: const Text('🇲🇳', style: TextStyle(fontSize: 24)),
        ),
      ],
    );
  }
}
