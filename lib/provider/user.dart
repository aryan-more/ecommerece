// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:ecommerece/models/cart.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/models/user.dart';
import 'package:ecommerece/screen/auth/auth.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/utils/url.dart';
import 'package:ecommerece/widgets/bottom_sheet/add_to_cart.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// TODO Replace provider with GetX
class UserProvider extends ChangeNotifier {
  UserAccount? _user;
  late SharedPreferences preferences;
  final List<CartProduct> _cartProducts = [];
  final List<CartProduct> _cartUpdateStack = [];
  bool cartUpdateInProgress = false;

  UserAccount? get user => _user;

  void addProductsFromJson(String json) {}

  Future<void> persistCartLocaly() async {
    await preferences.setString("cart", jsonEncode({"cart": _cartProducts.map((e) => e.toMap()).toList()}));
  }

  void updateCart(List<CartProduct> product) {}

  void addProductQuantity(Product product) {
    Get.bottomSheet(AddToCartBottomSheet(product: product));
  }

  void saveInfo() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    secureStorage.write(
      key: "user",
      value: _user?.toJson() ?? "",
    );
  }

  void onBoot(BuildContext context) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    preferences = await SharedPreferences.getInstance();
    String? data = await secureStorage.read(key: "user");

    if (data == null) {
      // User first time opened app or didn't login or skipped login
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
      return;
    }
    if (data.isEmpty) {
      // User skipped login
      HomeScreen.navigate(context: context, replace: true);
      return;
    }
    try {
      _user = UserAccount.fromJson(data);
      // After succesfully retriving user details from secure storage
      HomeScreen.navigate(context: context, replace: true);

      refreshUserInfo();
    } catch (_) {
      errorSnackBar(title: "Login Error", error: "Unable to parse account details");
      // Most likely never happen but in case secure storage get corupted or tampered
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    }
  }

  void setUser(UserAccount user) {
    _user = user;
    notifyListeners();
    saveInfo();
  }

  void refreshUserInfo() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$domain/info"),
        headers: tokenHeader(user!.token),
      );
      if (response.statusCode != 200) {
        return errorSnackBar(title: "Authentication Error", error: jsonDecode(response.body)["msg"] ?? "Something went wrong");
      }
      _user?.applyUpdate(UpdatedUserAccount.fromJson(response.body));
      notifyListeners();
      saveInfo();
    } catch (_) {
      log(_.toString());
    }
  }
}
