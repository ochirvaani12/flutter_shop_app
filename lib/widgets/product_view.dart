import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import '../models/product_model.dart';
import '../provider/global_provider.dart';

class ProductView extends StatelessWidget {
  final ProductModel data;

  const ProductView(this.data, {super.key});

  _onTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ProductDetailScreen(data)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (BuildContext context, provider, child) {
        return InkWell(
          onTap: () => _onTap(context),
          child: Card(
            elevation: 4.0,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                Container(
                  height: 150.0, // Adjust the height based on your design
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.image!),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                // Product details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${data.price!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if(provider.currentUser == null) {
                                  Navigator.pushNamed(context, '/login');
                                } else {
                                  provider.changeFavItems(data);
                                }
                              },
                              child: Icon(
                                Icons.favorite,
                                color: (provider.favItems.indexWhere((e) => e.id == data.id)) == -1 ?  Colors.grey : Colors.yellow,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
