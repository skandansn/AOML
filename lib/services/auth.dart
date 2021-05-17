import 'package:firebase_auth/firebase_auth.dart';
import 'package:aumsodmll/models/user.dart';

class AuthService {
  FirebaseAuth auth;
  AuthService(){
    this.auth= FirebaseAuth.instance;
  }
  AuthService.instance({this.auth}){
     auth = FirebaseAuth.instance;
    }
  Userx _userFromFirebaseUser(User user) {
    return user != null ? Userx(uid: user.uid) : null;
  }

  // Stream<Userx> get user {
  //   return auth.authStateChanges().map(_userFromFirebaseUser);
  // }
  Stream<User> get user {
    return auth.authStateChanges();
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sinInWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e.toString();
    }
    return "";
  }
}
