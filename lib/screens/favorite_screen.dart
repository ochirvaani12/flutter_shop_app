import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/global_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('title_favorite'.tr()),
          ),
          body: ListView.builder(
            itemCount: provider.favProducts.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // shadow color
                        spreadRadius: 2, // how wide the shadow spreads
                        blurRadius: 6, // softness of the shadow
                        offset: const Offset(0, 3), // x and y axis (right/down)
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Image.network(
                      provider
                          .products[provider.products.indexWhere(
                              (p) => p.id == provider.favProducts[index])]
                          .image!,
                      width: 50,
                      height: 80,
                    ),
                    title: Text(
                      provider
                          .products[provider.products.indexWhere(
                              (p) => p.id == provider.favProducts[index])]
                          .title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
