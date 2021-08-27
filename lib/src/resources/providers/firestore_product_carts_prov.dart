import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';

class FirestoreProductCartsProvider {
  // Create a CollectionReference called users that references the firestore collection
  final productsCollection = FirebaseFirestore.instance
      .collection('products_cart')
      .withConverter<ProductCart>(
        fromFirestore: (snapshot, _) => ProductCart.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );

  Future<List<QueryDocumentSnapshot<ProductCart>>> getProductsCartByCartId(
      String cartId) async {
    List<QueryDocumentSnapshot<ProductCart>> products =
        await productsCollection.get().then((value) => value.docs);

    return products;
  }
}
