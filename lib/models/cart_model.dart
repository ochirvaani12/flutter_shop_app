import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createToJson: false)
class CartModel {
  List<CartProductModel>? products = [];

  CartModel({
    this.products,
  });

  static CartModel fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
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
      products: json['products'] == null
          ? []
          : CartProductModel.fromList(json['products']),
    );

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
    );
