// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:carrier_info/carrier_info.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
import 'package:memo_neet/repo/user_services.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLoading = false;
  get isLoading => _isLoading;
  UserModel? _userModel;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  UserModel? get userModel => _userModel;
  int _serverTime = 0;
  get serverTime => _serverTime;
  set userModel(value) {
    _userModel = value;
    notifyListeners();
  }

  bool _isSubscribedUser = false;
  get isSubscribedUser => _isSubscribedUser;
  set isSubscribedUser(value) {
    _isSubscribedUser = value;
    notifyListeners();
  }

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController secondnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String _deviceInfo = "";
  get deviceInfo => _deviceInfo;
  set deviceInfo(value) {
    _deviceInfo = value;
    notifyListeners();
  }

  String? _countrydropdownValue = "India";
  get countrydropdownValue => _countrydropdownValue;
  set countrydropdownValue(value) {
    _countrydropdownValue = value;
    notifyListeners();
  }

  String? _statedropdownValue;
  get statedropdownValue => _statedropdownValue;
  set statedropdownValue(value) {
    _statedropdownValue = value;
    notifyListeners();
  }

  String? _batchdropdownValue;
  get batchdropdownValue => _batchdropdownValue;
  set batchdropdownValue(value) {
    _batchdropdownValue = value;
    notifyListeners();
  }

  String? _countryCode = "91";
  get countryCode => _countryCode;
  set setCountryCode(value) {
    _countryCode = value;
    notifyListeners();
  }

  String? _isRepeaterValue;
  get isRepeaterValue => _isRepeaterValue;
  set isRepeaterValue(value) {
    _isRepeaterValue = value;
    notifyListeners();
  }

  CarrierData? carrierInfo;

  void update() {
    notifyListeners();
  }

  Future createUser() async {
    await UserServices()
        .createUser(
      UserModel(
        firstName: firstnameController.text,
        lastName: secondnameController.text,
        emailId: emailController.text,
        mobileNumber: phoneController.text,
        country: countryCode,
        state: statedropdownValue,
        deviceModel: deviceInfo,
        batch: batchdropdownValue,
        isRepeater: isRepeaterValue,
      ),
    )
        .then((value) {
      log("user data uploaded successfully: $value");
      _userModel = value;
      notifyListeners();
    });
  }

  Future updateUserInfo() async {
    log("updateUserInfo: user_view_model.dart");
    await UserServices().updateUserInfo(_userModel ?? UserModel());
  }

  Future getUserInfo(BuildContext context) async {
    _isLoading = true;
    await getMetaData();
    await UserServices().getUserInfo(context).then((value) {
      _userModel = value;
      _isLoaded = true;
      notifyListeners();
      int expiryTime =
          (_userModel?.paymentDetails?.datetime ?? 0).toInt() + 31556952000;
      log("user_payment_time: ${_userModel?.paymentDetails?.datetime ?? 0}\nexpiry_time:  $expiryTime \nserver_time: $_serverTime}");

      if (_userModel?.paymentDetails?.datetime != null) {
        _isSubscribedUser = _serverTime < expiryTime;
      } else {
        _isSubscribedUser = false;
      }
      log("isSubscribedUser: $_isSubscribedUser");
      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }

  getMetaData() async {
    _serverTime = await UserServices().getMetaData();
  }

  reset() {
    _userModel = null;
    _isSubscribedUser = false;
    _serverTime = 0;
    _batchdropdownValue = null;
    _countryCode = null;
    _countrydropdownValue = null;
    _deviceInfo = "";
    _isRepeaterValue = null;
    _statedropdownValue = null;
    carrierInfo = null;
    firstnameController.text = "";
    secondnameController.text = "";
    emailController.text = "";
    phoneController.text = "";

    notifyListeners();
  }
}
