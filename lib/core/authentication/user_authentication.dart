import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimonie/core/service/user_service.dart';
import 'package:patrimonie/model/user_model.dart';

class AuthServiceUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<String?> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-mail adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Users user = Users(
        userID: userCredential.user!.uid,
        email: email,
        password: password,
      );
      await _userService.createUser(user);

      Fluttertoast.showToast(
        msg: "Kayıt işlemi başarılı",
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Uyarı: $e", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  Future<String?> signInUser(
      {required String email, required String password}) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen email adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: "Giriş işlemi başarılı",
        toastLength: Toast.LENGTH_SHORT,
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Uyarı: $e", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    final navigator = Navigator.of(context);
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-posta adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return;
      }
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "E-posta adresinize bir şifre sıfırlama isteği gönderildi",
        toastLength: Toast.LENGTH_LONG,
      );
      navigator.pop();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Uyarı: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> deleteUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      await _auth.currentUser!.delete();

      await _userService.deleteUser(uid);

      Fluttertoast.showToast(
        msg: "Kullanıcı hesabı başarıyla silindi.",
        toastLength: Toast.LENGTH_LONG,
      );

      await signOutUser();
    } catch (e) {
      print("HATA: ${e.toString()}");
      Fluttertoast.showToast(
        msg: "Kullanıcı hesabını silerken bir hata oluştu.",
        toastLength: Toast.LENGTH_LONG,
      );

      return;
    }
  }

  Future<void> updateUserInformation({
    required String newEmail,
    required String newPassword,
  }) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        await currentUser.updateEmail(newEmail);
        await currentUser.updatePassword(newPassword);

        Users? user = await _userService.getUser();

        if (user != null) {
          user.email = newEmail;
          user.password = newPassword;
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Uyarı: $e", toastLength: Toast.LENGTH_LONG);
    }
  }
}
