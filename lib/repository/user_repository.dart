import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Authentication failed. Please try again.');
      }
    }
  }

  /// Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('Authentication failed. Please try again.');
      }
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
