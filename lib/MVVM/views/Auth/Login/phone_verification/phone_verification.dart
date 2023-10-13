import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';

import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/login/dropdown_button_country.dart';
import 'package:memo_neet/utils/widgets/login/top_cover.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class PhoneVerification extends StatefulWidget {
  static const route = "/phone-verifcation";
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<UserViewModel>().setCountryCode = "91";
      context.read<UserViewModel>().countrydropdownValue = "India";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: ReusableWidgets.getAppBar('OTP Verification'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const TopCover(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
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
                            context.read<UserViewModel>().setCountryCode =
                                _country.phoneCode;
                            context.read<UserViewModel>().countrydropdownValue =
                                _country.name;
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              if (value.length == 10) {
                                FocusScope.of(context).unfocus();
                              }
                            },
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
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
              onPressed: () => context.read<AuthViewModel>().phoneSignIn(
                    context: context,
                    phoneNumber:
                        "+${context.read<UserViewModel>().countryCode}${phoneController.text}",
                    countryCode: context.read<UserViewModel>().countryCode,
                    countryiso:
                        context.read<UserViewModel>().countrydropdownValue,
                  ),
              child: const CustomText(
                text: "Send OTP",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
