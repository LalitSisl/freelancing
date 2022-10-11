// To parse this JSON data, do
//
//     final getQualificationModal = getQualificationModalFromJson(jsonString?);

import 'dart:convert';

GetQualificationModal getQualificationModalFromJson(String? str) =>
    GetQualificationModal.fromJson(json.decode(str!));

String? getQualificationModalToJson(GetQualificationModal data) =>
    json.encode(data.toJson());

class GetQualificationModal {
  GetQualificationModal({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory GetQualificationModal.fromJson(Map<String?, dynamic> json) =>
      GetQualificationModal(
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
    this.qualifications,
  });

  List<Qualification>? qualifications;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        qualifications: json["qualifications"] == null
            ? null
            : List<Qualification>.from(
                json["qualifications"].map((x) => Qualification.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "qualifications": qualifications == null
            ? null
            : List<dynamic>.from(qualifications!.map((x) => x.toJson())),
      };
}

class Qualification {
  Qualification({
    this.id,
    this.qualificationName,
    this.status,
  });

  String? id;
  String? qualificationName;
  String? status;

  factory Qualification.fromJson(Map<String?, dynamic> json) => Qualification(
        id: json["id"] == null ? null : json["id"],
        qualificationName: json["qualification_name"] == null
            ? null
            : json["qualification_name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "qualification_name":
            qualificationName == null ? null : qualificationName,
        "status": status == null ? null : status,
      };
}
