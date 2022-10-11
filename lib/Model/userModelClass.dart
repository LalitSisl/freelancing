// To parse this JSON data, do
//
//     final userDetailModelClass = userDetailModelClassFromJson(jsonString?);

import 'dart:convert';

UserDetailModelClass userDetailModelClassFromJson(String? str) =>
    UserDetailModelClass.fromJson(json.decode(str!));

String? userDetailModelClassToJson(UserDetailModelClass data) =>
    json.encode(data.toJson());

class UserDetailModelClass {
  UserDetailModelClass({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory UserDetailModelClass.fromJson(Map<String?, dynamic> json) =>
      UserDetailModelClass(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        successMsg: json["success_msg"] == null ? null : json["success_msg"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
        "success_msg": successMsg == null ? null : successMsg,
      };
}

class Data {
  Data({
    this.userDetails,
  });

  UserDetails? userDetails;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromJson(json["user_details"]),
      );

  Map<String?, dynamic> toJson() => {
        "user_details": userDetails == null ? null : userDetails!.toJson(),
      };
}

class UserDetails {
  UserDetails({
    this.profileDetails,
    this.businessDetails,
    this.bankDetails,
  });

  ProfileDetails? profileDetails;
  BusinessDetails? businessDetails;
  BankDetails? bankDetails;

  factory UserDetails.fromJson(Map<String?, dynamic> json) => UserDetails(
        profileDetails: json["profile_details"] == null
            ? null
            : ProfileDetails.fromJson(json["profile_details"]),
        businessDetails: json["business_details"] == null
            ? null
            : BusinessDetails.fromJson(json["business_details"]),
        bankDetails: json["bank_details"] == null
            ? null
            : BankDetails.fromJson(json["bank_details"]),
      );

  Map<String?, dynamic> toJson() => {
        "profile_details":
            profileDetails == null ? null : profileDetails!.toJson(),
        "business_details":
            businessDetails == null ? null : businessDetails!.toJson(),
        "bank_details": bankDetails == null ? null : bankDetails!.toJson(),
      };
}

class BankDetails {
  BankDetails({
    this.id,
    this.freelancerId,
    this.bank,
    this.accountNo,
    this.ifscCode,
    this.accountType,
    this.accountHolderName,
    this.cancelChecque,
    this.status,
    this.bankName,
  });

  String? id;
  String? freelancerId;
  String? bank;
  String? accountNo;
  String? ifscCode;
  String? accountType;
  String? accountHolderName;
  String? cancelChecque;
  String? status;

  String? bankName;

  factory BankDetails.fromJson(Map<String?, dynamic> json) => BankDetails(
        id: json["id"] == null ? null : json["id"],
        freelancerId:
            json["freelancer_id"] == null ? null : json["freelancer_id"],
        bank: json["bank"] == null ? null : json["bank"],
        accountNo: json["account_no"] == null ? null : json["account_no"],
        ifscCode: json["ifsc_code"] == null ? null : json["ifsc_code"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        accountHolderName: json["account_holder_name"] == null
            ? null
            : json["account_holder_name"],
        cancelChecque:
            json["cancel_checque"] == null ? null : json["cancel_checque"],
        status: json["status"] == null ? null : json["status"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "freelancer_id": freelancerId == null ? null : freelancerId,
        "bank": bank == null ? null : bank,
        "account_no": accountNo == null ? null : accountNo,
        "ifsc_code": ifscCode == null ? null : ifscCode,
        "account_type": accountType == null ? null : accountType,
        "account_holder_name":
            accountHolderName == null ? null : accountHolderName,
        "cancel_checque": cancelChecque == null ? null : cancelChecque,
        "status": status == null ? null : status,
        "bank_name": bankName == null ? null : bankName,
      };
}

class BusinessDetails {
  BusinessDetails({
    this.gstNumber,
    this.gstDoc,
    this.panNumber,
    this.serviceAreas,
  });

  String? gstNumber;
  String? gstDoc;
  String? panNumber;
  List<ServiceArea>? serviceAreas;

  factory BusinessDetails.fromJson(Map<String?, dynamic> json) =>
      BusinessDetails(
        gstNumber: json["gst_number"] == null ? null : json["gst_number"],
        gstDoc: json["gst_doc"] == null ? null : json["gst_doc"],
        panNumber: json["pan_number"] == null ? null : json["pan_number"],
        serviceAreas: json["service_areas"] == null
            ? null
            : List<ServiceArea>.from(
                json["service_areas"].map((x) => ServiceArea.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "gst_number": gstNumber == null ? null : gstNumber,
        "gst_doc": gstDoc == null ? null : gstDoc,
        "pan_number": panNumber == null ? null : panNumber,
        "service_areas": serviceAreas == null
            ? null
            : List<dynamic>.from(serviceAreas!.map((x) => x.toJson())),
      };
}

class ServiceArea {
  ServiceArea({
    this.serviceAreaId,
    this.serviceAreaName,
  });

  String? serviceAreaId;
  String? serviceAreaName;

  factory ServiceArea.fromJson(Map<String?, dynamic> json) => ServiceArea(
        serviceAreaId:
            json["service_area_id"] == null ? null : json["service_area_id"],
        serviceAreaName: json["service_area_name"] == null
            ? null
            : json["service_area_name"],
      );

  Map<String?, dynamic> toJson() => {
        "service_area_id": serviceAreaId == null ? null : serviceAreaId,
        "service_area_name": serviceAreaName == null ? null : serviceAreaName,
      };
}

class ProfileDetails {
  ProfileDetails({
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.address,
    this.workTitle,
    this.registrationMedium,
    this.dob,
    this.gender,
    this.highestQualification,
    this.highestQualificationName,
    this.experience,
    this.idProofType,
    this.idProofNumber,
    this.idProofDoc,
    this.profileImage,
    this.addressProofType,
    this.addressProofNumber,
    this.addressProofDoc,
    this.status,
    this.skills,
  });

  String? id;
  String? userType;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? workTitle;
  String? registrationMedium;
  String? dob;
  String? gender;
  String? highestQualification;
  String? highestQualificationName;
  String? experience;
  String? idProofType;
  String? idProofNumber;
  String? idProofDoc;
  String? profileImage;
  String? addressProofType;
  String? addressProofNumber;
  String? addressProofDoc;
  String? status;
  List<UserSkill>? skills;

  factory ProfileDetails.fromJson(Map<String?, dynamic> json) => ProfileDetails(
        id: json["id"] == null ? null : json["id"],
        userType: json["user_type"] == null ? null : json["user_type"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        address: json["address"] == null ? null : json["address"],
        workTitle: json["work_title"] == null ? null : json["work_title"],
        registrationMedium: json["registration_medium"] == null
            ? null
            : json["registration_medium"],
        dob: json["dob"] == null ? null : json["dob"],
        gender: json["gender"] == null ? null : json["gender"],
        highestQualification: json["highest_qualification"] == null
            ? null
            : json["highest_qualification"],
        highestQualificationName: json["highest_qualification_name"] == null
            ? null
            : json["highest_qualification_name"],
        experience: json["experience"] == null ? null : json["experience"],
        idProofType:
            json["id_proof_type"] == null ? null : json["id_proof_type"],
        idProofNumber:
            json["id_proof_number"] == null ? null : json["id_proof_number"],
        idProofDoc: json["id_proof_doc"] == null ? null : json["id_proof_doc"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        addressProofType: json["address_proof_type"] == null
            ? null
            : json["address_proof_type"],
        addressProofNumber: json["address_proof_number"] == null
            ? null
            : json["address_proof_number"],
        addressProofDoc: json["address_proof_doc"] == null
            ? null
            : json["address_proof_doc"],
        status: json["status"] == null ? null : json["status"],
        skills: json["skills"] == null
            ? null
            : List<UserSkill>.from(
                json["skills"].map((x) => UserSkill.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_type": userType == null ? null : userType,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "address": address == null ? null : address,
        "work_title": workTitle == null ? null : workTitle,
        "registration_medium":
            registrationMedium == null ? null : registrationMedium,
        "dob": dob == null ? null : dob,
        "gender": gender == null ? null : gender,
        "highest_qualification":
            highestQualification == null ? null : highestQualification,
        "highest_qualification_name":
            highestQualificationName == null ? null : highestQualificationName,
        "experience": experience == null ? null : experience,
        "id_proof_type": idProofType == null ? null : idProofType,
        "id_proof_number": idProofNumber == null ? null : idProofNumber,
        "id_proof_doc": idProofDoc == null ? null : idProofDoc,
        "profile_image": profileImage == null ? null : profileImage,
        "address_proof_type":
            addressProofType == null ? null : addressProofType,
        "address_proof_number":
            addressProofNumber == null ? null : addressProofNumber,
        "address_proof_doc": addressProofDoc == null ? null : addressProofDoc,
        "status": status == null ? null : status,
        "skills": skills == null
            ? null
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
      };
}

class UserSkill {
  UserSkill({
    this.skillId,
    this.skillName,
  });

  String? skillId;
  dynamic skillName;

  factory UserSkill.fromJson(Map<String?, dynamic> json) => UserSkill(
        skillId: json["skill_id"] == null ? null : json["skill_id"],
        skillName: json["skill_name"],
      );

  Map<String?, dynamic> toJson() => {
        "skill_id": skillId == null ? null : skillId,
        "skill_name": skillName,
      };
}
