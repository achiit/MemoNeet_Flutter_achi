// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

dialogForSubscription(BuildContext context,
    {NavigationViewModel? providerValue}) {
  final ref = FirebaseDatabase.instance.ref();
  final batchDetails =
      ref.child('users/${FirebaseAuth.instance.currentUser!.uid}/batch').get();
  Map<String, dynamic> plansData;
  var snapshot =
      FirebaseDatabase.instance.ref().child('metadata/server_time').get();

  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const CustomText(
        text: "Message",
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      content: const CustomText(
        text: 'You need to be a "premium user" to access this feature.',
        fontSize: 18.0,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: CustomText(
            text: "Okay",
            color: AppColors.blue,
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CupertinoDialogAction(
          child: CustomText(
            text: "Subscribe",
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);

            providerValue?.changePage(1);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CustomNavigationBar();
                },
              ),
            );
          },
        ),
      ],
    ),
  );
}
