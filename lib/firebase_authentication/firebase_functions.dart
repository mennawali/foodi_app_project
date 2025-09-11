import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(credential.user!.uid).get();

      if (userDoc.exists) {
        String username = userDoc['username'];
        await credential.user?.updateDisplayName(username);
        await credential.user?.reload();
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> createAccount(
      String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(username);
      await credential.user?.reload();
      await credential.user?.sendEmailVerification();

      UserModel userModel = UserModel(
        uid: credential.user!.uid,
        email: email,
        username: username,
      );

      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
