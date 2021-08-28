import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_carts_prov.dart';

class ProductCartsRepository {
  final FirestoreProductCartsProvider? _firestoreProductCartsProvider;
  ProductCartsRepository({
    FirestoreProductCartsProvider? firestoreProductCartsProvider,
  }) : _firestoreProductCartsProvider =
            firestoreProductCartsProvider ?? FirestoreProductCartsProvider();

  Stream<QuerySnapshot<ProductCart>> getProductsCartByCartId(String cartId) {
    return _firestoreProductCartsProvider!.getProductsCartByCartId(cartId);
  }

  Future<void> addProductQuantity(Product product) async {
    return await _firestoreProductCartsProvider!.addProductCart(product);
  }

  Future<void> substractProductCart(Product product) async {
    return await _firestoreProductCartsProvider!.substractProductCart(product);
  }
}
