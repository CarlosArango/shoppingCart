import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/resources/repositories/carts_repo.dart';
import 'package:shopping_cart/src/resources/repositories/product_carts_repo.dart';

part 'product_carts_event.dart';
part 'product_carts_state.dart';

class ProductsCartsBloc extends Bloc<ProductCartsEvent, ProductCartsState> {
  final ProductCartsRepository _productCartsRepository;
  final CartsRepository _cartsRepository;

  ProductsCartsBloc({
    required ProductCartsRepository productCartsRepository,
    required CartsRepository cartsRepository,
  })  : _productCartsRepository = productCartsRepository,
        _cartsRepository = cartsRepository,
        super(
          ProductCartsState(
            productCarts: Stream<QuerySnapshot<ProductCart>>.empty(),
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
    } else if (event is ProductCartsAdd) {
      yield* mapProductCartsAddToState(event);
    } else if (event is ProductCartsSubstract) {
      yield* mapProductCartsSubstractToState(event);
    }
  }

  Stream<ProductCartsState> mapProductsLoadToState(
      ProductCartsLoad event) async* {
    try {
      final cart = await _cartsRepository.getCartByUserId(
          FirebaseAuth.instance.currentUser!.uid, "pending");
      final products =
          _productCartsRepository.getProductsCartByCartId(cart!.id);
      yield state.copyWith(
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

  Stream<ProductCartsState> mapProductCartsAddToState(
      ProductCartsAdd productCartsAdd) async* {
    try {
      yield state.copyWith(
        productCartsStatus: ProductCartsStatus.add,
        productSelected: productCartsAdd.product,
      );
      await _productCartsRepository.addProductQuantity(
        productCartsAdd.product,
      );
      if (productCartsAdd.isFirstTime) {
        add(ProductCartsLoad());
      }
    } catch (e) {
      yield state.copyWith(
        productCartsStatus: ProductCartsStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }

  Stream<ProductCartsState> mapProductCartsSubstractToState(
      ProductCartsSubstract productCartSubstract) async* {
    try {
      await _productCartsRepository.substractProductCart(
        productCartSubstract.product,
      );
    } catch (e) {
      yield state.copyWith(
        productCartsStatus: ProductCartsStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }
}
