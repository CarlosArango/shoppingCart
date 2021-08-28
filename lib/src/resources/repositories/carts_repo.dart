import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/cart.dart';
import 'package:shopping_cart/src/resources/providers/firebase_carts_prov.dart';

class CartsRepository {
  final FirestoreCartsProvider _firestoreCartsProvider;
  CartsRepository({
    FirestoreCartsProvider? firestoreCartsProvider,
  }) : _firestoreCartsProvider =
            firestoreCartsProvider ?? FirestoreCartsProvider();

  Future<QueryDocumentSnapshot<Cart>?>? getCartByUserId(
      String userId, String status) async {
    return await _firestoreCartsProvider.getCartByUserId(userId, status);
  }

  Future<DocumentSnapshot<Cart>> create(Cart cart) async {
    return await _firestoreCartsProvider.create(cart);
  }

  Future<void> update(Cart cart, String id) async {
    return await _firestoreCartsProvider.update(cart, id);
  }
}
