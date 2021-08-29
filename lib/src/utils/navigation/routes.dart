import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/global_blocs/auth/auth_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/products/products_bloc.dart';
import 'package:shopping_cart/src/modules/cart/ui/cart.dart';
import 'package:shopping_cart/src/modules/home/ui/home.dart';
import 'package:shopping_cart/src/resources/repositories/product_repo.dart';

const String MainRoute = '/';
const String CartRoute = '/cart';
Map<String, Widget Function(BuildContext)> mainRoute() {
  return {
    MainRoute: (context) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state.authStatus == AuthStatus.authenticated) {
            return BlocProvider<ProductsBloc>(
              create: (context) =>
                  ProductsBloc(productRepository: ProductRepository())
                    ..add(
                      ProductsLoad(),
                    ),
              child: HomeUI(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  };
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CartRoute:
      return MaterialPageRoute(
        builder: (context) => Cart(),
      );

    default:
      return unknownRoute(settings);
  }
}

Route<dynamic> unknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => Container(
      child: Text("Unknown route"),
    ),
  );
}
