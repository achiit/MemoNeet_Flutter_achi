// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/SubTopicView/subtopic_card.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:provider/provider.dart';

class SubTopicView extends StatefulWidget {
  static const String route = "/sub-topic-view";
  const SubTopicView({super.key});

  @override
  State<SubTopicView> createState() {
    return _SubTopicViewState();
  }
}

class _SubTopicViewState extends State<SubTopicView>
    with TickerProviderStateMixin {
  DateTime? expiryDate;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(context);
    } else {
      return tabletView(context);
    }
  }

  Scaffold tabletView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBar(
          context: context,
          title:
              context.read<SubjectViewModel>().selectedTopicModel!.topicName),
      body: (context.watch<SubjectViewModel>().subTopics.isEmpty)
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: const Text(
                      AppStrings.nothingHere,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AppImages.notFoundDog,
                  ),
                )
              ],
            )
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 7.5,
                crossAxisCount: 2, // Adjust the number of columns as needed
                crossAxisSpacing: 10.0, // Adjust the horizontal spacing
                mainAxisSpacing: 10.0, // Adjust the vertical spacing
              ),
              itemCount: context.read<SubjectViewModel>().subTopics.length,
              itemBuilder: (BuildContext context, int index) {
                return SubTopicCard(index: index);
              },
            ),
    );
  }

  Scaffold mobileView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBar(
          context: context,
          title:
              context.read<SubjectViewModel>().selectedTopicModel!.topicName),
      body: (context.watch<SubjectViewModel>().subTopics.isEmpty)
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: const Text(
                      AppStrings.nothingHere,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AppImages.notFoundDog,
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  children: List.generate(
                      context.read<SubjectViewModel>().subTopics.length,
                      (index) {
                    if (index ==
                        context.read<SubjectViewModel>().subTopics.length - 1) {
                      return Column(
                        children: [
                          SubTopicCard(
                            index: index,
                          ),
                          60.verticalSpace,
                        ],
                      );
                    }
                    return SubTopicCard(
                      index: index,
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
