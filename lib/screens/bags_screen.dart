import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/provider/global_provider.dart';

class BagsScreen extends StatefulWidget {
  const BagsScreen({super.key});

  @override
  State<BagsScreen> createState() => _BagsScreenState();
}

class _BagsScreenState extends State<BagsScreen> {
  Future<CartModel> _getData() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);

    await provider.getCart(false);

    return provider.cart!;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, provider, child) {
      num total = 0;
      if (provider.cart != null) {
        total = provider.cart!.products!.fold(
            0,
            (sum, item) =>
                sum +
                (provider.products
                        .firstWhere((e) => e.id == item.productId)
                        .price! *
                    item.quantity!));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('title_cart'.tr()),
        ),
        body: provider.cart == null
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Таны сагсанд одоогоор бараа байхгүй байна',
                      maxLines: 5,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: provider.cart!.products!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Image.network(
                          provider.products
                              .firstWhere((e) =>
                                  e.id ==
                                  provider.cart!.products![index].productId)
                              .image!,
                          width: 50,
                          height: 80,
                        ),
                        title: Text(
                          provider.products
                              .firstWhere((e) =>
                                  e.id ==
                                  provider.cart!.products![index].productId)
                              .title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // subtitle: Text('Quantity: ${provider.cartItems[index].quantity}'),
                        subtitle: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                provider.subCartProduct(
                                    provider.cart!.products![index].productId!);
                              },
                              icon: Icon(
                                Icons.remove_circle_outline,
                                size: 30,
                              ),
                            ),
                            Text(
                              '${provider.cart!.products![index].quantity}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                provider.addCartProduct(
                                    provider.cart!.products![index].productId!);
                              },
                              icon: Icon(Icons.add_circle_outline, size: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Нийт: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.currentUser == null) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Success")));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, right: 30, left: 30, bottom: 10),
                    child: Text('CHECK OUT'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
