// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/base/base_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/buttons/my_elevated_button.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  static const String route = "/my-profile";
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String dropdownValue = "Exam Type";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  var statedropdownValue;
  var batchdropdownValue;
  var isRepeaterValue;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var baseViewModel = Provider.of<BaseViewModel>(context, listen: false);
    UserViewModel userViewModel = context.read<UserViewModel>();
    firstNameController.text = "${userViewModel.userModel?.firstName}";
    lastNameController.text = userViewModel.userModel?.lastName ?? "";
    emailController.text = userViewModel.userModel?.emailId ?? "";
    phoneController.text = userViewModel.userModel?.mobileNumber ?? "";
    parentPhoneController.text =
        userViewModel.userModel?.parentMobileNumber ?? "";
    batchdropdownValue = userViewModel.userModel?.batch;
    statedropdownValue = userViewModel.userModel?.state;
    isRepeaterValue = userViewModel.userModel?.isRepeater;
    Constant.prefs.getString(SharedPrefsHelper.isRepeater) != null
        ? isRepeaterValue =
            Constant.prefs.getString(SharedPrefsHelper.isRepeater)
        : '';

    return Scaffold(
      appBar: ReusableAppbar.myAppBarWithLeading(
        onLeadingPress: () => Navigator.pop(context, true),
        context: context,
        title: "My Profile",
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: MyElevatedButton(
                buttonText: "Update",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    userViewModel.userModel!.firstName =
                        firstNameController.text;
                    userViewModel.userModel!.lastName = lastNameController.text;
                    userViewModel.userModel!.emailId = emailController.text;
                    userViewModel.userModel!.mobileNumber =
                        phoneController.text;
                    userViewModel.userModel!.parentMobileNumber =
                        parentPhoneController.text;

                    userViewModel.userModel!.batch = batchdropdownValue;
                    userViewModel.userModel!.state = statedropdownValue;
                    userViewModel.userModel!.isRepeater = isRepeaterValue;
                    await userViewModel.updateUserInfo();
                    showSnackBar(
                      context: context,
                      message: "Profile Updated Successfully!",
                    );
                    Constant.prefs.setString(
                        SharedPrefsHelper.isRepeater, isRepeaterValue);
                  }
                }),
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                ProfileTextField(
                    hintText: "First Name", controller: firstNameController),

                20.verticalSpace,

                ProfileTextField(
                    hintText: "Last Name", controller: lastNameController),

                20.verticalSpace,

                ProfileTextField(
                  controller: emailController,
                  hintText: "Email",
                ),
                20.verticalSpace,

                ProfileTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                20.verticalSpace,

                ProfileTextField(
                  controller: parentPhoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'Parent Phone Number',
                ),
                20.verticalSpace,

                DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: batchdropdownValue,
                  decoration: InputDecoration(
                    labelText: "Select Batch",
                    hintStyle: const TextStyle(fontSize: 13),
                    hintText: batchdropdownValue == null
                        ? "Select Batch"
                        : baseViewModel.batchList.first,
                    border: const UnderlineInputBorder(
                      // Use UnderlineInputBorder for bottom border
                      borderSide: BorderSide(
                        color: Color.fromRGBO(94, 24, 234,
                            0.2), // Set the color of the bottom border
                        width: 2, // Set the width of the bottom border
                      ),
                    ),
                  ),
                  items: baseViewModel.batchList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    batchdropdownValue = newValue;
                  },
                ),
                20.verticalSpace,

                DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: statedropdownValue,
                  decoration: InputDecoration(
                    labelText: "Select State",
                    hintStyle: const TextStyle(fontSize: 13),
                    hintText: statedropdownValue == null
                        ? "Select State"
                        : baseViewModel.countiriesStats.first,
                    border: const UnderlineInputBorder(
                      // Use UnderlineInputBorder for bottom border
                      borderSide: BorderSide(
                        color: Color.fromRGBO(94, 24, 234,
                            0.2), // Set the color of the bottom border
                        width: 2, // Set the width of the bottom border
                      ),
                    ),
                  ),
                  items: baseViewModel.countiriesStats.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    statedropdownValue = newValue;
                  },
                ),
                20.verticalSpace,

                DropdownButtonFormField<String>(
                  dropdownColor: AppColors.white,
                  value: isRepeaterValue,
                  decoration: InputDecoration(
                    labelText: "Are you a Repeater?",
                    hintStyle: const TextStyle(fontSize: 13),
                    hintText: statedropdownValue == null ? "Select" : '',
                    border: const UnderlineInputBorder(
                      // Use UnderlineInputBorder for bottom border
                      borderSide: BorderSide(
                        color: Color.fromRGBO(94, 24, 234,
                            0.2), // Set the color of the bottom border
                        width: 2, // Set the width of the bottom border
                      ),
                    ),
                  ),
                  items: <String>[
                    'Select',
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    isRepeaterValue = newValue;
                  },
                ),

                // 30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(fontSize: 13),
        labelText: hintText,
        hintText: hintText,

        errorStyle: const TextStyle(
          color: Colors.red, // or any other color
        ),
        contentPadding: const EdgeInsets.only(bottom: 8),

        border: const UnderlineInputBorder(
          // Use UnderlineInputBorder for bottom border
          borderSide: BorderSide(
            color: Color.fromRGBO(
                94, 24, 234, 0.2), // Set the color of the bottom border
            width: 2, // Set the width of the bottom border
          ),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty == true || value == null) {
          return "Required";
        }
        // if (keyboardType == TextInputType.phone && value.length != 10) {
        //   return "Invalid Phone Number";
        // }
        return null;
      },
    );
  }
}
