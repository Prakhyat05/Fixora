import 'package:service/service/authentication.dart';

class FirebaseServices {
  final AuthServices _auth = AuthServices();

  Future<void> signInWithGoogle() async {
    await _auth.signInGoogle();
  }
}
