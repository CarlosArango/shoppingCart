import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';

class FirestoreProductCartsProvider {
  final productsCollection = FirebaseFirestore.instance
      .collection('product_carts')
      .withConverter<ProductCart>(
        fromFirestore: (snapshot, _) => ProductCart.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );

  Stream<QuerySnapshot<ProductCart>> getProductsCartByCartId(String cartId) {
    final products = productsCollection
        .where(
          "cart_id",
          isEqualTo: cartId,
        )
        .snapshots();

    return products;
  }

  Future<ProductCart> getProductCartByProductId(String productId) async {
    return await productsCollection
        .where(
          "product.id",
          isEqualTo: productId,
        )
        .get()
        .then((value) => value.docs[0].data());
  }

  Future<void> addProductCart(Product product) async {
    final productCartFound = await getProductCartByProductId(product.id);
    // ignore: unnecessary_null_comparison
    if (productCartFound != null) {
      await productsCollection
          .doc(productCartFound.id)
          .update({'quantity': productCartFound.quantity + 1});
    }
  }

  Future<void> substractProductCart(Product product) async {
    final productCartFound = await getProductCartByProductId(product.id);
    // ignore: unnecessary_null_comparison
    if (productCartFound != null) {
      await productsCollection
          .doc(productCartFound.id)
          .update({'quantity': productCartFound.quantity - 1});
    }
  }
}
