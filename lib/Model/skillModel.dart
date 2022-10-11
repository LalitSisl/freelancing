// To parse this JSON data, do
//
//     final skillModelClass = skillModelClassFromJson(jsonString?);

import 'dart:convert';

SkillModelClass skillModelClassFromJson(String? str) =>
    SkillModelClass.fromJson(json.decode(str!));

String? skillModelClassToJson(SkillModelClass data) =>
    json.encode(data.toJson());

class SkillModelClass {
  SkillModelClass({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory SkillModelClass.fromJson(Map<String?, dynamic> json) =>
      SkillModelClass(
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
    this.skills,
  });

  List<Skill>? skills;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        skills: json["skills"] == null
            ? null
            : List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "skills": skills == null
            ? null
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
      };
}

class Skill {
  Skill({
    this.id,
    this.name,
    this.status,
  });

  String? id;
  String? name;
  String? status;

  factory Skill.fromJson(Map<String?, dynamic> json) => Skill(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
      };
}
