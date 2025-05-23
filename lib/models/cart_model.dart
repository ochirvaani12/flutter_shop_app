import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/models/product_model.dart';

@JsonSerializable(createToJson: false)
class CartModel {
  final int? id;
  final int? userId;
  List<CartProductModel>? products = [];

  CartModel({
    this.id,
    this.userId,
    this.products,
  });

  CartModel fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }

  static List<CartModel> fromList(List<dynamic> data) =>
      data.map((e) => CartModel().fromJson(e)).toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }
}

@JsonSerializable(createToJson: false)
class CartProductModel {
  int? productId;
  int? quantity = 0;

  CartProductModel({this.productId, this.quantity});

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return _$CartProductModelFromJson(json);
  }

  static List<CartProductModel> fromList(List<dynamic> data) => data
      .map((e) => CartProductModel.fromJson(e as Map<String, dynamic>))
      .toList();

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      products: json['products'] == null
          ? []
          : CartProductModel.fromList(json['products']),
    );

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
    );
