import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/screen/404/error.dart';
import 'package:ecommerece/screen/auth/auth.dart';
import 'package:ecommerece/screen/home/home.dart';
import 'package:ecommerece/screen/loading/loading.dart';
import 'package:ecommerece/screen/product/product_detail.dart';
import 'package:flutter/material.dart';

// TODO Replace with GetX
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
        builder: (context) => HomeScreen(
          query: routeSettings.arguments as String?,
        ),
        settings: routeSettings,
      );

    case ProductDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: routeSettings.arguments as Product,
        ),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(builder: (context) => const PageNotFound());
  }
}
