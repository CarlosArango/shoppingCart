part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAutomatically extends AuthEvent {
  const AuthAutomatically();

  @override
  String toString() => 'AuthAutomatically';

  @override
  List<Object> get props => [];
}
