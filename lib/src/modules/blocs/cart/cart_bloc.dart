import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_cart/src/model/cart.dart' as CartModel;
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/user.dart' as UserModel;
import 'package:shopping_cart/src/resources/repositories/carts_repo.dart';
import 'package:shopping_cart/src/utils/cart.dart' as UtilCart;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartsRepository _cartsRepository;
  CartBloc({
    required CartsRepository cartsRepository,
  })  : _cartsRepository = cartsRepository,
        super(
          CartState(
            cartStatus: CartStatus.pending,
            failureMsg: "",
          ),
        );

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartButtonBuyPressed) {
      yield* mapCartButtonBuyPressedToState(event);
    }
  }

  Stream<CartState> mapCartButtonBuyPressedToState(
      CartButtonBuyPressed event) async* {
    try {
      yield CartState(
        cartStatus: CartStatus.buying,
        failureMsg: '',
      );
      await _cartsRepository.update(
        CartModel.Cart(
          id: event.cartId,
          status: CartModel.CartStatus.completed,
          total: UtilCart.getTotal(event.productsCart),
          user: UserModel.User(
            id: FirebaseAuth.instance.currentUser!.uid,
          ),
        ),
        event.cartId,
      );
      yield CartState(
        cartStatus: CartStatus.bought,
        failureMsg: '',
      );
    } catch (e) {}
  }
}
