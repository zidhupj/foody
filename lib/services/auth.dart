import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get currentUser => _auth.currentUser;

  Stream<User?> get user {
    return _auth.userChanges();
  }

  Future signIn(String email, String password) async {
    UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = userCred.user;
    return user;
  }

  Future signUp(String email, String password) async {
    UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCred.user;

    return user;
  }

  Future<bool> editName(String name) async {
    if (_auth.currentUser != null) {
      try {
        await _auth.currentUser!.updateDisplayName(name);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}
