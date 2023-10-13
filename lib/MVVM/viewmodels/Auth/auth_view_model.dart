// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
import 'package:memo_neet/constants/constant.dart';
import 'dart:async';

import 'package:memo_neet/repo/auth_services.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  bool? _isGuestUser = true;
  get isGuestUser => _isGuestUser;
  set isGuestUser(value) {
    _isGuestUser = value;
    notifyListeners();
  }

  bool isSocialLogin = false;
  UserModel? userModel = UserModel();
  bool userModelNull = true;
  int timerMaxSeconds = 60;
  int currentSeconds = 0;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  StreamSubscription? userStream;

  void signInAsGuest(BuildContext context) async {
    AuthService(firebaseAuth).signInAsGuest(context);
    _isGuestUser = true;
  }

  void phoneSignIn({
    required BuildContext context,
    required String phoneNumber,
    required String countryCode,
    required String countryiso,
  }) async {
    try {
      await AuthService(firebaseAuth)
          .phoneSignIn(context, phoneNumber, countryCode, countryiso);
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      await AuthService(firebaseAuth).googleSignInMethod(context);
      update();
    } catch (e) {
      showSnackBar(context: context, message: "Unable to continue with google");
      debugPrintStack();
      log(e.toString());
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      Constant.prefs = await SharedPreferences.getInstance();
      Constant.prefs.clear();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
      return false;
    }
  }

  Future<bool> deleteAccount(BuildContext context) async {
    try {
      Constant.prefs = await SharedPreferences.getInstance();
      Constant.prefs.clear();

      await FirebaseAuth.instance.currentUser!.delete();
      return true;
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
      return false;
    }
  }

  void update() {
    notifyListeners();
  }
}
