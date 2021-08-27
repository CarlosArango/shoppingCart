import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/products.dart';

class FirestoreProductProvider {
  // Create a CollectionReference called users that references the firestore collection
  final productsCollection =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson(),
          );

  Future<List<QueryDocumentSnapshot<Product>>> getProducts() async {
    List<QueryDocumentSnapshot<Product>> products =
        await productsCollection.get().then((value) => value.docs);

    return products;
  }
}
