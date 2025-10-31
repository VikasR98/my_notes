import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes/model/auth_result.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign_up
  Future<AuthResult> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(user: cred.user);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email is already registered.';
          break;
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        default:
          message = 'Sign-up failed. Please try again.';
      }

      return AuthResult(error: message);
    } catch (e) {
      return AuthResult(error: 'Unexpected error: $e');
    }
  }

  // sign-in
  Future<AuthResult> signIn(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(user: cred.user);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'user-not-found':
          message = 'No account found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        case 'invalid-credential':
          message = 'Invalid credentials';
          break;
        default:
          message = 'Login failed. Please try again.';
      }
      return AuthResult(error: message);
    } catch (e) {
      return AuthResult(error: 'Unexpected error: $e');
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
