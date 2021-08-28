import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/cart.dart';

class FirestoreCartsProvider {
  final cartsCollection =
      FirebaseFirestore.instance.collection('carts').withConverter<Cart>(
            fromFirestore: (snapshot, _) => Cart.fromJson(snapshot.data()!),
            toFirestore: (cart, _) => cart.toJson(),
          );

  Future<QueryDocumentSnapshot<Cart>?>? getCartByUserId(
    String userId,
    String status,
  ) async {
    final carts = await cartsCollection
        .where(
          "user_id",
          isEqualTo: userId,
        )
        .where(
          "status",
          isEqualTo: status,
        )
        .get()
        .then(
          (value) => value.docs,
        );
    if (carts.length == 0) return null;
    return carts[0];
  }

  Future<DocumentSnapshot<Cart>> create(Cart cart) async {
    return await cartsCollection.add(cart).then((value) => value.get());
  }

  Future<void> update(Cart cart, id) async {
    await cartsCollection.doc(id).set(cart);
  }
}
