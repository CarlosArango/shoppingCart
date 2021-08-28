import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/resources/providers/firebase_carts_prov.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_carts_prov.dart';

class ProductCartsRepository {
  final FirestoreProductCartsProvider _firestoreProductCartsProvider;
  final FirestoreCartsProvider _firestoreCartsProvider;
  ProductCartsRepository({
    FirestoreProductCartsProvider? firestoreProductCartsProvider,
    FirestoreCartsProvider? firestoreCartsProvider,
  })  : _firestoreProductCartsProvider =
            firestoreProductCartsProvider ?? FirestoreProductCartsProvider(),
        _firestoreCartsProvider = FirestoreCartsProvider();

  Stream<QuerySnapshot<ProductCart>> getProductsCartByCartId(String cartId) {
    return _firestoreProductCartsProvider.getProductsCartByCartId(cartId);
  }

  Future<ProductCart?> getProductCart(String cartId, String productId) async {
    return await _firestoreProductCartsProvider.getProductCart(
        cartId, productId);
  }

  Future<void> addProductQuantity(Product product) async {
    final cart = await _firestoreCartsProvider.manageCart(
      product,
    );
    await manageProductCart(cart.id.toString(), product, "add");
  }

  Future<void> substractProductCart(Product product) async {
    final cart = await _firestoreCartsProvider.manageCart(product);
    await manageProductCart(cart.id.toString(), product, "substract");
  }

  Future<void> manageProductCart(
    String cartId,
    Product product,
    String type,
  ) async {
    final productCart = await getProductCart(cartId, product.id);
    if (productCart == null) {
      final productCart = ProductCart(
        id: "",
        cartId: cartId,
        product: product,
        quantity: 1,
      );
      final productCreated =
          await _firestoreProductCartsProvider.create(productCart);
      productCart.id = productCreated.id;
      await _firestoreProductCartsProvider.update(productCart, productCart.id);
    } else {
      int quantity = productCart.quantity;
      if (type == "add") {
        quantity++;
      } else {
        quantity--;
      }

      await _firestoreProductCartsProvider.update(
        productCart.copyWith(quantity: quantity),
        productCart.id,
      );
    }
  }
}
