import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/global_provider.dart';
import '../widgets/lang_change.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, provider, child) {
      final user = provider.currentUser!;
      final name = "${user.name!.firstname} ${user.name!.lastname}";

      return Scaffold(
        appBar: AppBar(
          title: Text('title_profile'.tr()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              LanguageToggle(),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey.shade200,
                child: Text(
                  user.name!.firstname!.toUpperCase(),
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              Text("@${user.username}",
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow(Icons.email, user.email!),
                      _infoRow(Icons.phone, user.phone!),
                      const SizedBox(height: 16),
                      _sectionTitle("Address"),
                      _infoText(
                          "${user.address!.number} ${user.address!.street}"),
                      _infoText(
                          "${user.address!.city}, ${user.address!.zipcode}"),
                      const SizedBox(height: 16),
                      _sectionTitle("Geolocation"),
                      _infoText("Latitude: ${user.address!.geolocation?.lat}"),
                      _infoText("Longitude: ${user.address!.geolocation?.lng}"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87));
  }

  Widget _infoText(String text) {
    return Text(text, style: const TextStyle(fontSize: 16));
  }
}
