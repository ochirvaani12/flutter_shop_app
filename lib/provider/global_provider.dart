import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';

import '../models/user_model.dart';
import '../repository/repository.dart';

class GlobalProvider extends ChangeNotifier {
  int currentIdx = 0;

  List<ProductModel> products = [];
  List<ProductModel> favItems = [];

  CartModel? cart;

  String? token;
  UserModel? currentUser;

  final ShopRepository repository = ShopRepository();
  final storage = const FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    bool isFound = false;

    final String res = await rootBundle.loadString('assets/users.json');
    List<UserModel> users = UserModel.fromList(jsonDecode(res));
    for (UserModel i in users) {
      if (i.username == username && i.password == password) {
        isFound = true;

        print("found");

        token = await repository.login(username, password);


        print("token");
        await storage.write(key: 'token', value: token);

        currentUser = i;
        break;
      }
    }

    notifyListeners();

    return isFound;
  }

  Future<void> getProducts() async {
    if (products.isEmpty) {
      products = await repository.fetchProductData();

      notifyListeners();
    }
  }

  Future<void> getCart(bool forceRefresh) async {
    if(forceRefresh || cart == null) {
      List<CartModel> allCarts = await repository.fetchCartData();

      for (CartModel i in allCarts) {
        if (i.userId == currentUser?.id) {
          cart = i;
          break;
        }
      }

      notifyListeners();
    }
  }

  Future<void> addCartProduct(int productId) async {
    final index = cart!.products!.indexWhere((e) => e.productId == productId);

    if (index != -1) {
      cart!.products!.add(CartProductModel(productId: productId, quantity: 1));
    } else {
      cart!.products![index].quantity = cart!.products![index].quantity! + 1;
    }

    await repository.updateCartData(cart!);

    getCart(true);

    notifyListeners();
  }

  Future<void> subCartProduct(int productId) async {
    final index = cart!.products!.indexWhere((e) => e.productId == productId);

    if (index != -1) {
      if (cart!.products![index].quantity! <= 1) {
        cart!.products!.removeAt(index);
      } else {
        cart!.products![index].quantity = cart!.products![index].quantity! - 1;
      }
    }

    await repository.updateCartData(cart!);

    getCart(true);

    notifyListeners();
  }

  void changeFavItems(ProductModel item) {
    final exists = favItems.any((e) => e.id == item.id);
    if (exists) {
      favItems.removeWhere((e) => e.id == item.id);
    } else {
      favItems.add(item);
    }
    notifyListeners();
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }
}
