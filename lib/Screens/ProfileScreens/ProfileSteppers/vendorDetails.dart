// // To parse this JSON data, do
// //
// //     final userDetailModelClass = userDetailModelClassFromJson(jsonString);

// import 'dart:convert';

// UserDetailModelClass userDetailModelClassFromJson(String str) => UserDetailModelClass.fromJson(json.decode(str));

// String userDetailModelClassToJson(UserDetailModelClass data) => json.encode(data.toJson());

// class UserDetailModelClass {
//     UserDetailModelClass({
//         this.status,
//         this.data,
//         this.successMsg,
//     });

//     bool status;
//     Data data;
//     String successMsg;

//     factory UserDetailModelClass.fromJson(Map<String, dynamic> json) => UserDetailModelClass(
//         status: json["status"] == null ? null : json["status"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         successMsg: json["success_msg"] == null ? null : json["success_msg"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status == null ? null : status,
//         "data": data == null ? null : data.toJson(),
//         "success_msg": successMsg == null ? null : successMsg,
//     };
// }

// class Data {
//     Data({
//         this.userDetails,
//     });

//     UserDetails userDetails;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "user_details": userDetails == null ? null : userDetails.toJson(),
//     };
// }

// class UserDetails {
//     UserDetails({
//         this.vendorDetails,
//         this.profileDetails,
//         this.businessDetails,
//         this.bankDetails,
//     });

//     VendorDetails vendorDetails;
//     dynamic profileDetails;
//     dynamic businessDetails;
//     dynamic bankDetails;

//     factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
//         vendorDetails: json["vendor_details"] == null ? null : VendorDetails.fromJson(json["vendor_details"]),
//         profileDetails: json["profile_details"],
//         businessDetails: json["business_details"],
//         bankDetails: json["bank_details"],
//     );

//     Map<String, dynamic> toJson() => {
//         "vendor_details": vendorDetails == null ? null : vendorDetails.toJson(),
//         "profile_details": profileDetails,
//         "business_details": businessDetails,
//         "bank_details": bankDetails,
//     };
// }

// class VendorDetails {
//     VendorDetails({
//         this.id,
//         this.companyName,
//         this.companyId,
//         this.accountGroup,
//         this.vendorRequiredFor,
//         this.vendorState,
//         this.vendorStateName,
//         this.vendorCity,
//         this.vendorCityName,
//         this.vendorPin,
//         this.vendorPhone,
//         this.turnover,
//         this.vendorCompanyType,
//         this.userType,
//         this.contactFirstName,
//         this.contactLastName,
//         this.contactPhoneNumber,
//         this.contactEmail,
//         this.contactPosition,
//         this.phoneNumber,
//         this.vendorCompanyTypeName,
//     });

//     String id;
//     String companyName;
//     String companyId;
//     String accountGroup;
//     String vendorRequiredFor;
//     String vendorState;
//     String vendorStateName;
//     String vendorCity;
//     String vendorCityName;
//     String vendorPin;
//     String vendorPhone;
//     String turnover;
//     String vendorCompanyType;
//     String userType;
//     String contactFirstName;
//     String contactLastName;
//     String contactPhoneNumber;
//     String contactEmail;
//     String contactPosition;
//     String phoneNumber;
//     dynamic vendorCompanyTypeName;

//     factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
//         id: json["id"] == null ? null : json["id"],
//         companyName: json["company_name"] == null ? null : json["company_name"],
//         companyId: json["company_id"] == null ? null : json["company_id"],
//         accountGroup: json["account_group"] == null ? null : json["account_group"],
//         vendorRequiredFor: json["vendor_required_for"] == null ? null : json["vendor_required_for"],
//         vendorState: json["vendor_state"] == null ? null : json["vendor_state"],
//         vendorStateName: json["vendor_state_name"] == null ? null : json["vendor_state_name"],
//         vendorCity: json["vendor_city"] == null ? null : json["vendor_city"],
//         vendorCityName: json["vendor_city_name"] == null ? null : json["vendor_city_name"],
//         vendorPin: json["vendor_pin"] == null ? null : json["vendor_pin"],
//         vendorPhone: json["vendor_phone"] == null ? null : json["vendor_phone"],
//         turnover: json["turnover"] == null ? null : json["turnover"],
//         vendorCompanyType: json["vendor_company_type"] == null ? null : json["vendor_company_type"],
//         userType: json["user_type"] == null ? null : json["user_type"],
//         contactFirstName: json["contact_first_name"] == null ? null : json["contact_first_name"],
//         contactLastName: json["contact_last_name"] == null ? null : json["contact_last_name"],
//         contactPhoneNumber: json["contact_phone_number"] == null ? null : json["contact_phone_number"],
//         contactEmail: json["contact_email"] == null ? null : json["contact_email"],
//         contactPosition: json["contact_position"] == null ? null : json["contact_position"],
//         phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
//         vendorCompanyTypeName: json["vendor_company_type_name"]== null ? null : json["vendor_company_type_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "company_name": companyName == null ? null : companyName,
//         "company_id": companyId == null ? null : companyId,
//         "account_group": accountGroup == null ? null : accountGroup,
//         "vendor_required_for": vendorRequiredFor == null ? null : vendorRequiredFor,
//         "vendor_state": vendorState == null ? null : vendorState,
//         "vendor_state_name": vendorStateName == null ? null : vendorStateName,
//         "vendor_city": vendorCity == null ? null : vendorCity,
//         "vendor_city_name": vendorCityName == null ? null : vendorCityName,
//         "vendor_pin": vendorPin == null ? null : vendorPin,
//         "vendor_phone": vendorPhone == null ? null : vendorPhone,
//         "turnover": turnover == null ? null : turnover,
//         "vendor_company_type": vendorCompanyType == null ? null : vendorCompanyType,
//         "user_type": userType == null ? null : userType,
//         "contact_first_name": contactFirstName == null ? null : contactFirstName,
//         "contact_last_name": contactLastName == null ? null : contactLastName,
//         "contact_phone_number": contactPhoneNumber == null ? null : contactPhoneNumber,
//         "contact_email": contactEmail == null ? null : contactEmail,
//         "contact_position": contactPosition == null ? null : contactPosition,
//         "phone_number": phoneNumber == null ? null : phoneNumber,
//         "vendor_company_type_name": vendorCompanyTypeName,
//     };
// }
