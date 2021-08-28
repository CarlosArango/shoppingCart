import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_cart/src/resources/providers/firebase_auth_prov.dart';

class AuthRepository {
  final FirebaseAuthProvider? _firebaseAuthProvider;
  AuthRepository({
    FirebaseAuthProvider? firebaseAuthProvider,
  }) : _firebaseAuthProvider = firebaseAuthProvider ?? FirebaseAuthProvider();

  Future<UserCredential?> signInAnonymously() async {
    return await _firebaseAuthProvider?.signInAnonymously();
  }
}
