import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/home/blocs/products/products_bloc.dart';
import 'package:shopping_cart/src/modules/home/ui/home.dart';
import 'package:shopping_cart/src/resources/providers/firestore_product_prov.dart';
import 'package:shopping_cart/src/resources/repositories/product_repo.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Error", textDirection: TextDirection.ltr);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProductsBloc>(
                create: (context) => ProductsBloc(
                  productRepository: ProductRepository(
                    firestoreProductProvider: FirestoreProductProvider(),
                  ),
                )..add(
                    ProductsLoad(),
                  ),
              ),
            ],
            child: MaterialApp(
              title: "Tulcart",
              initialRoute: '/',
              routes: {
                // When navigating to the "/" route, build the FirstScreen widget.
                '/': (context) => const HomeUI(),
              },
            ),
          );
        }

        return Text(
          "Loading...",
          textDirection: TextDirection.ltr,
        );
      },
    );
  }
}
