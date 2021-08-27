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
