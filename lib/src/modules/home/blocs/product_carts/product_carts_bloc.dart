import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/resources/repositories/product_carts_repo.dart';

part 'product_carts_event.dart';
part 'product_carts_state.dart';

class ProductsCartsBloc extends Bloc<ProductCartsEvent, ProductCartsState> {
  final ProductCartsRepository _productCartsRepository;

  ProductsCartsBloc({required ProductCartsRepository productCartsRepository})
      : _productCartsRepository = productCartsRepository,
        super(
          ProductCartsState(
            productCarts: [],
            failureMsg: "",
            productCartsStatus: ProductCartsStatus.loading,
          ),
        );

  @override
  Stream<ProductCartsState> mapEventToState(
    ProductCartsEvent event,
  ) async* {
    if (event is ProductCartsLoad) {
      yield* mapProductsLoadToState(event);
    }
  }

  Stream<ProductCartsState> mapProductsLoadToState(
      ProductCartsLoad event) async* {
    try {
      final products =
          await _productCartsRepository.getProductsCartByCartId("1");
      yield ProductCartsState(
        productCarts: products,
        failureMsg: '',
        productCartsStatus: ProductCartsStatus.loaded,
      );
    } catch (e) {
      yield state.copyWith(
        productCartsStatus: ProductCartsStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }
}
