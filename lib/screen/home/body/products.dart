import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/screen/home/widget/product_tile.dart';
import 'package:flutter/cupertino.dart';

class ProductsView extends StatelessWidget {
  final List<Product> products;
  const ProductsView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ProductTile(product: products[index]),
      physics: BouncingScrollPhysics(),
      itemCount: products.length,
    );
  }
}
