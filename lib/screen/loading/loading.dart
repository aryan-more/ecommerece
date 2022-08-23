import 'package:ecommerece/provider/user.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const routeName = "/loading";

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).onBoot(context);
    AppTheme theme = Theme.of(context).theme;
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: theme.action,
        ),
      ),
    );
  }
}
