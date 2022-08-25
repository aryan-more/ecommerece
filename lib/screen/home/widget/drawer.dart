import 'package:ecommerece/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider?>();
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: user != null
                ? Column(
                    children: [],
                  )
                : Text(""),
          )
        ],
      ),
    );
  }
}
