part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoad extends ProductsEvent {
  const ProductsLoad();

  @override
  String toString() => 'ProductsLoad';

  @override
  List<Object> get props => [];
}
