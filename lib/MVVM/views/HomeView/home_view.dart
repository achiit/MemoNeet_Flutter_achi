// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memo_neet/MVVM/models/banner/banner_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/banner_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/settings/contact_support.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/repo/firebase_database_services.dart';
import 'package:memo_neet/utils/widgets/home_page/subjects_card.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  BannerAd? _banner;

  AdHelper adHelper = AdHelper();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final navigationProvider =
          Provider.of<NavigationViewModel>(context, listen: false);
      context.read<SubjectViewModel>().getSubjects();
      Future.delayed(const Duration(seconds: 3), () {
        _banner = adHelper.createBannerAd()..load();
        navigationProvider.showBottomNavBar();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = context.watch<BannerProvider>();
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final navigationProvider = Provider.of<NavigationViewModel>(context);

    if (shortestSide < 600) {
      // mobile view
      return mobileView(context, bannerProvider, navigationProvider);
    } else {
      // tablet view
      return tabletView(context, bannerProvider, navigationProvider);
    }
  }

  Scaffold tabletView(BuildContext context, BannerProvider bannerProvider,
      NavigationViewModel navigationProvider) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // ################# MY PROGRESS CARD #################
                // myProgressCard(),

                // ################# MY OFFERS BANNER #################
                myOffersBannerForTablet(context, bannerProvider),
                //  ################### SUBJECTS SECTION ##################
                subjectsSectionForTablet(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: navigationProvider.shouldShowBottomNavBar
          ? _banner != null && !context.watch<UserViewModel>().isSubscribedUser
              ? Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: _banner!),
                )
              : const SizedBox()
          : const SizedBox(),
    );
  }

  Scaffold mobileView(BuildContext context, BannerProvider bannerProvider,
      NavigationViewModel navigationProvider) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // ################# MY PROGRESS CARD #################
                // myProgressCard(),

                // ################# MY OFFERS BANNER #################
                myOffersBanner(context, bannerProvider),
                //  ################### SUBJECTS SECTION ##################
                subjectsSection(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: navigationProvider.shouldShowBottomNavBar
          ? _banner != null && !context.watch<UserViewModel>().isSubscribedUser
              ? Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: _banner!),
                )
              : const SizedBox()
          : const SizedBox(),
    );
  }

  // Padding myProgressCard() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8),
  //         boxShadow: [
  //           BoxShadow(
  //             color: const Color(0xFF818181).withOpacity(0.3),
  //             offset: const Offset(4, 1),
  //             blurRadius: 24,
  //             spreadRadius: 0,
  //           ),
  //         ],
  //       ),
  //       width: double.infinity,
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.only(left: 16.0, top: 20),
  //                 child: CustomText(
  //                   text: AppStrings.myProgress,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 18.0,
  //                   color: AppColors.headingColor,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           CircularPercentIndicator(
  //             backgroundColor: AppColors.grey,
  //             radius: 60.0,
  //             lineWidth: 5.0,
  //             percent: 0,
  //             center: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const CustomText(
  //                   text: AppStrings.progress,
  //                   fontWeight: FontWeight.w300,
  //                   fontSize: 8.6,
  //                 ),
  //                 CustomText(
  //                   textAlign: TextAlign.center,
  //                   text:
  //                       '${(calculatePercentage(selectedIndex) * 100).toInt()}%',
  //                   fontSize: 22.6,
  //                 ),
  //               ],
  //             ),
  //             progressColor: AppColors.primaryColor,
  //           ),
  //           20.verticalSpace,
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedIndex = 0;
  //                   });
  //                 },
  //                 child: CustomText(
  //                   text: AppStrings.biology,
  //                   color: selectedIndex == 0
  //                       ? AppColors.primaryColor
  //                       : AppColors.black,
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedIndex = 1;
  //                   });
  //                 },
  //                 child: CustomText(
  //                   color: selectedIndex == 1
  //                       ? AppColors.primaryColor
  //                       : AppColors.black,
  //                   text: AppStrings.physics,
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedIndex = 2;
  //                   });
  //                 },
  //                 child: CustomText(
  //                   color: selectedIndex == 2
  //                       ? AppColors.primaryColor
  //                       : AppColors.black,
  //                   text: AppStrings.chemistry,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           15.verticalSpace,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Column subjectsSection(BuildContext context) {
    return Column(
      children: [
        30.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.subjects,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: AppColors.headingColor,
              ),
            ],
          ),
        ),
        16.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: context.watch<SubjectViewModel>().isQuestionLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(
                      size: 24,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      text: AppStrings.questionsLoading,
                      color: AppColors.primaryColor,
                    )
                  ],
                )
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: context.watch<SubjectViewModel>().subjects.isEmpty
              ? const SizedBox()
              : Consumer<SubjectViewModel>(
                  builder: (context, subjectViewModel, child) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subjectViewModel.subjects.length,
                    itemBuilder: (context, index) {
                      return SubjectsCard(index: index);
                    },
                  );
                }),
        ),
      ],
    );
  }

  Column myOffersBanner(BuildContext context, BannerProvider bannerProvider) {
    return Column(
      children: [
        30.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.offers,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: AppColors.headingColor,
              ),
              OutlinedButton(
                  child: CustomText(
                    text: AppStrings.contactUs,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const ContactSupport());
                  })
            ],
          ),
        ),
        10.verticalSpace,
        // #################  BANNER SECTION ####################
        FutureBuilder(
          future: FirebaseDatabaseServices().getBanners(),
          builder: (context, AsyncSnapshot snapshot) {
            dynamic banners = snapshot.data;
            if (snapshot.data == null) {
              return Center(
                child: SpinKitChasingDots(
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              );
            }
            return Stack(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(milliseconds: 4000),
                    onPageChanged: (index, reason) {
                      bannerProvider.activeIndex = index;
                    },
                  ),
                  itemCount: banners.length,
                  itemBuilder: (context, index, realIndex) {
                    BannersModel bannerData = banners[index];
                    String urlImage = bannerData.image;
                    return InkWell(
                      onTap: () async {
                        String url = bannerData.link;
                        await launchUrl(Uri.parse(url));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: CachedNetworkImageProvider(urlImage),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedSmoothIndicator(
                      activeIndex: bannerProvider.activeIndex,
                      count: banners.length,
                      effect: const JumpingDotEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // tablet view

  Column subjectsSectionForTablet(BuildContext context) {
    return Column(
      children: [
        30.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.subjects,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: AppColors.headingColor,
              ),
            ],
          ),
        ),
        16.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: context.watch<SubjectViewModel>().isQuestionLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitChasingDots(
                      size: 24,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      text: AppStrings.questionsLoading,
                      color: AppColors.primaryColor,
                    )
                  ],
                )
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: context.watch<SubjectViewModel>().subjects.isEmpty
              ? const SizedBox()
              : Consumer<SubjectViewModel>(
                  builder: (context, subjectViewModel, child) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5 / 2,
                      crossAxisCount: 3, // Set the number of columns you want
                      // crossAxisSpacing: 8, // Adjust spacing between columns
                      // mainAxisSpacing: 8, // Adjust spacing between rows
                    ),
                    itemCount: subjectViewModel.subjects.length,
                    itemBuilder: (context, index) {
                      return SubjectsCard(index: index);
                    },
                  );
                }),
        ),
      ],
    );
  }

  Column myOffersBannerForTablet(
      BuildContext context, BannerProvider bannerProvider) {
    return Column(
      children: [
        30.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.offers,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: AppColors.headingColor,
              ),
              OutlinedButton(
                  child: CustomText(
                    text: AppStrings.contactUs,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const ContactSupport());
                  })
            ],
          ),
        ),
        10.verticalSpace,
        // #################  BANNER SECTION ####################
        FutureBuilder(
          future: FirebaseDatabaseServices().getBanners(),
          builder: (context, AsyncSnapshot snapshot) {
            dynamic banners = snapshot.data;
            if (snapshot.data == null) {
              return Center(
                child: SpinKitChasingDots(
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              );
            }
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(milliseconds: 4000),
                      onPageChanged: (index, reason) {
                        bannerProvider.activeIndex = index;
                      },
                    ),
                    itemCount: banners.length,
                    itemBuilder: (context, index, realIndex) {
                      BannersModel bannerData = banners[index];
                      String urlImage = bannerData.image;
                      return InkWell(
                        onTap: () async {
                          String url = bannerData.link;
                          await launchUrl(Uri.parse(url));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: CachedNetworkImageProvider(
                              urlImage,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedSmoothIndicator(
                      activeIndex: bannerProvider.activeIndex,
                      count: banners.length,
                      effect: const JumpingDotEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
