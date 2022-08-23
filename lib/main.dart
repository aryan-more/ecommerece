import 'package:ecommerece/provider/user.dart';
import 'package:ecommerece/screen/loading/loading.dart';
import 'package:ecommerece/utils/routes.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: AppTheme.themeData(
        lightTheme,
      ),
      darkTheme: AppTheme.themeData(
        darkTheme,
      ),
      home: const LoadingScreen(),
      onGenerateRoute: genrate,
    );
  }
}
