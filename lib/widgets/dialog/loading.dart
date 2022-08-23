import 'package:ecommerece/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  static void show({required BuildContext context, bool dismissable = true}) async {
    showDialog(
      context: context,
      builder: (context) => const Loading(),
      barrierDismissible: dismissable,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Theme.of(context).theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.background.withAlpha(192),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      child: SpinKitDoubleBounce(
        color: theme.action,
      ),
    );
  }
}
