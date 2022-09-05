// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:ecommerece/models/product.dart';

class CartProduct {
  final int id;
  int quantity;
  CartProduct({
    required this.id,
    required this.quantity,
  });

  CartProduct.fromProduct({required Product product, required this.quantity}) : id = product.id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) => CartProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
