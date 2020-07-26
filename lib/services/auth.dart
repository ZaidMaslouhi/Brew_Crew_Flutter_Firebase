import 'package:brew_crew_firebase/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew_firebase/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object basedon FirebaseUser
  User userFromFireaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFireaseUser);
//        .map((FirebaseUser user) => userFromFireaseUser(user));
  }

  // sign in anonymosly
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return userFromFireaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with Email and password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);
      return userFromFireaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // SignIn with Email and password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;
      return userFromFireaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
