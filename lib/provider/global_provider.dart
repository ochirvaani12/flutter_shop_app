import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../firebase_option.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../repository/repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    init();
  }

  final ShopRepository repository = ShopRepository();
  final storage = const FlutterSecureStorage();

  int currentIdx = 0;

  List<ProductModel> products = [];

  User? loggedUser;
  bool isLogged = false;

  StreamSubscription<DocumentSnapshot>? _cartSubscription;
  CartModel cart = CartModel(products: []);

  StreamSubscription<QuerySnapshot>? _favProductsSubscription;
  List<int> favProducts = [];

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        isLogged = true;
        loggedUser = user;
        _cartSubscription = FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .snapshots()
            .listen(
          (doc) {
            if (doc.exists && doc.data() != null) {
              cart = CartModel.fromJson(doc.data() as Map<String, dynamic>);
            }
          },
        );

        _favProductsSubscription = FirebaseFirestore.instance
            .collection('favProducts')
            .snapshots()
            .listen(
          (snapshot) {
            favProducts = [];
            for (final document in snapshot.docs) {
              favProducts.add(document.data()['productId'] as int);
            }
          },
        );
      } else {
        isLogged = false;
        cart = CartModel(products: []);
        favProducts = [];
        _cartSubscription?.cancel();
        _favProductsSubscription?.cancel();
      }
    });

    notifyListeners();

    getProducts();
  }

  Future<void> getProducts() async {
    if (products.isEmpty) {
      products = await repository.fetchProductData();

      notifyListeners();
    }
  }

  Future<void> saveCartToFirestore(CartModel cart) async {
    final docRef =
        FirebaseFirestore.instance.collection('cart').doc(loggedUser?.uid);
    await docRef.set(cart.toJson());
  }

  Future<void> addCartProduct(int productId) async {
    final index = cart.products!.indexWhere((p) => p.productId == productId);

    if (index == -1) {
      cart.products!.add(CartProductModel(productId: productId, quantity: 1));
    } else {
      cart.products![index].quantity =
          (cart.products![index].quantity ?? 0) + 1;
    }

    await saveCartToFirestore(cart);
    notifyListeners();
  }

  Future<void> subCartProduct(int productId) async {
    final index = cart.products!.indexWhere((p) => p.productId == productId);
    if (index == -1) return;

    final currentQty = cart.products![index].quantity ?? 0;
    if (currentQty > 1) {
      cart.products![index].quantity = currentQty - 1;
    } else {
      cart.products!.removeAt(index);
    }

    await saveCartToFirestore(cart);
    notifyListeners();
  }

  Future<void> changeFavProduct(int productId) async {
    final index = favProducts.indexOf(productId);
    if (index != -1) {
      favProducts.remove(productId);
    } else {
      favProducts.add(productId);
    }
    if (loggedUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('favProducts')
          .doc(loggedUser!.uid);

      await docRef.set({'productIds': favProducts});
    }
    notifyListeners();
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }
}
