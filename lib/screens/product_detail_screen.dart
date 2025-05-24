import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/global_provider.dart';

// ignore: camel_case_types
class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Image.network(
              product.image!,
              height: 200,
            ),
            Text(
              product.title!,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              product.description!,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'PRICE: \$${product.price}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            provider.addCartProduct(product.id!);
            Navigator.pop(context);
          },
          child: Icon(Icons.shopping_cart),
        ),
      );
    });
  }
}
