import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepo {
  //TODO: implement login sessions
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSign = GoogleSignIn();

  Stream<bool> signup(String email, String password) {
    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .asStream()
        .map((_) => true)
        .onErrorReturnWith((error, stackTrace) {
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    });
  }

  Stream<bool> login(String email, String password) {
    return auth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream()
        .map((_) => true)
        .onErrorReturnWith((error, stackTrace) {
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    });
  }

  Stream<bool> signOut() {
    return auth
        .signOut()
        .asStream()
        .map((event) => true)
        .onErrorReturnWith((error, stackTrace) {
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    });
  }

  Stream<User?> get currentUser => auth.userChanges();
}
