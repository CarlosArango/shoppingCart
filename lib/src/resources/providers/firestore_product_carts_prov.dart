import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';

class FirestoreProductCartsProvider {
  final productCartsCollection = FirebaseFirestore.instance
      .collection('product_carts')
      .withConverter<ProductCart>(
        fromFirestore: (snapshot, _) => ProductCart.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );

  Stream<QuerySnapshot<ProductCart>> getProductsCartByCartId(String cartId) {
    final products = productCartsCollection
        .where(
          "cart_id",
          isEqualTo: cartId,
        )
        .snapshots();

    return products;
  }

  Future<ProductCart?> getProductCart(String cartId, String productId) async {
    final docs = await productCartsCollection
        .where(
          'cart_id',
          isEqualTo: cartId,
        )
        .where(
          "product.id",
          isEqualTo: productId,
        )
        .get()
        .then((value) => value.docs);
    if (docs.isEmpty) return null;
    return docs[0].data();
  }

  Future<void> addProductCart(Product product) async {
    final productCartFound = null;
    // ignore: unnecessary_null_comparison
    if (productCartFound != null) {
      await productCartsCollection
          .doc(productCartFound.id)
          .update({'quantity': productCartFound.quantity + 1});
    }
  }

  Future<void> substractProductCart(Product product) async {
    final productCartFound = null;
    // ignore: unnecessary_null_comparison
    if (productCartFound != null) {
      await productCartsCollection
          .doc(productCartFound.id)
          .update({'quantity': productCartFound.quantity - 1});
    }
  }

  Future<DocumentSnapshot<ProductCart>> create(ProductCart cart) async {
    return await productCartsCollection.add(cart).then((value) => value.get());
  }

  Future<void> update(ProductCart cart, id) async {
    await productCartsCollection.doc(id).set(cart);
  }
}
