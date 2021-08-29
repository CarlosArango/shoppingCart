import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/resources/repositories/auth_repo.dart';
import 'package:shopping_cart/src/resources/repositories/carts_repo.dart';
import 'package:shopping_cart/src/resources/repositories/product_carts_repo.dart';
import './utils/theme/theme.dart' as theme;
import 'global_blocs/auth/auth_bloc.dart';
import './utils/navigation/routes.dart' as routes;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              authRepository: AuthRepository(),
            )..add(
                AuthAutomatically(),
              );
          },
        ),
        BlocProvider<CartBloc>(
          create: (context) {
            return CartBloc(
              cartsRepository: CartsRepository(),
            );
          },
        ),
        BlocProvider<ProductsCartsBloc>(
          create: (context) => ProductsCartsBloc(
            cartsRepository: CartsRepository(),
            productCartsRepository: ProductCartsRepository(),
          )..add(
              ProductCartsLoad(),
            ),
        ),
      ],
      child: MaterialApp(
        title: "Tul cart",
        routes: routes.mainRoute(),
        onGenerateRoute: routes.generateRoute,
        onUnknownRoute: routes.unknownRoute,
        initialRoute: routes.MainRoute,
        theme: theme.lightTheme,
      ),
    );
  }
}
