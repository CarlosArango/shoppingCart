import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_carts_prov.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_prov.dart';

class ProductCartsRepository {
  final FirestoreProductCartsProvider? _firestoreProductCartsProvider;
  ProductCartsRepository({
    FirestoreProductProvider? firestoreProductCartsProvider,
  }) : _firestoreProductCartsProvider = FirestoreProductCartsProvider();

  Future<List<QueryDocumentSnapshot<ProductCart>>> getProductsCartByCartId(
      String cartId) async {
    return await _firestoreProductCartsProvider!
        .getProductsCartByCartId(cartId);
  }
}
