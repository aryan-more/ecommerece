import 'package:ecommerece/screen/404/error.dart';
import 'package:ecommerece/screen/account/login.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/screen/loading/loading.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrate(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoadingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
        settings: routeSettings,
      );

    case LogInScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LogInScreen(),
        settings: routeSettings,
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(builder: (context) => const PageNotFound());
  }
}
