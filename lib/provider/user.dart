// ignore_for_file: use_build_context_synchronously

import 'package:ecommerece/models/user.dart';
import 'package:ecommerece/screen/account/login.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/widgets/snackbar/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
      return;
    }
    if (data.isEmpty) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      return;
    }
    try {
      _user = UserAccount.fromJson(data);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (_) {
      errorSnackBar(context: context, error: "Unable to parse account details");
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    }
  }

  void setUser(UserAccount user) {
    _user = user;
    saveInfo();
    notifyListeners();
  }

  void refreshUserInfo() async {
    saveInfo();
    notifyListeners();
  }
}
