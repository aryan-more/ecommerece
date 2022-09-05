import 'package:ecommerece/controller/product_quantity.dart';
import 'package:ecommerece/widgets/snackbar/bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:ecommerece/widgets/quantity.dart';

class AddToCartBottomSheet extends StatelessWidget {
  const AddToCartBottomSheet({super.key, required this.product});
  final Product product;

  static void show(Product product) {
    Get.bottomSheet(
      AddToCartBottomSheet(
        product: product,
      ),
      barrierColor: Theme.of(Get.context!).theme.textColor.withAlpha(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<QuantityController>(
      QuantityController(),
      tag: product.id.toString(),
    );
    bool exist = true;
    AppTheme theme = Theme.of(context).theme;
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.scaleDown,
            ),
            title: Text(product.name),
            trailing: QuantityWidget(
              id: product.id.toString(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: workInProgress,
              child: Text(
                controller.quantity > 0
                    ? "Add to cart"
                    : exist
                        ? "Remove from cart"
                        : "Back",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
