part of 'products_bloc.dart';

enum ProductsStatus {
  loading,
  loaded,
  failure,
}

class ProductsState extends Equatable {
  final List<QueryDocumentSnapshot<Product>> products;
  final ProductsStatus productsStatus;
  final String failureMsg;
  const ProductsState({
    required this.products,
    required this.failureMsg,
    required this.productsStatus,
  });

  @override
  String toString() =>
      "ProductsLoaded{products:$products, productsStatus:$productsStatus, failureMsg:$failureMsg}";

  @override
  List<Object> get props => [products, productsStatus, failureMsg];

  ProductsState copyWith({
    List<QueryDocumentSnapshot<Product>>? products,
    ProductsStatus? productsStatus,
    String? failureMsg,
  }) =>
      ProductsState(
        products: products ?? this.products,
        productsStatus: productsStatus ?? this.productsStatus,
        failureMsg: failureMsg ?? this.failureMsg,
      );
}
