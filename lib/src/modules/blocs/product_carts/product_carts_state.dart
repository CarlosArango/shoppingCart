part of 'product_carts_bloc.dart';

enum ProductCartsStatus {
  loading,
  loaded,
  add,
  minus,
  failure,
}

class ProductCartsState extends Equatable {
  final Stream<QuerySnapshot<ProductCart>> productCarts;
  final ProductCartsStatus productCartsStatus;
  final Product? productSelected;
  final String failureMsg;
  const ProductCartsState({
    required this.productCarts,
    required this.failureMsg,
    required this.productCartsStatus,
    this.productSelected,
  });

  @override
  String toString() =>
      "ProductCartsLoaded{productCarts:$productCarts, productCartsStatus:$productCartsStatus, failureMsg:$failureMsg}";

  @override
  List<Object> get props => [productCarts, productCartsStatus, failureMsg];

  ProductCartsState copyWith({
    Stream<QuerySnapshot<ProductCart>>? productCarts,
    ProductCartsStatus? productCartsStatus,
    String? failureMsg,
    Product? productSelected,
  }) =>
      ProductCartsState(
        productCarts: productCarts ?? this.productCarts,
        productCartsStatus: productCartsStatus ?? this.productCartsStatus,
        productSelected: productSelected ?? this.productSelected,
        failureMsg: failureMsg ?? this.failureMsg,
      );
}
