// To parse this JSON data, do
//
//     final stateModelClass = stateModelClassFromJson(jsonString?);

import 'dart:convert';

StateModelClass stateModelClassFromJson(String? str) =>
    StateModelClass.fromJson(json.decode(str!));

String? stateModelClassToJson(StateModelClass data) =>
    json.encode(data.toJson());

class StateModelClass {
  StateModelClass({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory StateModelClass.fromJson(Map<String?, dynamic> json) =>
      StateModelClass(
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
    this.states,
  });

  List<State>? states;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        states: json["states"] == null
            ? null
            : List<State>.from(json["states"].map((x) => State.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "states": states == null
            ? null
            : List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}

class State {
  State({
    this.stateId,
    this.stateName,
  });

  String? stateId;
  String? stateName;

  factory State.fromJson(Map<String?, dynamic> json) => State(
        stateId: json["state_id"] == null ? null : json["state_id"],
        stateName: json["state_name"] == null ? null : json["state_name"],
      );

  Map<String?, dynamic> toJson() => {
        "state_id": stateId == null ? null : stateId,
        "state_name": stateName == null ? null : stateName,
      };
}
