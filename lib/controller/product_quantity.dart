import 'package:get/get.dart';

class QuantityController extends GetxController {
  QuantityController({int? quantity}) : quantity = (quantity ?? 1).obs;

  RxInt quantity;
  void increment() => quantity++;
  void decrement() => quantity.value <= 0 ? null : quantity--;
}
