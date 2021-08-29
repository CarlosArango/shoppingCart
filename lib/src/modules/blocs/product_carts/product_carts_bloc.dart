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
  StreamSubscription? streamSubscription;
  ProductsCartsBloc({
    required ProductCartsRepository productCartsRepository,
    required CartsRepository cartsRepository,
  })  : _productCartsRepository = productCartsRepository,
        _cartsRepository = cartsRepository,
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
    } else if (event is ProductCartsLoadUpdate) {
      yield* mapProductsLoadUpdateToState(event);
    } else if (event is ProductCartsAdd) {
      yield* mapProductCartsAddToState(event);
    } else if (event is ProductCartsSubstract) {
      yield* mapProductCartsSubstractToState(event);
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  Stream<ProductCartsState> mapProductsLoadToState(
      ProductCartsLoad event) async* {
    try {
      streamSubscription?.cancel();
      yield state.copyWith(productCarts: []);
      final cart = await _cartsRepository.getCartByUserId(
          FirebaseAuth.instance.currentUser!.uid, "pending");
      final products =
          _productCartsRepository.getProductsCartByCartId(cart!.id);

      streamSubscription = products.listen(
        (event) {
          /*  final other = event.docs
            .map((e) => ProductCart(
                id: e.data().id,
                cartId: e.data().cartId,
                product: e.data().product,
                quantity: e.data().quantity))
            .toList(); */
          add(
            ProductCartsLoadUpdate(productCarts: event.docs),
          );
        },
      );
    } catch (e) {
      yield state.copyWith(
        productCartsStatus: ProductCartsStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }

  Stream<ProductCartsState> mapProductsLoadUpdateToState(
      ProductCartsLoadUpdate event) async* {
    yield ProductCartsState(
      productCarts: event.productCarts,
      productCartsStatus: ProductCartsStatus.loaded,
      failureMsg: "",
    );
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
