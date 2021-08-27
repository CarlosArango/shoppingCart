import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  Future<UserCredential> signInAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }
}
