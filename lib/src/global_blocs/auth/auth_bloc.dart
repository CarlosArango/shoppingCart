import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/user.dart';
import 'package:shopping_cart/src/resources/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          AuthState(
            failureMsg: "",
            authStatus: AuthStatus.unauthenticate,
            user: User(),
          ),
        );

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthAutomatically) {
      yield* mapAuthAutomaticallyToState(event);
    }
  }

  Stream<AuthState> mapAuthAutomaticallyToState(
      AuthAutomatically event) async* {
    try {
      print("entre here");
      final userCredential = await _authRepository.signInAnonymously();

      yield AuthState(
        user: User(
          id: userCredential!.user!.uid,
          name: userCredential.user?.displayName,
        ),
        failureMsg: '',
        authStatus: AuthStatus.authenticated,
      );
    } catch (e) {
      print(e);
      yield state.copyWith(
        authStatus: AuthStatus.failure,
        failureMsg: e.toString(),
      );
    }
  }
}
