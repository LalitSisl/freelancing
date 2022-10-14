import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
import '../Model/subject_data_model.dart';
import '../Utils/APIURLs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataController extends GetxController {
  List<SubjectModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];

  Future<void> getSkills() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    subjectData.clear();
    dropDownData.clear();
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
            List<SubjectModel> tempSubjectData = [];
            convertJson['data']['skills'].forEach(
              (data) {
                tempSubjectData.add(
                  SubjectModel(
                    subjectId: data['id'],
                    subjectName: data['name'],
                  ),
                );
              },
            );
            //print(tempSubjectData);
            subjectData.addAll(tempSubjectData);
            subjectData.forEach(((element) {
              print(element.subjectName);
            }));
            print("========");

            dropDownData = subjectData.map((subjectdata) {
              return MultiSelectItem(subjectdata, subjectdata.subjectName);
            }).toList();

            update();
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }
}

class AppDataControllerCIty extends GetxController {
  List<SubjectModel> subjectDatacity = [];
  List<MultiSelectItem> dropDownDatacity = [];

  Future<void> getCity() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    subjectDatacity.clear();
    dropDownDatacity.clear();
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
          //print(convertJson);
          if (convertJson["status"]) {
            List<SubjectModel> tempSubjectDatacity = [];
            convertJson['data']['cities'].forEach(
              (data) {
                tempSubjectDatacity.add(
                  SubjectModel(
                    subjectId: data['city_id'],
                    subjectName: data['city_name'],
                  ),
                );
              },
            );
            print(tempSubjectDatacity);
            subjectDatacity.addAll(tempSubjectDatacity);

            dropDownDatacity = subjectDatacity.map((subjectdata) {
              return MultiSelectItem(subjectdata, subjectdata.subjectName);
            }).toList();

            update();
          } else {}
        } catch (e) {}
      }
    } on SocketException catch (_) {}
  }
}
