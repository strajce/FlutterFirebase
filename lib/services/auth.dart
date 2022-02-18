import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basic_example/models/user_model.dart';
import 'package:firebase_basic_example/services/firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create user object based on Firebase User
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uuid: user.uid) : null;
  }

  //auth change user strem
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sing in anon
  Future signInAnonymously() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User? _user = result.user;
      return _userFromFirebaseUser(_user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sing in with email & password
  Future singInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // register
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;

      // create a new document for the user with the uid
      await FirestoreService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sing out
  Future singOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}
