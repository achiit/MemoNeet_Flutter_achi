import 'dart:developer';

class UserModel {
  String? emailId;
  String? country;
  String? appVersion;
  String? os;
  String? deviceModel;
  PaymentDetails? paymentDetails;
  String? lastName;
  String? uuid;
  dynamic datetime;
  String? state;
  String? mobileNumber;
  String? parentMobileNumber;
  String? firstName;
  String? batch;
  String? isRepeater;

  UserModel({
    this.emailId,
    this.country,
    this.appVersion,
    this.os,
    this.deviceModel,
    this.paymentDetails,
    this.lastName,
    this.uuid,
    this.batch,
    this.datetime,
    this.state,
    this.mobileNumber,
    this.parentMobileNumber,
    this.firstName,
    this.isRepeater,
  });

  UserModel.fromJson(dynamic json) {
    inspect(json);

    emailId = json['email_id'].toString();
    log('emailId: $emailId');

    batch = json['batch'].toString();
    log('batch: $batch');

    country = json['country'];
    log('country: $country');

    appVersion = json['app_version'].toString();
    log('appVersion: $appVersion');

    os = json['os'];
    log('os: $os');

    deviceModel = json['device_model'];
    log('deviceModel: $deviceModel');

    paymentDetails = json['payment_details'] != null
        ? PaymentDetails.fromJson(json['payment_details'])
        : null;
    log('paymentDetails: $paymentDetails');

    lastName = json['last_name'];
    log('lastName: $lastName');

    uuid = json['uuid'];
    log('uuid: $uuid');

    if (json['datetime'] != null) {
      datetime = int.parse(json['datetime'].toString());
    } else {
      datetime = DateTime.now().millisecondsSinceEpoch;
    }
    log('datetime: $datetime');

    state = json['state'];
    log('state: $state');

    mobileNumber = json['mobile_number'];
    log('mobileNumber: $mobileNumber');

    parentMobileNumber = json['parent_mobile_number'];
    log('parentMobileNumber: $parentMobileNumber');

    firstName = json['first_name'];
    log('firstName: $firstName');

    isRepeater = json['repeater'];
    log('repeater: $isRepeater');
  }

  UserModel copyWith({
    String? emailId,
    dynamic image,
    String? country,
    String? batch,
    dynamic appVersion,
    String? os,
    String? deviceModel,
    PaymentDetails? paymentDetails,
    String? lastName,
    String? uuid,
    num? datetime,
    String? state,
    String? mobileNumber,
    String? firstName,
  }) =>
      UserModel(
        emailId: emailId ?? this.emailId,
        batch: batch ?? this.batch,
        country: country ?? this.country,
        appVersion: appVersion ?? this.appVersion,
        os: os ?? this.os,
        deviceModel: deviceModel ?? this.deviceModel,
        paymentDetails: paymentDetails ?? this.paymentDetails,
        lastName: lastName ?? this.lastName,
        uuid: uuid ?? this.uuid,
        datetime: datetime ?? this.datetime,
        state: state ?? this.state,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        parentMobileNumber: parentMobileNumber ?? parentMobileNumber,
        firstName: firstName ?? this.firstName,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email_id'] = emailId;
    map['batch'] = batch;
    map['country'] = country;
    map['app_version'] = appVersion.toString();
    map['os'] = os;
    map['device_model'] = deviceModel;
    if (paymentDetails != null) {
      map['payment_details'] = paymentDetails?.toJson();
    }
    map['last_name'] = lastName;
    map['uuid'] = uuid;
    map['datetime'] = datetime;
    map['state'] = state;
    map['mobile_number'] = mobileNumber;
    map['parent_mobile_number'] = parentMobileNumber;
    map['first_name'] = firstName;
    map['repeater'] = isRepeater;
    return map;
  }
}

/// datetime : 0
/// premium : 0.0
/// payment : 0.0
class PaymentDetails {
  PaymentDetails({
    this.datetime,
    this.premium,
    this.payment,
  });

  PaymentDetails.fromJson(dynamic json) {
    datetime = int.tryParse(json['datetime'].toString());
    premium = int.tryParse(json['premium'].toString());
    payment = int.tryParse(json['all_bcp'].toString());
  }
  int? datetime;
  int? premium;
  int? payment;
  PaymentDetails copyWith({
    int? datetime,
    int? premium,
    int? payment,
  }) =>
      PaymentDetails(
        datetime: datetime ?? this.datetime,
        premium: premium ?? this.premium,
        payment: payment ?? this.payment,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['datetime'] = datetime;
    map['premium'] = premium;
    map['payment'] = payment;
    return map;
  }
}
