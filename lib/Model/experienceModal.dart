// To parse this JSON data, do
//
//     final getExperienceModal = getExperienceModalFromJson(jsonString?);

import 'dart:convert';

GetExperienceModal getExperienceModalFromJson(String? str) =>
    GetExperienceModal.fromJson(json.decode(str!));

String? getExperienceModalToJson(GetExperienceModal data) =>
    json.encode(data.toJson());

class GetExperienceModal {
  GetExperienceModal({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory GetExperienceModal.fromJson(Map<String?, dynamic> json) =>
      GetExperienceModal(
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
    this.workExp,
  });

  List<WorkExp>? workExp;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        workExp: json["work_exp"] == null
            ? null
            : List<WorkExp>.from(
                json["work_exp"].map((x) => WorkExp.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "work_exp": workExp == null
            ? null
            : List<dynamic>.from(workExp!.map((x) => x.toJson())),
      };
}

class WorkExp {
  WorkExp({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory WorkExp.fromJson(Map<String?, dynamic> json) => WorkExp(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
