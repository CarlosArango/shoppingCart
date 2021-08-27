part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticate,
  failure,
}

class AuthState extends Equatable {
  final User user;
  final AuthStatus authStatus;
  final String failureMsg;

  const AuthState({
    required this.user,
    required this.failureMsg,
    required this.authStatus,
  });

  @override
  String toString() =>
      "AuthState{user:$user, authStatus:$authStatus, failureMsg:$failureMsg}";

  @override
  List<Object> get props => [
        user,
        authStatus,
        failureMsg,
      ];

  AuthState copyWith({
    User? user,
    AuthStatus? authStatus,
    String? failureMsg,
  }) =>
      AuthState(
        user: user ?? this.user,
        authStatus: authStatus ?? this.authStatus,
        failureMsg: failureMsg ?? this.failureMsg,
      );
}
