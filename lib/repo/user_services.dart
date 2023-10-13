// User related firebase servicesimport 'dart:developer';

// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:provider/provider.dart';

class UserServices {
  Future createUser(UserModel userModel) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users")
        .child(FirebaseAuth.instance.currentUser?.uid.toString() ?? '');

    await ref.set({
      "first_name": userModel.firstName,
      "app_version": AppStrings.appVersion,
      "last_name": userModel.lastName,
      "email_id": userModel.emailId,
      "country": userModel.country,
      "device_model": userModel.deviceModel,
      "mobile_number": userModel.mobileNumber,
      "parent_mobile_number": userModel.parentMobileNumber,
      "os": "ios",
      "state": userModel.state,
      "batch": userModel.batch,
      "datetime": DateTime.now().millisecondsSinceEpoch,
      "uuid": FirebaseAuth.instance.currentUser?.uid,
      "repeater": userModel.isRepeater,
    });
    return userModel;
  }

  Future updateUserInfo(UserModel userModel) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users")
        .child(FirebaseAuth.instance.currentUser?.uid.toString() ?? '');

    // Convert UserModel to Map
    final Map<String, dynamic> userMap = userModel.toJson();

    // Remove the properties with null values (if any)
    userMap.removeWhere((key, value) => value == null);

    // Perform the update
    await ref.update(userMap);
  }

  Future getUserInfo(BuildContext context) async {
    log("getUserInfo: user_services.dart");
    UserModel userModel = UserModel();
    var authVm = Provider.of<AuthViewModel>(context, listen: false);
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final snapshot = await FirebaseDatabase.instance
            .ref("users")
            .child(FirebaseAuth.instance.currentUser?.uid.toString() ?? '')
            .get();

        if (snapshot.value != null) {
          userModel.paymentDetails = PaymentDetails();
          userModel = UserModel.fromJson(snapshot.value);
          authVm.userModelNull = false;
          print(userModel.toJson());
          return userModel;
        } else {
          log("message: user not found");
          authVm.userModelNull = true;
        }
      }
    } catch (e) {
      debugPrintStack();
      log(e.toString());
    }
  }

  Future userSubscription({
    required double price,
  }) async {
    int serverTime = await getMetaData();
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("users")
        .child(FirebaseAuth.instance.currentUser!.uid.toString());
    await ref.update({
      "payment_details": {
        "datetime": serverTime,
        "payment": price,
        "premium": price
      },
    });
  }

  Future<int> getMetaData() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("metadata").child("server_time");
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      return snapshot.value as int;
    }
    return 0;
  }
}
