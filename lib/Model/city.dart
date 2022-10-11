// To parse this JSON data, do
//
//     final cityDetailModelClass = cityDetailModelClassFromJson(jsonString?);

import 'dart:convert';

CityDetailModelClass cityDetailModelClassFromJson(String? str) =>
    CityDetailModelClass.fromJson(json.decode(str!));

String? cityDetailModelClassToJson(CityDetailModelClass data) =>
    json.encode(data.toJson());

class CityDetailModelClass {
  CityDetailModelClass({
    this.status,
    this.data,
    this.successMsg,
  });

  bool? status;
  Data? data;
  String? successMsg;

  factory CityDetailModelClass.fromJson(Map<String?, dynamic> json) =>
      CityDetailModelClass(
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
    this.cities,
  });

  List<City>? cities;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        cities: json["cities"] == null
            ? null
            : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.cityId,
    this.cityName,
  });

  String? cityId;
  String? cityName;

  factory City.fromJson(Map<String?, dynamic> json) => City(
        cityId: json["city_id"] == null ? null : json["city_id"],
        cityName: json["city_name"] == null ? null : json["city_name"],
      );

  Map<String?, dynamic> toJson() => {
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName == null ? null : cityName,
      };
}
