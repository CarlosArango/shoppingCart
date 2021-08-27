import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/global_blocs/auth/auth_bloc.dart';
import 'package:shopping_cart/src/modules/home/ui/home.dart';

const String MainRoute = '/';
const String CartRoute = 'cart';
Map<String, Widget Function(BuildContext)> mainRoute() {
  return {
    MainRoute: (context) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state.authStatus == AuthStatus.authenticated) {
            return HomeUI();
          }

          return Container(child: Text("Not authenticated"));
        },
      );
    }
  };
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CartRoute:
      return MaterialPageRoute(
        builder: (context) => Container(),
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