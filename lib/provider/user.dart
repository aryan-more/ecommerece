// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:ecommerece/models/user.dart';
import 'package:ecommerece/screen/auth/auth.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/utils/url.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  UserAccount? _user;

  UserAccount? get user => _user;

  void saveInfo() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    secureStorage.write(
      key: "user",
      value: _user?.toJson() ?? "",
    );
  }

  void onBoot(BuildContext context) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
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
      // Most likely never happen but in case secure strage get corupted
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    }
  }

  void setUser(UserAccount user) {
    _user = user;
    saveInfo();
    notifyListeners();
  }

  void refreshUserInfo() async {
    try {
      http.Response response = await http.post(
        Uri.parse("$domain/info"),
        body: jsonEncode(
          {"token": _user!.token},
        ),
        headers: jsonHeader,
      );
      if (response.statusCode == 200) {
        _user?.applyUpdate(UpdatedUserAccount.fromJson(response.body));
        notifyListeners();
        saveInfo();
      }
    } catch (_) {
      log(_.toString());
    }
  }
}
