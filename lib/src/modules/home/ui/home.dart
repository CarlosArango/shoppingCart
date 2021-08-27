import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/home/blocs/products/products_bloc.dart';
import 'package:shopping_cart/src/modules/home/widget/products_body.dart';
import 'package:shopping_cart/src/resources/repositories/product_repo.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TULCART',
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsBloc>(
              create: (context) =>
                  ProductsBloc(productRepository: ProductRepository())
                    ..add(ProductsLoad())),
        ],
        child: HomeBody(),
      ),
    );
  }
}
