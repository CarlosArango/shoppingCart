import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';

int getQuantities(
  List<QueryDocumentSnapshot<ProductCart>> productCarts,
) {
  final productsQuantity = productCarts.map((e) => e.data().quantity).toList();
  final quantities = productsQuantity.length > 0
      ? productsQuantity.reduce((value, element) => value + element)
      : 0;
  return quantities;
}

double getTotal(
  List<QueryDocumentSnapshot<ProductCart>> productCarts,
) {
  final productsTotal = productCarts.map((e) => e.data().total).toList();
  final total = productsTotal.reduce((value, element) => value! + element!);
  return total!.toDouble();
}
