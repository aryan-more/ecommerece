import 'dart:convert';

import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/utils/url.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:http/http.dart' as http;

void cartUpdate({required Product product, required String token}) async {
  var res = await http.post(Uri.parse("$domain/cart"),
      headers: tokenHeader(token),
      body: jsonEncode({
        "products": [
          {"productid": product.id, "quantity": 1}
        ],
      }));
  if (res.statusCode != 200) {
    return errorSnackBar(title: "Unable to add products in cart", error: jsonDecode(res.body)["msg"] ?? "Something went wrong");
  }
  return successSnackBar(title: "Succesfully Added Products in cart", subtitle: "");
}
