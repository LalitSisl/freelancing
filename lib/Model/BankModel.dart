// To parse this JSON data, do
//
//     final bankModelClass = bankModelClassFromJson(jsonString?);

import 'dart:convert';

BankModelClass bankModelClassFromJson(String? str) => BankModelClass.fromJson(json.decode(str!));

String? bankModelClassToJson(BankModelClass data) => json.encode(data.toJson());

class BankModelClass {
    BankModelClass({
        this.status,
        this.data,
        this.successMsg,
    });

    bool? status;
    Data? data;
    String? successMsg;

    factory BankModelClass.fromJson(Map<String?, dynamic> json) => BankModelClass(
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
        this.banks,
    });

    List<Bank>? banks;

    factory Data.fromJson(Map<String?, dynamic> json) => Data(
        banks: json["banks"] == null ? null : List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "banks": banks == null ? null : List<dynamic>.from(banks!.map((x) => x.toJson())),
    };
}

class Bank {
    Bank({
        this.id,
        this.bankName,
        this.status,
    });

    String? id;
    String? bankName;
    String? status;

    factory Bank.fromJson(Map<String?, dynamic> json) => Bank(
        id: json["id"] == null ? null : json["id"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "bank_name": bankName == null ? null : bankName,
        "status": status == null ? null : status,
    };
}
