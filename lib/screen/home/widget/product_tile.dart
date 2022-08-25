import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/screen/product/product_detail.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).theme;
    return GestureDetector(
      onTap: () => ProductDetailsScreen.navigate(
        context: context,
        product: product,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.background,
          boxShadow: [
            BoxShadow(
              color: theme.textColor.withAlpha(50),
              spreadRadius: 1,
              blurRadius: 1.25,
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Hero(
                tag: product.imageUrl,
                child: Image.network(
                  product.imageUrl,
                  height: 135,
                  fit: BoxFit.scaleDown,
                  width: 135,
                ),
              ),
              ProductDetails(product: product)
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "₹${product.price}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton.icon(
              onPressed: workInProgress,
              icon: const Icon(Icons.add_shopping_cart_outlined),
              label: const Text(
                "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
