// ignore_for_file: file_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freelancing/Authentication/register.dart';
import 'package:freelancing/Model/BankModel.dart';
import 'package:freelancing/Model/city.dart';
import 'package:freelancing/Model/experienceModal.dart';
import 'package:freelancing/Model/qualificationModal.dart';
import 'package:freelancing/Model/skillModel.dart';
import 'package:freelancing/Model/stateModel.dart';
import 'package:freelancing/Model/typeofcompanymodel.dart';
import 'package:freelancing/Model/userModelClass.dart';
import 'package:freelancing/Utils/APIURLs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<UserDetailModelClass?> getFrelencer() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}",
                "${APIUrls.GET_USER_COMPLETE_DETAILS}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });
        // var response = await http.post(Uri.parse(APIUrls.LOG_IN, queryParams),
        //     headers: {'Authorization': 'Bearer ${SharedPref.token}'});

        try {
          var convertJson = jsonDecode(response.body);
          print("-------------------------------------------------------");
          print(convertJson);
          print("-------------------------------------------------------");
          if (convertJson["status"]) {
            selectUser=="2"?
            sharedPreferneces.setString('user_id',
                '${convertJson['data']['user_details']['profile_details']['id']}'):
                            sharedPreferneces.setString('user_id',
                '${convertJson['data']['user_details']['vendor_details']['id']}');
            var data = UserDetailModelClass();
            data = UserDetailModelClass.fromJson(convertJson);
            return data;
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
            print("dsnfjs");
            return null;
          }
          // setState(() {
          //   isLoading = false;
          // });
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Something went wrong, try again later'),
          // ));
        }
      }
    } on SocketException catch (_) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //       'No internet connection. Connect to the internet and try again.'),
      // ));
    }
    return null;
  }

  Future<SkillModelClass?> getSkills() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_SKILLS}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          //print(convertJson);
          if (convertJson["status"]) {
            var data = SkillModelClass();
            data = SkillModelClass.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }

  Future<GetQualificationModal?> getQualification() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    print("aetasbtrjhabrtjhbserjhtbesrjh");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_QUALIFICATION}",
                queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          print("ppppppppppppppppppppp");
          if (convertJson["status"]) {
            var data = GetQualificationModal();
            data = GetQualificationModal.fromJson(convertJson);
            return data;
          } else {
            print("aerwerwer;");
          }
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }

  Future<GetExperienceModal?> getExperience() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    // print("1233333333333333333333333");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http(
                "${APIUrls.DOMAIN}", "${APIUrls.GET_EXPERIENCE}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);

          print(convertJson);

          if (convertJson["status"]) {
            var data = GetExperienceModal();
            data = GetExperienceModal.fromJson(convertJson);
            return data;
          } else {
            print("abcv33333333333333333333333333333332222222222222;");
          }
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }

  Future<CityDetailModelClass?> getCities(var stateid) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
          "state_id": stateid
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_CITY}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~~~~~~~~~~~~~~~#################");
          print(convertJson);
          if (convertJson["status"]) {
            var data = CityDetailModelClass();
            data = CityDetailModelClass.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }


  Future<CityDetailModelClass?> getallCitiesrepeat() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_CITY}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~~~~~~~~~~~~~~~#################");
          print(convertJson);
          if (convertJson["status"]) {
            var data = CityDetailModelClass();
            data = CityDetailModelClass.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }
  Future<StateModelClass?> getStates() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_STATE}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~~~~~~~~~~~~~~~#################");
          print(convertJson);
          if (convertJson["status"]) {
            var data = StateModelClass();
            data = StateModelClass.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }

  Future<BankModelClass?> getBanksList() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_BANK}", queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~~~~~~~~~~~~~~~#################");
          print(convertJson);
          if (convertJson["status"]) {
            var data = BankModelClass();
            data = BankModelClass.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }
  Future<TypeofcompanyModel?> getVendorComapnyType() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
               Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_VENDOR_COMAPNY_TYPE}",
                queryParams),
            headers: {
              'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'
            });

        try {
          var convertJson = jsonDecode(response.body);
          print(
              "@@@@@@@@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~~~~~~~~~~~~~~~#################");
          print(convertJson);
          if (convertJson["status"]) {
            var data = TypeofcompanyModel();
            data = TypeofcompanyModel.fromJson(convertJson);
            return data;
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }

}
