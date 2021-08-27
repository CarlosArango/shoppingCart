import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/home/blocs/products/products_bloc.dart';
import 'package:shopping_cart/src/modules/home/widget/product_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: state.products[index].data(),
            );
          },
        );
      },
    );
  }
}
