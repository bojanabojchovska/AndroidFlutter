import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in anonymously
  Future<String> getUserId() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    return userCredential.user!.uid;
  }

  // Optional: Add other authentication methods here if needed
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
