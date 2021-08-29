part of 'product_carts_bloc.dart';

@immutable
abstract class ProductCartsEvent extends Equatable {
  const ProductCartsEvent();

  @override
  List<Object> get props => [];
}

class ProductCartsLoad extends ProductCartsEvent {
  const ProductCartsLoad();

  @override
  String toString() => 'ProductCartsLoad';

  @override
  List<Object> get props => [];
}

class ProductCartsLoadUpdate extends ProductCartsEvent {
  final List<QueryDocumentSnapshot<ProductCart>> productCarts;
  const ProductCartsLoadUpdate({
    required this.productCarts,
  });

  @override
  String toString() => 'ProductCartsLoad';

  @override
  List<Object> get props => [productCarts];
}

class ProductCartsAdd extends ProductCartsEvent {
  final Product product;
  final bool isFirstTime;

  const ProductCartsAdd({
    required this.product,
    this.isFirstTime = false,
  });

  @override
  String toString() => 'ProductCartsAdd';

  @override
  List<Object> get props => [product];
}

class ProductCartsSubstract extends ProductCartsEvent {
  final Product product;

  const ProductCartsSubstract({required this.product});

  @override
  String toString() => 'ProductCartsSubstract';

  @override
  List<Object> get props => [product];
}

class ProductCartsEmpty extends ProductCartsEvent {
  const ProductCartsEmpty();

  @override
  String toString() => 'ProductCartsEmpty';

  @override
  List<Object> get props => [];
}
