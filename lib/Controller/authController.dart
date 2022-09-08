import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../Utils/APIURLs.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController{

var isLoading = false.obs;



  Future<void> sendOTP(phoneNumber) async {
    isLoading.value = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": phoneNumber,
        });
        var response = await http.post(Uri.parse(APIUrls.LOG_IN), body: body);
        try {
          var convertJson = jsonDecode(response.body);

          if (convertJson["status"]) {

            isLoading.value = false;

          } else {
            isLoading.value = false;
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          isLoading.value = false;
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Something went wrong, try again later'),
          // ));
        }
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //       'No internet connection. Connect to the internet and try again.'),
      // ));
    }
  }
}