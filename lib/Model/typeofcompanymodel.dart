// To parse this JSON data, do
//
//     final typeofcompanyModel = typeofcompanyModelFromJson(jsonString?);

import 'dart:convert';

TypeofcompanyModel typeofcompanyModelFromJson(String? str) => TypeofcompanyModel.fromJson(json.decode(str!));

String? typeofcompanyModelToJson(TypeofcompanyModel data) => json.encode(data.toJson());

class TypeofcompanyModel {
    TypeofcompanyModel({
        this.status,
        this.data,
        this.successMsg,
    });

    bool? status;
    Data? data;
    String? successMsg;

    factory TypeofcompanyModel.fromJson(Map<String?, dynamic> json) => TypeofcompanyModel(
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
        this.companyType,
    });

    List<CompanyType>? companyType;

    factory Data.fromJson(Map<String?, dynamic> json) => Data(
        companyType: json["company_type"] == null ? null : List<CompanyType>.from(json["company_type"].map((x) => CompanyType.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "company_type": companyType == null ? null : List<dynamic>.from(companyType!.map((x) => x.toJson())),
    };
}

class CompanyType {
    CompanyType({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory CompanyType.fromJson(Map<String?, dynamic> json) => CompanyType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}
