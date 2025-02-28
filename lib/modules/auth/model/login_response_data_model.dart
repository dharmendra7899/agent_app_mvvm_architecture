// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  String? message;
  LoginData? data;

  LoginModel({this.status, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginData {
  OldUser? oldUser;
  String? token;
  bool? isEmailVerified;

  LoginData({this.oldUser, this.token, this.isEmailVerified});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    oldUser: json["oldUser"] == null ? null : OldUser.fromJson(json["oldUser"]),
    token: json["token"],
    isEmailVerified: json["isEmailVerified"],
  );

  Map<String, dynamic> toJson() => {
    "oldUser": oldUser?.toJson(),
    "token": token,
    "isEmailVerified": isEmailVerified,
  };
}

class OldUser {
  String? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? image;
  int? isVerified;
  bool? active;
  String? air;
  int? emailVerifyOtp;
  bool? isEmailVerified;
  bool? isLoggedIn;
  bool? isUserDeleted;
  List<dynamic>? socialMediaLinks;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? emailVerifiedAt;
  dynamic profileCompleteAccuracy;
  String? aadhaarNumber;
  String? city;
  String? currentAddress;
  String? currentPreferredStream;
  String? dateOfBirth;
  String? gender;
  String? intermediateBoard;
  String? intermediatePercentage;
  String? nameOfInstitution;
  String? pin;
  String? prepareBy;
  String? state;
  String? targetedExam;
  String? tenthBoard;
  String? tenthPercentage;

  OldUser({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.password,
    this.image,
    this.isVerified,
    this.active,
    this.air,
    this.emailVerifyOtp,
    this.isEmailVerified,
    this.isLoggedIn,
    this.isUserDeleted,
    this.socialMediaLinks,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.emailVerifiedAt,
    this.profileCompleteAccuracy,
    this.aadhaarNumber,
    this.city,
    this.currentAddress,
    this.currentPreferredStream,
    this.dateOfBirth,
    this.gender,
    this.intermediateBoard,
    this.intermediatePercentage,
    this.nameOfInstitution,
    this.pin,
    this.prepareBy,
    this.state,
    this.targetedExam,
    this.tenthBoard,
    this.tenthPercentage,
  });

  factory OldUser.fromJson(Map<String, dynamic> json) => OldUser(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    image: json["image"],
    isVerified: json["is_verified"],
    active: json["active"],
    air: json["air"],
    emailVerifyOtp: json["email_verify_otp"],
    isEmailVerified: json["isEmailVerified"],
    isLoggedIn: json["isLoggedIn"],
    isUserDeleted: json["isUserDeleted"],
    socialMediaLinks:
        json["social_media_links"] == null
            ? []
            : List<dynamic>.from(json["social_media_links"]!.map((x) => x)),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    emailVerifiedAt:
        json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
    profileCompleteAccuracy: json["profile_complete_accuracy"],
    aadhaarNumber: json["aadhar_number"],
    city: json["city"],
    currentAddress: json["current_address"],
    currentPreferredStream: json["current_preferred_stream"],
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    intermediateBoard: json["intermediate_board"],
    intermediatePercentage: json["intermediate_percentage"],
    nameOfInstitution: json["name_of_institution"],
    pin: json["pin"],
    prepareBy: json["prepare_by"],
    state: json["state"],
    targetedExam: json["targeted_exam"],
    tenthBoard: json["tenth_board"],
    tenthPercentage: json["tenth_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "password": password,
    "image": image,
    "is_verified": isVerified,
    "active": active,
    "air": air,
    "email_verify_otp": emailVerifyOtp,
    "isEmailVerified": isEmailVerified,
    "isLoggedIn": isLoggedIn,
    "isUserDeleted": isUserDeleted,
    "social_media_links":
        socialMediaLinks == null
            ? []
            : List<dynamic>.from(socialMediaLinks!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "profile_complete_accuracy": profileCompleteAccuracy,
    "aadhar_number": aadhaarNumber,
    "city": city,
    "current_address": currentAddress,
    "current_preferred_stream": currentPreferredStream,
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "intermediate_board": intermediateBoard,
    "intermediate_percentage": intermediatePercentage,
    "name_of_institution": nameOfInstitution,
    "pin": pin,
    "prepare_by": prepareBy,
    "state": state,
    "targeted_exam": targetedExam,
    "tenth_board": tenthBoard,
    "tenth_percentage": tenthPercentage,
  };
}
