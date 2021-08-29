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
