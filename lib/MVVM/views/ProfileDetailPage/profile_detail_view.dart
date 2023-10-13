import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/base/base_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/utils/widgets/buttons/my_elevated_button.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class ProfileDetialView extends StatelessWidget {
  static const route = "/profile-detail-view";
  const ProfileDetialView({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Consumer<BaseViewModel>(builder: (context, baseVm, _) {
                  return Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: const CustomText(
                                  text: 'Add Profile Details',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: context
                                            .watch<UserViewModel>()
                                            .firstnameController,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintStyle:
                                                TextStyle(fontSize: 13.0),
                                            labelText: 'First Name',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your first name.';
                                          }
                                          return null;
                                        },
                                      ),
                                      10.verticalSpace,
                                      TextFormField(
                                        controller: context
                                            .watch<UserViewModel>()
                                            .secondnameController,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintStyle: TextStyle(fontSize: 13),
                                            labelText: 'Last Name',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter your last name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                15.verticalSpace,
                                Flexible(
                                    fit: FlexFit.loose,
                                    flex: 1,
                                    child: TextFormField(
                                      controller: context
                                          .watch<UserViewModel>()
                                          .emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          errorStyle:
                                              TextStyle(color: Colors.red),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintStyle: TextStyle(fontSize: 13),
                                          labelText: 'Email',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your email';
                                        }
                                        return null;
                                      },
                                    )),
                                15.verticalSpace,
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: context
                                      .watch<UserViewModel>()
                                      .phoneController,
                                  decoration: const InputDecoration(
                                      errorStyle: TextStyle(color: Colors.red),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Phone Number',
                                      hintText: 'Enter your phone number',
                                      hintStyle: TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your last name';
                                    }
                                    if (value.length < 10) {
                                      return 'Enter valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                20.verticalSpace,
                                DropdownButtonFormField<String>(
                                  dropdownColor: AppColors.white,
                                  value: context
                                      .read<UserViewModel>()
                                      .batchdropdownValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: const TextStyle(fontSize: 13),
                                      hintText: context
                                                  .read<UserViewModel>()
                                                  .batchdropdownValue ==
                                              null
                                          ? "Select Batch"
                                          : baseVm.batchList.first,
                                      labelText: "Select Batch",
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  onChanged: (String? newValue) {
                                    context
                                        .read<UserViewModel>()
                                        .batchdropdownValue = newValue;
                                  },
                                  items: baseVm.batchList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select your batch';
                                    }
                                    return null;
                                  },
                                ),
                                20.verticalSpace,
                                DropdownButtonFormField<String>(
                                  dropdownColor: AppColors.white,
                                  value: context
                                      .read<UserViewModel>()
                                      .statedropdownValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: const TextStyle(fontSize: 13),
                                      hintText: context
                                                  .read<UserViewModel>()
                                                  .statedropdownValue ==
                                              null
                                          ? "Select State"
                                          : baseVm.countiriesStats.first,
                                      labelText: "Select State",
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                  onChanged: (String? newValue) {
                                    context
                                        .read<UserViewModel>()
                                        .statedropdownValue = newValue;
                                  },
                                  items: baseVm.countiriesStats
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select your state';
                                    }
                                    return null;
                                  },
                                ),
                                10.verticalSpace,
                                DropdownButtonFormField<String>(
                                  dropdownColor: AppColors.white,
                                  value: context
                                      .read<UserViewModel>()
                                      .isRepeaterValue,
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                      errorStyle: TextStyle(color: Colors.red),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: TextStyle(fontSize: 13),
                                      hintText: "Are you a Repeater?",
                                      labelText: "Repeater",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black))),
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
                                    context
                                        .read<UserViewModel>()
                                        .isRepeaterValue = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                ),
                                30.verticalSpace,
                                MyElevatedButton(
                                    buttonText: "Save",
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<UserViewModel>()
                                            .createUser();

                                        Navigator.pushReplacementNamed(
                                            context, CustomNavigationBar.route);
                                        Constant.prefs.setString(
                                            SharedPrefsHelper.isRepeater,
                                            context
                                                    .read<UserViewModel>()
                                                    .isRepeaterValue ??
                                                "No");
                                      }
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
