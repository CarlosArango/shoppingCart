part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartButtonBuyPressed extends CartEvent {
  final String cartId;
  final List<QueryDocumentSnapshot<ProductCart>> productsCart;
  const CartButtonBuyPressed({
    required this.cartId,
    required this.productsCart,
  });

  @override
  String toString() => 'ProductCartsAdd';

  @override
  List<Object> get props => [cartId, productsCart];
}
