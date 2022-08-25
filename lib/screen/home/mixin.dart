import 'dart:convert';

import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/utils/url.dart';
import 'package:http/http.dart' as http;

mixin HomeScreenMixin {
  List<Product>? products;
  bool loading = false;

  Future<void> fetchProducts(String? query) async {
    try {
      String api = query != null ? "product?search=$query" : "products";
      http.Response response = await http.get(Uri.parse("$domain/$api"));
      if (response.statusCode != 200) {
        return;
      }
      List<Product> products = [];
      var map = jsonDecode(response.body) as Map;
      for (var productMap in map["products"]) {
        products.add(Product.fromMap(productMap));
      }
      this.products = products;
    } catch (_) {}
  }
}
