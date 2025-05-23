import 'package:shop_app/models/cart_model.dart';

import '../models/product_model.dart';
import '../service/httpService.dart';

class ShopRepository {
  final HttpService httpService = HttpService();

  ShopRepository();

  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products', null);
      print(jsonData);
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<List<CartModel>> fetchCartData() async {
    try {
      var jsonData = await httpService.getData('carts', null);
      print(jsonData);
      List<CartModel> data = CartModel.fromList(jsonData);
      return data;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<void> updateCartData(CartModel cart) async {
    try {
       await httpService.putData('carts/${cart.id}', null, cart.toJson());
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<String> login(String username, String password) async {
    try {
      dynamic data = {"username": username, "password": password};
      var jsonData = await httpService.postData('auth/login', null, data);
      return jsonData["token"];
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }
}
