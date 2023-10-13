// ignore_for_file: unused_field, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:memo_neet/MVVM/models/plans/plan_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/in_app_purchases/in_app_purchase.dart';

import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class BuyNow extends StatefulWidget {
  static const route = '/buy-now';
  final PlansModel? planData;
  const BuyNow({super.key, this.planData});

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  bool isChecked = true;
  bool isPurchaseLoading = false;

  List<String> otherInformationData = [
    "98% Questions in NEET 2022 exam came directly from MemoNeet app",
    "Full Access to all the Topics till Neet 2023",
    "30000+ intereactive type questions which helps to memorize the whole NCERT",
    "2000+ Assertion and Reasoning questions",
    "All Diagrammatic questions available from NCERT",
    "All years of Previous Year Questions available for Practice",
    "Unlimited Practice with our I-Repeat Algorithm",
    "Happy Learning & All the best for your Exam!",
    "Best Wishes --From MemoNeet Team",
  ];

  final List<String> _kProductIds = ['memoneetsub_1year'];
  final String testID = 'memoneetsub_1year';
  int expiry_date_time = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBarWithLeading(
        context: context,
        title: 'Payment',
        onLeadingPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 17.0,
          ),
          child: Column(
            children: [
              20.verticalSpace,
              // top headings
              Center(
                child: Column(
                  children: [
                    CustomText(
                      text: "Hey you Future Doctor!",
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontSize: 19.0,
                    ),
                    4.verticalSpace,
                    const CustomText(
                      text: "Thank you for subscribing with us",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ],
                ),
              ),
              33.verticalSpace,
              Column(
                children: [
                  const Row(
                    children: [
                      CustomText(
                        text: "Order Summary",
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffEDF9FE),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        16.verticalSpace,
                        ListTile(
                          minLeadingWidth: 10,
                          leading: const Icon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Color(0xff32840C),
                            size: 18,
                          ),
                          title: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Unlocked",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " NCERT Biology+NCERT Chemistry+NCERT Physics+Physics lectures for 1 year",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  // coupon text field
                  ExpansionTile(
                    title: const CustomText(
                      text: "Other Information",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    children: [
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: otherInformationData.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ListTile(
                              minLeadingWidth: 5,
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.circle,
                                size: 10,
                                color: AppColors.primaryColor,
                              ),
                              title: CustomText(
                                text: otherInformationData[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              20.verticalSpace,
              // checkbox section
              // ListTile(
              //   minLeadingWidth: 10,
              //   leading: Checkbox(
              //     fillColor: MaterialStatePropertyAll(AppColors.primaryColor),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(2)),
              //     value: isChecked,
              //     onChanged: (bool? value) {
              //       setState(() {
              //         isChecked = value!;
              //       });
              //     },
              //   ),
              //   title: CustomText(
              //       fontSize: 16.0,
              //       fontWeight: FontWeight.w400,
              //       text:
              //           "Add unlimited test series(Full Length tests+Subjectwise test+Unitwise Tests+Topicwise tests) with additional Rs.1099(25% Discount)"),
              // ),

              30.verticalSpace,
              // product total section
              Column(
                children: [
                  const Row(
                    children: [
                      CustomText(
                        text: "Product Total",
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "GST",
                          // ),
                          // 16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "CGST",
                          // ),
                          // 16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "SGST",
                          // ),
                          // 16.verticalSpace,
                          const CustomText(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            text: "Subtotal",
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "₹ 40",
                          // ),
                          // 16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "₹ 54",
                          // ),
                          // 16.verticalSpace,
                          // const CustomText(
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w400,
                          //   text: "₹ 60",
                          // ),
                          // 16.verticalSpace,
                          CustomText(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            text: widget.planData?.displayPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Total Amount",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: widget.planData?.displayPrice,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      color: (context
                              .watch<InAppPurchaseManager>()
                              .isPurchaseLoading)
                          ? AppColors.grey
                          : AppColors.primaryColor,
                      onPressed: () async {
                        if (context
                                .read<InAppPurchaseManager>()
                                .isPurchaseLoading ==
                            false) {
                          ProductDetails product =
                              context.read<InAppPurchaseManager>().products[0];
                          await context
                              .read<InAppPurchaseManager>()
                              .buyProduct(context, product);
                        } else {
                          showSnackBar(
                              context: context,
                              message: 'Purchase in progress');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (context
                              .watch<InAppPurchaseManager>()
                              .isPurchaseLoading) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          ],
                          CustomText(
                              text: (context
                                      .watch<InAppPurchaseManager>()
                                      .isPurchaseLoading)
                                  ? "Please wait..."
                                  : "Pay Now",
                              color: AppColors.white),
                        ],
                      )),
                  30.verticalSpace,
                ],
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
