import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/global_blocs/auth/auth_bloc.dart';
import 'package:shopping_cart/src/modules/home/blocs/products/products_bloc.dart';
import 'package:shopping_cart/src/modules/home/widget/products_body.dart';
import 'package:shopping_cart/src/resources/repositories/auth_repo.dart';
import 'package:shopping_cart/src/resources/repositories/product_repo.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepo = RepositoryProvider.of<AuthRepository>(
      context,
    );
    final productRepo = RepositoryProvider.of<ProductRepository>(
      context,
    );
    final authBloc = AuthBloc(authRepository: authRepo);

    final productsBloc = ProductsBloc(productRepository: productRepo);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TULCART',
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsBloc>(
              create: (context) => productsBloc..add(ProductsLoad())),
          BlocProvider<AuthBloc>(create: (context) {
            print("entre");
            return authBloc
              ..add(
                AuthAutomatically(),
              );
          }),
        ],
        child: HomeBody(),
      ),
    );
  }
}
