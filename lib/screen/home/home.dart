import 'package:ecommerece/screen/home/body/failed.dart';
import 'package:ecommerece/screen/home/body/products.dart';
import 'package:ecommerece/screen/home/widget/search_bar.dart';
import 'package:ecommerece/screen/home/mixin.dart';
import 'package:ecommerece/screen/home/widget/drawer.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.query}) : super(key: key);
  static const routeName = "/home";
  final String? query;

  //
  static void navigate({required BuildContext context, String? query, bool replace = false}) {
    if (replace) {
      Get.offNamed(routeName, arguments: query);

      return;
    }
    Get.toNamed(routeName, arguments: query, preventDuplicates: false);
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeScreenMixin {
  @override
  Future<void> fetchProducts(String? query) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    await super.fetchProducts(query);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    fetchProducts(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).theme;
    return Scaffold(
      drawer: widget.query == null ? const HomeScreenDrawer() : null,
      appBar: AppBar(
        elevation: 0,
        title: SearchBar(
          theme: theme,
          query: widget.query,
        ),
        actions: [
          if (widget.query == null)
            const IconButton(
              onPressed: workInProgress,
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
        ],
      ),
      body: loading
          ? SpinKitDoubleBounce(
              color: theme.action,
            )
          : products != null
              ? ProductsView(
                  products: products!,
                )
              : FailedBody(
                  retry: () => fetchProducts(widget.query),
                ),
    );
  }
}
