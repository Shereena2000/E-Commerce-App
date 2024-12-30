import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String> createAccountwithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
    await FirebaseAuth.instance.signOut();
  }

  Future resetPassword(String email) async {
   try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Mail Sent";
   }on FirebaseAuthException catch (e) {
     return e.message.toString();
   }
  }


  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
