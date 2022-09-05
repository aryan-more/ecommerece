import 'package:ecommerece/controller/product_quantity.dart';
import 'package:ecommerece/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).theme;
    QuantityController controller = Get.find(tag: id);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          color: theme.action,
          onPressed: controller.decrement,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(() => Text("${controller.quantity}")),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          color: theme.action,
          onPressed: controller.increment,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
