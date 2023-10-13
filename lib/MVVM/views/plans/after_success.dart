// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/urls.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../viewmodels/User/user_view_model.dart';

class AfterPayment extends StatefulWidget {
  final Map<String, dynamic>? data;
  const AfterPayment({super.key, required this.data});

  @override
  State<AfterPayment> createState() => _AfterPaymentState();
}

class _AfterPaymentState extends State<AfterPayment> {
  DatabaseReference first_name = FirebaseDatabase.instance.ref(
      "users/${FirebaseAuth.instance.currentUser!.uid}/first_name".toString());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => bottomsheet(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Thank you for your payment of  ',
                    ),
                    TextSpan(
                      text: "${widget.data!['price']} ",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const TextSpan(
                      text: 'on MemoNeet, ',
                    ),
                    TextSpan(
                      text:
                          '${Provider.of<UserViewModel>(context, listen: false).userModel!.firstName} ${Provider.of<UserViewModel>(context, listen: false).userModel!.lastName}.',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const TextSpan(
                      text:
                          ' We worked hard for you to make the Mock Test, this will MOTIVATE us more. When you use MemoNeet App next time, I hope you feel that it belongs to you. Because without you, and without the lots of people who come back to our app everyday, we would be nothing :)\n Happy Learning & All the best for your Exam!',
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'Best Wishes,\n --From MemoNeet Team',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: const Color.fromARGB(255, 117, 188, 246),
        child: InkWell(
          onTap: () {
            context.read<UserViewModel>().isSubscribedUser = true;

            Navigator.pushReplacementNamed(context, CustomNavigationBar.route);
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> bottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Thank you for Subscribing with us! Join our telegram channel for Daily Quizzes',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                ),
              ),
              20.verticalSpace,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Subscribe to our Youtube channel and Follow our Instagram for latest news and updates regarding NEET Exam!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (await launch(AppUrls.telegramUrl)) {
                        await launch(
                          AppUrls.telegramUrl,
                          universalLinksOnly: true,
                        );
                      } else {
                        throw 'There was a problem to open the url: ${AppUrls.telegramUrl}';
                      }
                    },
                    child: Image.asset(
                      AppImages.telegram,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  90.horizontalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(AppUrls.youtubeUrl)) {
                        await launch(
                          AppUrls.youtubeUrl,
                          universalLinksOnly: true,
                        );
                      } else {
                        throw 'There was a problem to open the url: ${AppUrls.youtubeUrl}';
                      }
                    },
                    child: Image.asset(
                      AppImages.youtube_logo,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  90.horizontalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(AppUrls.instaUrl)) {
                        await launch(
                          AppUrls.instaUrl,
                          universalLinksOnly: true,
                        );
                      } else {
                        throw 'There was a problem to open the url: ${AppUrls.instaUrl}';
                      }
                    },
                    child: Image.asset(
                      AppImages.instagram_logo,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
