part of 'cart_bloc.dart';

enum CartStatus {
  pending,
  buying,
  bought,
  failure,
}

class CartState extends Equatable {
  final CartStatus cartStatus;
  final String failureMsg;
  const CartState({
    required this.cartStatus,
    required this.failureMsg,
  });

  @override
  String toString() =>
      "ProductCartsLoaded{cartsStatus:$cartStatus, failureMsg:$failureMsg}";

  @override
  List<Object> get props => [cartStatus, failureMsg];

  CartState copyWith({
    CartStatus? cartStatus,
    String? failureMsg,
  }) =>
      CartState(
        cartStatus: cartStatus ?? this.cartStatus,
        failureMsg: failureMsg ?? this.failureMsg,
      );
}
