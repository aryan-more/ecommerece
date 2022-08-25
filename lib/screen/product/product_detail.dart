import 'package:ecommerece/utils/theme.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter/material.dart';

import 'package:ecommerece/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  static const routeName = "/productDetails";

  static void navigate({required BuildContext context, required Product product}) {
    Navigator.of(context).pushNamed(routeName, arguments: product);
  }

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).theme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: widget.product.imageUrl,
              child: Image.network(
                widget.product.imageUrl,
                height: 200,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Divider(
                    height: 50,
                    color: theme.textColor.withAlpha(75),
                  ),
                  Text(widget.product.description),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: theme.background,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        width: double.infinity,
        child: const ElevatedButton(
          onPressed: workInProgress,
          child: Text("Add to cart"),
        ),
      ),
    );
  }
}
