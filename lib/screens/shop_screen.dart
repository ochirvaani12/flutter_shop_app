import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'dart:convert';

import 'package:shop_app/provider/global_provider.dart';

import '../widgets/product_view.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  Future<List<ProductModel>> _getData() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);

    await provider.getProducts();

    return provider.products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title_product'.tr()),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => ProductView(snapshot.data![index]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
      ),
    );
  }
}
