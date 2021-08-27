import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/resources/repositories/product_repo.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;

  ProductsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(
          ProductsState(
            products: [],
            failureMsg: "",
            productsStatus: ProductsStatus.loading,
          ),
        );

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is ProductsLoad) {
      yield* mapProductsLoadToState(event);
    }
  }

  Stream<ProductsState> mapProductsLoadToState(ProductsLoad event) async* {
    try {
      final products = await _productRepository.getProducts();
      yield ProductsState(
        products: products,
        failureMsg: '',
        productsStatus: ProductsStatus.loaded,
      );
    } catch (e) {
      yield state.copyWith(
        productsStatus: ProductsStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }
}
