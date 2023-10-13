// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, avoid_print, use_build_context_synchronously

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';

import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/repo/user_services.dart';
import 'package:memo_neet/utils/widgets/login/dropdown_button_country.dart';
import 'package:memo_neet/utils/widgets/login/top_cover.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  static const route = "/otp-screen";
  final String phoneNumber;
  String verificationId;
  final String countryCode;
  final String countryiso;
  OtpScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
    required this.countryCode,
    required this.countryiso,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var country = '91';
  var countryiso = 'IN';
  // function for phone sign in
  Future<bool> onVerify() async {
    // ZBotToast.loadingShow();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.trim());

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      Constant.prefs = await SharedPreferences.getInstance();
      if (value.user != null) {
        var authVm = Provider.of<AuthViewModel>(context, listen: false);
        authVm.isGuestUser = false;
        authVm.userModel = await UserServices().getUserInfo(context);
        authVm.notifyListeners();
        Constant.prefs.setBool(SharedPrefsHelper.loggedIn, true);
        Constant.prefs.setBool(SharedPrefsHelper.isGuestUser, false);
        context.read<UserViewModel>().phoneController.text =
            value.user!.phoneNumber.toString();
        Provider.of<NavigationViewModel>(context, listen: false).changePage(0);
        Navigator.pushNamedAndRemoveUntil(
            context, CustomNavigationBar.route, (route) => false);
        return true;
      }
    }).onError((error, stackTrace) {
      print(error);
      UIBlock.unblock(context);
      if (error.toString().contains("invalid-verification-code")) {
        showSnackBar(context: context, message: "Invalid OTP");
      } else {
        showSnackBar(context: context, message: error.toString());
      }
      // ZBotToast.loadingClose();
      return false;
    });
    return false;
  }

  // Function to resend OTP to the user's phone number
  Future<void> _resendOTP() async {
    String phoneNumber = phoneController.text.trim();

    // Perform the phone number verification again to get a new OTP
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure if needed
      },
      codeSent: (String verificationId, int? resendToken) {
        // OTP sent successfully
        setState(() {
          widget.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout:
          const Duration(seconds: 60), // Adjust the timeout duration as needed.
    );
  }

  @override
  void initState() {
    phoneController.text = widget.phoneNumber;
    super.initState();
  }

// import 'package:firebase_auth/firebase_auth.dart';

// // Function to resend OTP to the user's phone number
// Future<void> resendOTPToPhoneNumber(String phoneNumber) async {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) {
//     // This callback will be triggered when auto-verification of the phone number is done on Android devices.
//     // In this case, you can sign in the user directly using the provided credential.
//     // You might not need this callback for OTP-based verification.
//   };

//   PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
//     // Handle the verification failure here.
//     print('Verification Failed: ${e.message}');
//   };

//   PhoneCodeSent codeSent = (String verificationId, int? resendToken) async {
//     // OTP sent successfully
//     // Save the verificationId somewhere (e.g., in the state or a provider) to use it later when the user enters the OTP.
//     print('Verification ID: $verificationId');
//   };

//   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
//     // This callback will be triggered after the OTP is automatically retrieved on Android devices.
//     // You might not need this callback for OTP-based verification.
//   };

//   // Resend the OTP to the provided phone number
//   await auth.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     verificationCompleted: verificationCompleted,
//     verificationFailed: verificationFailed,
//     codeSent: codeSent,
//     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     timeout: Duration(seconds: 60), // Adjust the timeout duration as needed.
//     forceResendingToken: resendToken, // Set this if you want to force resending the OTP.
//   );
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: ReusableWidgets.getAppBar('OTP Verification'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const TopCover(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    38.verticalSpace,
                    const Row(
                      children: [
                        CustomText(
                          text: "Contact",
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(94, 24, 234, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CountryPickerDropdown(
                            isExpanded: false,
                            icon: const Icon(
                              FontAwesomeIcons.angleDown,
                              size: 15,
                            ),
                            initialValue: 'IN',
                            itemBuilder: (country) {
                              return buildDropdownItem(
                                  context: context, country: country);
                            },
                            priorityList: [
                              CountryPickerUtils.getCountryByIsoCode('GB'),
                              CountryPickerUtils.getCountryByIsoCode('CN'),
                            ],
                            sortComparator: (Country a, Country b) =>
                                a.isoCode.compareTo(b.isoCode),
                            // ignore: no_leading_underscores_for_local_identifiers
                            onValuePicked: (Country _country) {
                              country = _country.phoneCode;
                              countryiso = _country.isoCode;
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 16),
                                hintText: 'Phone number',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          text: "Enter Verification Code",
                        ),
                        2.verticalSpace,
                        CustomText(
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          text:
                              "Enter code we just sent via SMS to ${widget.phoneNumber}",
                        ),
                        15.verticalSpace,
                        PinCodeTextField(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          enablePinAutofill: true,
                          hintCharacter: "0",
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          appContext: context,

                          length: 6, // Length of the OTP
                          controller: otpController,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            activeColor: Colors.blue,
                            borderWidth: 1.0,
                            inactiveColor: Colors.grey,
                          ),
                          onChanged: (value) {
                            print(otpController.text);
                            // Handle OTP change
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              60.verticalSpace,
              Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        await _resendOTP();
                      },
                      child: const CustomText(
                        fontWeight: FontWeight.w400,
                        text: "Resend OTP",
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      onPressed: () async {
                        if (otpController.text.length < 6) {
                          showSnackBar(
                            context: context,
                            message: 'Please enter 6 digit OTP',
                          );
                        } else {
                          UIBlock.block(context);
                          await onVerify().then((value) {
                            print(value);
                          }).catchError((error) {
                            // Handle the error here
                            showSnackBar(
                              context: context,
                              message:
                                  'Error occurred during verification: $error',
                            );
                            UIBlock.unblock(context);
                          });
                        }
                      },
                      child: const CustomText(
                        text: "Verify",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
