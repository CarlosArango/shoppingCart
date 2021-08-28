import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';

Map<String, dynamic> getInfoCart(
    List<QueryDocumentSnapshot<ProductCart>> productCarts) {
  final productsQuantity = productCarts.map((e) => e.data().quantity).toList();
  final productsTotal = productCarts.map((e) => e.data().total).toList();
  final quantities =
      productsQuantity.reduce((value, element) => value + element);
  final total = productsTotal.reduce((value, element) => value! + element!);
  return {"total": total, "quantities": quantities};
}
