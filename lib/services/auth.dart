import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String email;
  User({required this.uid, required this.email});
}

class Auth {
  final _auth = FirebaseAuth.instance;

  User? _userFromFirebase(user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid, email: user.email);
    }
  }

  Future<User?> currentUser() async {
    final user = _auth.currentUser;
    return _userFromFirebase(user);
  }

  Future<void> deleteUser() async {
    return _auth.currentUser!.delete();
  }

  Stream<User?> get onAuthChange {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInAnno() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signIn(String email, String password) async {
    final userCredentail = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredentail.user);
  }

  Future<User?> signUp(String email, String password) async {
    UserCredential userCredentail = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredentail.user);
  }

  // Future<User> signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser?.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   final UserCredential authResult =
  //       await _auth.signInWithCredential(credential);
  //   return _userFromFirebase(authResult.user);
  // }
}
