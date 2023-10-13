// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously, invalid_use_of_visible_for_testing_member, unused_field, avoid_print

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/base/base_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/phone_verification/otp_screen.dart';

import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/repo/user_services.dart';
import 'package:memo_neet/utils/widgets/loader/loader.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:uiblock/uiblock.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth;
  final _firebaseAuth = FirebaseAuth.instance;
  AuthService(this._auth);
//Phone Sign in

  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
    String countryCode,
    String countryiso,
  ) async {
    // TextEditingController codeController = TextEditingController();
    UIBlock.block(
      context,
      childBuilder: (context) => const Loader(),
    );
    await _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log("navigating to custom navigation bar");
          _auth
              .signInWithCredential(credential)
              .then((result) {})
              .catchError((e) {
            print(e);
          });
        },
        verificationFailed: (e) {
          UIBlock.unblock(context);

          // Get.snackbar("Error", "Verification Failed!");
          showSnackBar(context: context, message: e.message!);
        },
        codeSent: ((String verificationID, int? resendToken) async {
          UIBlock.unblock(context);

          showSnackBar(
              context: context,
              message: "Otp has been sent to your phone number");
          PageNavigator(ctx: context).nextPage(
              page: OtpScreen(
            countryCode: countryCode,
            countryiso: countryiso,
            verificationId: verificationID,
            phoneNumber: phoneNumber,
          ));
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          UIBlock.unblock(context);
          showSnackBar(context: context, message: "verification failed");

          // Get.snackbar("Message", "Code auto retrieval Timeout");
          //Auto-resolution timed out...
        });
  }

  Future<void> googleSignInMethod(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await signInWithGoogle(context, credential);
    } catch (e) {
      showSnackBar(context: context, message: "Unable to continue with google");
      log(e.toString());
    }
  }

  //google sign in
  Future<void> signInWithGoogle(
      BuildContext context, AuthCredential credential) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          var authVm = Provider.of<AuthViewModel>(context, listen: false);
          authVm.isGuestUser = false;
          authVm.userModel = await UserServices().getUserInfo(context);
          authVm.notifyListeners();

          Provider.of<NavigationViewModel>(context, listen: false)
              .changePage(0);
          context.read<UserViewModel>().emailController.text =
              value.user!.email!;
          context.read<UserViewModel>().firstnameController.text =
              value.user!.displayName!.split(" ")[0];
          context.read<UserViewModel>().secondnameController.text =
              value.user!.displayName!.split(" ")[1];
          Navigator.pushNamedAndRemoveUntil(
              context, CustomNavigationBar.route, (route) => false);
          Constant.prefs.setBool(SharedPrefsHelper.loggedIn, true);
          Constant.prefs.setBool(SharedPrefsHelper.isGuestUser, false);
        }
      });
    } on Exception catch (e) {
      debugPrintStack();
      log(e.toString());
      GoogleSignIn().signOut();
    }
  }

// getting profile pic
  getProfileImage() {
    if (_auth.currentUser?.photoURL != null) {
      return Image.network(_auth.currentUser!.photoURL.toString());
    } else {
      return const Icon(Icons.account_circle);
    }
  }

// signing as guest
  void signInAsGuest(BuildContext context) async {
    try {
      UIBlock.block(
        context,
        loadingTextWidget: const CustomText(text: "Logging In.."),
        childBuilder: (context) => const Loader(),
      );
      await FirebaseAuth.instance.signInAnonymously().then((value) {
        Constant.prefs.setBool(SharedPrefsHelper.isGuestUser, true);
        Constant.prefs.setBool(SharedPrefsHelper.loggedIn, true);

        UIBlock.unblock(context);
        showSnackBar(context: context, message: "Signed in as Guest");
        Navigator.pushReplacementNamed(context, CustomNavigationBar.route);
      });
    } on Exception catch (e) {
      UIBlock.unblock(context);
      debugPrintStack();
      log(e.toString());
    }
  }

// sign in with apple
  Future<User> signInWithApple(BuildContext context,
      {List<Scope> scopes = const [Scope.fullName, Scope.email]}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user;
        Constant.prefs.setString(
            'firstName', appleIdCredential.fullName?.givenName ?? '');
        Constant.prefs.setString(
            'lastName', appleIdCredential.fullName?.familyName ?? '');
        var authVm = Provider.of<AuthViewModel>(context, listen: false);
        var baseVM = Provider.of<BaseViewModel>(context, listen: false);

        authVm.userModel = await UserServices().getUserInfo(context);
        authVm.notifyListeners();
        log('message ${authVm.userModel?.firstName}');
        authVm.userModel?.firstName = appleIdCredential.fullName?.givenName;
        authVm.userModel?.lastName = appleIdCredential.fullName?.familyName;
        authVm.userModel?.emailId = appleIdCredential.email;
        authVm.isSocialLogin = true;
        authVm.notifyListeners();
        baseVM.notifyListeners();
        if (Constant.prefs.getBool(SharedPrefsHelper.isNewUser) == false ||
            Constant.prefs.getBool(SharedPrefsHelper.isNewUser) == null) {
          Constant.prefs.setBool(SharedPrefsHelper.isNewUser, true);
        }
        authVm.isGuestUser = false;
        authVm.notifyListeners();
        context.read<UserViewModel>().emailController.text =
            appleIdCredential.email ?? "";
        context.read<UserViewModel>().firstnameController.text =
            appleIdCredential.fullName?.givenName ?? '';
        {}
        context.read<UserViewModel>().secondnameController.text =
            appleIdCredential.fullName?.familyName ?? "";
        log(appleIdCredential.fullName?.givenName ?? 'n/a');
        Navigator.pushReplacementNamed(context, CustomNavigationBar.route);
        Constant.prefs.setBool(SharedPrefsHelper.loggedIn, true);
        Constant.prefs.setBool(SharedPrefsHelper.isGuestUser, false);

        return firebaseUser!;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());
      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      default:
        throw UnimplementedError();
    }
  }

  // delete user data
  Future deleteUser() async {
    try {
      await FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(_auth.currentUser!.uid)
          .remove();
      await _auth.currentUser!.delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
