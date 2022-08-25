// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerece/utils/url.dart';

class Product {
  int id;
  int price;
  String name;
  String description;
  String image;

  Product({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.image,
  });

  String get imageUrl => "$domain/img/$image";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      price: map['price'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
