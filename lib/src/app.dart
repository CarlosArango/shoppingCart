import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/home/ui/home.dart';
import 'package:shopping_cart/src/resources/repositories/auth_repo.dart';

import 'resources/repositories/product_repo.dart';

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
          final AuthRepository authRepository = AuthRepository();
          final ProductRepository productRepository = ProductRepository();
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (context) => authRepository,
              ),
              RepositoryProvider<ProductRepository>(
                create: (context) => productRepository,
              ),
            ],
            child: MaterialApp(
              title: "Tulcart",
              home: HomeUI(),
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
