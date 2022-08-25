// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:ecommerece/models/user.dart';
import 'package:ecommerece/provider/user.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/service/auth.dart';
import 'package:ecommerece/widgets/dialog/loading.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

mixin LogInScreenMixin {
  bool isSignIn = true;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void changeHidePassword() => hidePassword = !hidePassword;
  void changeConfirmHidePassword() => hideConfirmPassword = !hideConfirmPassword;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailTextController;
  late TextEditingController usenameTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late TextEditingController phoneTextController;

  void init() {
    emailTextController = TextEditingController();
    usenameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    phoneTextController = TextEditingController();
  }

  void disposeControllers() {
    emailTextController.dispose();
    usenameTextController.dispose();
    passwordTextController.dispose();
    phoneTextController.dispose();
    confirmPasswordTextController.dispose();
  }

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Name shouldn't be Empty";
    }
    return null;
  }

  String? emailValidator(String? email) {
    if (email == null || (!EmailValidator.validate(email))) {
      return "Invalid Email Id";
    }

    return null;
  }

  String? emailOrPhoneValidator(String? userInput) {
    if (phoneValidator(userInput) == null || emailValidator(userInput) == null) {
      return null;
    }
    return "Invalid email or phone number";
  }

  String? passwordValidator(String? password) {
    if (password == null || password.length < 8) {
      return "Password should be 8 character longer";
    }
    return null;
  }

  String? confirmPasswordValidator(String? password) {
    if (password != passwordTextController.text) {
      return "Password doest match";
    }
    return null;
  }

  String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number cannot be empty";
    }
    if (phone.length != 10) {
      return "Invalid Phone Number";
    }
    return null;
  }

  void changeAuthMode() {
    isSignIn = !isSignIn;
    formKey.currentState!.reset();
  }

  void skip(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).saveInfo();
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  Future<void> authenticate({
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      if (!(await InternetConnectionCheckerPlus().hasConnection)) {
        return errorSnackBar(title: "Authentication Failed", error: "No internet connection");
      }
      try {
        Loading.show(context: context, dismissable: false);
        http.Response response = await (isSignIn
            ? signIn(
                contact: emailTextController.text,
                password: passwordTextController.text,
              )
            : signUp(
                email: emailTextController.text,
                password: passwordTextController.text,
                username: usenameTextController.text,
                phone: phoneTextController.text,
              ));
        Map<String, dynamic>? json;
        UserAccount? user;
        try {
          json = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
          user = UserAccount.fromMap(json);
        } catch (_) {
          log(_.toString());
        }

        Navigator.of(context).pop();
        if (response.statusCode != 200) {
          return errorSnackBar(
              title: "Authentication Failed", error: json != null ? json["msg"] ?? "Something went wrong" : "Unable to parse response");
        }

        if (user != null) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          return errorSnackBar(title: "Authentication Failed", error: "Unable to parse response");
        }
      } catch (_) {
        Navigator.of(context).pop();
        return errorSnackBar(title: "Authentication Failed", error: "Something went wrong");
      }
    }
  }
}
