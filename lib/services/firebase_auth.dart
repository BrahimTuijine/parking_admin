import 'package:firebase_auth/firebase_auth.dart';

class FireBase {
  static Future<UserCredential?> signInWithEmailAndPassword(
      {required String username, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return null;
      }
    }
    return null;
  }
}
