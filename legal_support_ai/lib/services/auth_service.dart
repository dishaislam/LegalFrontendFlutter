import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get ID Token
  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
