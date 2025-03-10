import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> createAccountwithEmail(
      String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      DbService().saveUserData(name: name, email: email);
      return "Account is created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return "Login Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await resetFirebaseAuth();
      await _auth.currentUser?.reload();
      print("Logged out of Firebase and Google");
    } catch (e) {
      print("Error during logout: $e");
    }
  }
Future<void> resetFirebaseAuth() async {
    await _auth.setPersistence(Persistence.NONE);
    await _auth.signOut();
  }
  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Mail Sent";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();


    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the Google sign-in
        return "Google sign-in canceled";
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      return "Google sign-in successful";
    } catch (e) {
      return "Error occurred during Google sign-in: $e";
    }
  }

  
}
