import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/resources/repositories/auth_repo.dart';

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
      ],
      child: MaterialApp(
        title: "Tulcart",
        routes: routes.mainRoute(),
        onGenerateRoute: routes.generateRoute,
        onUnknownRoute: routes.unknownRoute,
        initialRoute: routes.MainRoute,
      ),
    );
  }
}
