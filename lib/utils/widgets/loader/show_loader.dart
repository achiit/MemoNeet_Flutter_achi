import 'package:flutter/material.dart';
import 'package:memo_neet/constants/images.dart';

showLoader(context) {
  showDialog(
      context: context,
      builder: (context) => Stack(children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 75,
                  width: 75,
                  child: const CircularProgressIndicator(),
                )),
            Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Image.asset(
                      AppImages.appIcon,
                      height: 60,
                    ),
                  ),
                )),
          ]));
}
