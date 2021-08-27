import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_prov.dart';

class ProductRepository {
  final FirestoreProductProvider _firestoreProductProvider;
  ProductRepository({
    required FirestoreProductProvider firestoreProductProvider,
  }) : _firestoreProductProvider = FirestoreProductProvider();

  Future<List<QueryDocumentSnapshot<Product>>> getProducts() async {
    return await _firestoreProductProvider.getProducts();
  }
}
