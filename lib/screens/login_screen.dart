import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../provider/global_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLogin(BuildContext context) async {

    final username = usernameController.text;
    final password = passwordController.text;
    print(username);
    print(password);

    if (await Provider.of<GlobalProvider>(context, listen: false).login(username, password)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(), title: Text('title_login'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text('Тавтай морилно уу'),
            TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Нэвтрэх нэр')),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Нууц үг'),
                obscureText: true),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => onLogin(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50)),
              child: const Text('Нэвтрэх'),
            ),
            TextButton(
              onPressed: () => {},
              child: const Text("Бүртгүүлэх"),
            )
          ],
        ),
      ),
    );
  }
}
