import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  late final FirebaseAuth auth;

  Future<User?> loginWithGoogle() async {
    try {
      auth = FirebaseAuth.instance;

      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      final UserCredential userCredential =
          await auth.signInWithProvider(googleAuthProvider);
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
