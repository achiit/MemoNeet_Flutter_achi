// // ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
// import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
// import 'package:memo_neet/MVVM/viewmodels/base/base_view_model.dart';
// import 'package:memo_neet/constants/colors.dart';
// import 'package:memo_neet/constants/constant.dart';
// import 'package:memo_neet/constants/shared_prefs_helper.dart';
// import 'package:memo_neet/utils/widgets/buttons/my_elevated_button.dart';
// import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
// import 'package:memo_neet/utils/widgets/text/custom_text.dart';
// import 'package:provider/provider.dart';

// class ShowUserDialog extends StatefulWidget {
//   final TextEditingController firstnameController;
//   final TextEditingController secondnameController;
//   final TextEditingController emailController;
//   final TextEditingController phoneController;
//   final TextEditingController countryController;
//   final String deviceInfo;

//   final String isoCode;
//   const ShowUserDialog({
//     super.key,
//     required this.firstnameController,
//     required this.secondnameController,
//     required this.emailController,
//     required this.phoneController,
//     required this.countryController,
//     required this.deviceInfo,
//     required this.isoCode,
//   });

//   @override
//   State<ShowUserDialog> createState() => _ShowUserDialogState();
// }

// class _ShowUserDialogState extends State<ShowUserDialog> {
//   var countrydropdownValue;
//   var statedropdownValue;
//   var batchdropdownValue;
//   var countryCode;
//   var isRepeaterValue;
//   var formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     var baseVm = Provider.of<BaseViewModel>(context, listen: false);
//     log("_______________COUNT:$countrydropdownValue");
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           child: SizedBox(
//             // height: MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   // padding: const EdgeInsets.symmetric(vertical: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: AppColors.white,
//                   ),
//                   child: Consumer<BaseViewModel>(builder: (context, baseVm, _) {
//                     return Form(
//                       key: formKey,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 15.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.only(left: 20),
//                                   child: const CustomText(
//                                     text: 'Add Profile Details',
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     icon: const Icon(Icons.close)),
//                               ],
//                             ),
//                             10.verticalSpace,
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 15),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Flexible(
//                                     fit: FlexFit.loose,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         TextFormField(
//                                           controller:
//                                               widget.firstnameController,
//                                           textInputAction: TextInputAction.next,
//                                           decoration: const InputDecoration(
//                                               errorStyle:
//                                                   TextStyle(color: Colors.red),
//                                               floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                               hintStyle:
//                                                   TextStyle(fontSize: 13.0),
//                                               labelText: 'First Name',
//                                               border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: Colors.black))),
//                                           validator: (value) {
//                                             if (value?.isEmpty == true ||
//                                                 value == null) {
//                                               return "Required";
//                                             }
//                                             return null;
//                                           },
//                                         ),
//                                         10.verticalSpace,
//                                         TextFormField(
//                                           controller:
//                                               widget.secondnameController,
//                                           textInputAction: TextInputAction.next,
//                                           decoration: const InputDecoration(
//                                               errorStyle:
//                                                   TextStyle(color: Colors.red),
//                                               floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                               hintStyle:
//                                                   TextStyle(fontSize: 13),
//                                               labelText: 'Last Name',
//                                               border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: Colors.black))),
//                                           validator: (value) {
//                                             if (value?.isEmpty == true ||
//                                                 value == null) {
//                                               return "Required";
//                                             }
//                                             return null;
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   15.verticalSpace,
//                                   Flexible(
//                                       fit: FlexFit.loose,
//                                       flex: 1,
//                                       child: TextFormField(
//                                         controller: widget.emailController,
//                                         keyboardType:
//                                             TextInputType.emailAddress,
//                                         textInputAction: TextInputAction.next,
//                                         decoration: const InputDecoration(
//                                             errorStyle:
//                                                 TextStyle(color: Colors.red),
//                                             floatingLabelBehavior:
//                                                 FloatingLabelBehavior.always,
//                                             hintStyle: TextStyle(fontSize: 13),
//                                             labelText: 'Email',
//                                             border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.black))),
//                                         validator: (value) {
//                                           if (value?.isEmpty == true ||
//                                               value == null) {
//                                             return "Required";
//                                           }
//                                           return null;
//                                         },
//                                       )),
//                                   15.verticalSpace,
//                                   TextFormField(
//                                     keyboardType: TextInputType.phone,
//                                     controller: widget.phoneController,
//                                     decoration: const InputDecoration(
//                                         errorStyle:
//                                             TextStyle(color: Colors.red),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         labelText: 'Phone Number',
//                                         hintText: 'Enter your phone number',
//                                         hintStyle: TextStyle(fontSize: 13),
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.black))),
//                                     validator: (value) {
//                                       if (value?.isEmpty == true ||
//                                           value == null) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   20.verticalSpace,
//                                   DropdownButtonFormField<String>(
//                                     dropdownColor: AppColors.white,
//                                     value: batchdropdownValue,
//                                     iconSize: 24,
//                                     elevation: 16,
//                                     isExpanded: true,
//                                     decoration: InputDecoration(
//                                         errorStyle:
//                                             const TextStyle(color: Colors.red),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         hintStyle:
//                                             const TextStyle(fontSize: 13),
//                                         hintText: batchdropdownValue == null
//                                             ? "Select Batch"
//                                             : baseVm.batchList.first,
//                                         labelText: "Select Batch",
//                                         border: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.black))),
//                                     onChanged: (String? newValue) {
//                                       batchdropdownValue = newValue;
//                                     },
//                                     items: baseVm.batchList
//                                         .map<DropdownMenuItem<String>>(
//                                             (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     validator: (value) {
//                                       if (value?.isEmpty == true ||
//                                           value == null) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   20.verticalSpace,
//                                   DropdownButtonFormField<String>(
//                                     dropdownColor: AppColors.white,
//                                     value: statedropdownValue,
//                                     iconSize: 24,
//                                     elevation: 16,
//                                     isExpanded: true,
//                                     decoration: InputDecoration(
//                                         errorStyle:
//                                             const TextStyle(color: Colors.red),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         hintStyle:
//                                             const TextStyle(fontSize: 13),
//                                         hintText: statedropdownValue == null
//                                             ? "Select State"
//                                             : baseVm.countiriesStats.first,
//                                         labelText: "Select State",
//                                         border: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.black))),
//                                     onChanged: (String? newValue) {
//                                       statedropdownValue = newValue;
//                                     },
//                                     items: baseVm.countiriesStats
//                                         .map<DropdownMenuItem<String>>(
//                                             (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     validator: (value) {
//                                       if (value?.isEmpty == true ||
//                                           value == null) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   10.verticalSpace,
//                                   DropdownButtonFormField<String>(
//                                     dropdownColor: AppColors.white,
//                                     value: isRepeaterValue,
//                                     isExpanded: true,
//                                     decoration: const InputDecoration(
//                                         errorStyle:
//                                             TextStyle(color: Colors.red),
//                                         floatingLabelBehavior:
//                                             FloatingLabelBehavior.always,
//                                         hintStyle: TextStyle(fontSize: 13),
//                                         hintText: "Are you a Repeater?",
//                                         labelText: "Repeater",
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.black))),
//                                     items: <String>[
//                                       'Select',
//                                       'Yes',
//                                       'No',
//                                     ].map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       isRepeaterValue = newValue;
//                                     },
//                                   ),
//                                   30.verticalSpace,
//                                   MyElevatedButton(
//                                       buttonText: "Save",
//                                       onPressed: () async {
//                                         if (formKey.currentState!.validate()) {
//                                           context
//                                               .read<UserViewModel>()
//                                               .createUser();

//                                           Navigator.of(context).pop();
//                                           Constant.prefs.setString(
//                                               SharedPrefsHelper.isRepeater,
//                                               isRepeaterValue);
//                                         }
//                                       })
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
