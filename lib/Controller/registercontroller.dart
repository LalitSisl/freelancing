import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/global.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/ApiHelper.dart';
import 'package:freelancing/Model/BankModel.dart';
import 'package:freelancing/Model/city.dart';
import 'package:freelancing/Model/experienceModal.dart';
import 'package:freelancing/Model/qualificationModal.dart';
import 'package:freelancing/Model/skillModel.dart';
import 'package:freelancing/Model/userModelClass.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/PersonalDetail.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/bank.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/business.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/vendorDetails.dart';
import 'package:freelancing/Screens/profile_copy.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:freelancing/Utils/APIURLs.dart';
import 'package:get/get.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class registerController extends GetxController {
  //  profile_controller controller = Get.put(profile_controller());

  var vendorType;

  Future<void> register() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    //  var usertype = selectUser;
    var token = sharedPreferneces.getString('token');

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",
          "user_type": selectUser.toString(),
        };
        var response = await http.get(
            Uri.http(
                "${APIUrls.DOMAIN}", "${APIUrls.REGISTER_AS}", queryParams),
            headers: {'Authorization': 'Bearer $token'});
        // var response = await http.post(Uri.parse(APIUrls.LOG_IN, queryParams),
        //     headers: {'Authorization': 'Bearer ${SharedPref.token}'});
        try {
          var convertJson = jsonDecode(response.body);
          print('   lalit $convertJson');
          if (convertJson["status"]) {
            Get.snackbar(
                "Data Fetched successfully", convertJson['success_msg'],
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);
            sharedPreferneces.setString(
                'user_id', '${convertJson['data']['user_id']}');
            update();

            print(convertJson['data']['user_status']);
            print("================================");
            if (convertJson['data']['user_status'] != "3") {
              vendorType = selectUser;
              print(vendorType);
              print("==========vendor===============");
              update();

              //     controller.activeCurrentStep  = int.parse(convertJson['data']['user_status']);
              Get.to(
                profile_copy(),
              );
              // Get.to(() =>Profile(
              //     user: _selectUser,
              //     user_status: convertJson['data']['user_status'].toString()));
              print('user status ${convertJson['data']['user_status']}');
            } else {
              // Get.to(Profile(user: _selectUser,
              //     user_status: convertJson['data']['user_status'].toString()));
              Get.to(const Review());
            }
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          Get.snackbar("Error", "Something went wrong, try again later",
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } on SocketException catch (_) {
      Get.snackbar("Error",
          " 'No internet connection. Connect to the internet and try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
