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
import 'package:freelancing/Screens/profile_copy.dart';
import 'package:freelancing/Utils/APIURLs.dart';
import 'package:get/get.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class profile_controller extends GetxController {
  int activeCurrentStep = 0;
  final formKey = GlobalKey<FormState>();
   final businessformKey = GlobalKey<FormState>();

// List<UserSkill> skillsList = [];

  UserDetailModelClass? userDetail;
  SkillModelClass? getSkill;
  GetQualificationModal? getQualification;
  GetExperienceModal? getExperience;
  CityDetailModelClass? getallcities;
  BankModelClass? getallBanks;
  // Qualification? selectedQuelification;
  WorkExp? selectedExperience;
  // String? qualification;
  String? experience;
  List<Qualification> highestQuelificationList = [];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailidController = TextEditingController();
  TextEditingController profileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController highestqualController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController businessPanController = TextEditingController();
  TextEditingController businessCity = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController cAccountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountHolder = TextEditingController();

  bool checkbox = false;

  // List<ValueItem> selectedSkill = [];
  List selectedSkill = [];
  List selectedCity = [];
  var qulificationId;

  File? panImage;
  String? panfront;
  String? aadharback;
  String? pic;
  String? gst;
  String? check;
  String? quelificationId;
  String? bankId;
  String? experinceId;
  // var imagePan;
  var imagegst;
  var imageaadhar;
  var imagecheque;
  var image1;
  var selectedGenderOne;
  var selectedqualificationOne;
  var selectedexperienceOne;
  DateTime selectedDate = DateTime.now();
  File? cameraImage;
  File? adharImage;

  File? cancelCheqImage;
  File? GstProofImage;
  final ImagePicker _picker = ImagePicker();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getuserDetail();
    getskilldata();
    getQualificationData();
    getExperienceData();
    getcitiesData();
    getBanksData();

  }

  selectSkill(item) {
    selectedSkill = item;
    update();
  }

  selectCity(item) {
    selectedCity = item;
    update();
  }

  selectQuelification(qualification) {
    quelificationId = qualification;
    selectedqualificationOne = qualification;
    highestqualController = TextEditingController(text: qualification);
    update();
  }

  selectBanks(bank) {
    bankId = bank;
    bankController = TextEditingController(text: bank);
    update();
  }

  List<Step> stepsList() => [
        Step(
            state:
                activeCurrentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: true,
            title: const Text("Personal"),
            content: PersonalDetail()),
        Step(
            state:
                activeCurrentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: true,
            title: const Text("Business "),
            content: BusinessDetail()),
        Step(
            state:
                activeCurrentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: true,
            title: const Text("Bank"),
            content: BankDetail()),
      ];

  List genderList = ['M', "F"];
  List serviceArea = ['Delhi', 'Mumbai', 'Bangalore', 'Noida', 'Gurgaon'];
  getQualificationData() async {
    getQualification = await ApiHelper().getQualification();
    update();
    print(getQualification!.data!.qualifications![0].qualificationName);
    getQualification!.data!.qualifications!.forEach(
      (element) {
        highestQuelificationList.add(Qualification(
            qualificationName: element.qualificationName, id: element.id));
        update();
      },
    );

    print("###################jjjj");
  }

  getskilldata() async {
    getSkill = await ApiHelper().getSkills();
    print(getSkill!.status);
    print("@@@@@@@@@@@@@@@@");
    update();
  }

  getcitiesData() async {
    getallcities = await ApiHelper().getCities();
    print(getallcities!.status);
    print(
        "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    update();
  }

  getBanksData() async {
    getallBanks = await ApiHelper().getBanksList();
    print(getallBanks!.status);
    print(
        "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<&&&&&&&&&&&&&&&&&");
    update();
  }

  getExperienceData() async {
    getExperience = await ApiHelper().getExperience();
    print(getExperience!.status);
    print("&&&&&&&&&&&&&&&&&&&&&");
  }
  gstNumberCheckBox(bool value) {
    checkbox = value;
    print(checkbox);
    update();
  }

  selectGender(gender) {
    genderController = TextEditingController(text: gender);
    selectedGenderOne= gender;
    update();
  }
    selectExperience(data) {
    //   = data.id.toString();
    experinceId = data;
    experienceController = TextEditingController(text: data);
    selectedexperienceOne = data;
    update();
  }
  getuserDetail() async {
    userDetail = await ApiHelper().getFrelencer();
    update();
    print("mainData fetch");
    // genderController.clear();
    update();
    if (userDetail != null) {
      if (userDetail!.status == true) {
        firstNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.firstName!);
        lastNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.lastName!);
        emailidController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.email!);
        profileController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.workTitle!);
        addressController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.address!);
        dobController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails!.dob!);
        selectedGenderOne = 
             userDetail!.data!.userDetails!.profileDetails!.gender;
        update();
        selectedqualificationOne = 
           userDetail!
                .data!.userDetails!.profileDetails!.highestQualification!;
        pancardController = TextEditingController(
            text: userDetail!
                .data!.userDetails!.profileDetails!.addressProofNumber!);
        aadharController = TextEditingController(
            text:
                userDetail!.data!.userDetails!.profileDetails!.idProofNumber!);
        panfront =
            userDetail!.data!.userDetails!.profileDetails!.addressProofDoc;
        aadharback = userDetail!.data!.userDetails!.profileDetails!.idProofDoc;
        selectedexperienceOne = 
           userDetail!.data!.userDetails!.profileDetails!.experience;
        print(experienceController.text);
        print("---------------8888-------------------------");
        // selectedQuelification = Qualification(
        //   id: userDetail!
        //         .data!.userDetails!.profileDetails!.highestQualification!,
        //  qualificationName: userDetail!.data!.userDetails!.profileDetails!.highestQualificationName
        //     );
        selectedExperience = WorkExp(
            name: userDetail!.data!.userDetails!.profileDetails!.experience!);
        userDetail!.data!.userDetails!.profileDetails!.skills!.forEach(
          (element) {
            selectedSkill.add(element.skillName);
          },
        );
        update();
        gstNumberController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.gstNumber ??"" );
        businessPanController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.panNumber);
        gst = userDetail!.data!.userDetails!.businessDetails?.gstDoc;

        userDetail!.data!.userDetails!.businessDetails?.serviceAreas!.forEach(
          (element) {
            selectedCity.add(element.serviceAreaName);
          },
        );
        accountController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountNo);
        ifscController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.ifscCode);
        accountHolder = TextEditingController(
            text:
                userDetail!.data!.userDetails!.bankDetails?.accountHolderName);
        check = userDetail!.data!.userDetails!.bankDetails?.cancelChecque;
        bankController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.bankName);
        accountTypeController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountType);
      }
    }
    update();
  }



  // selectqulificationr(Qualification data) {
  //    qualification = data.id;
  //   highestqualController = TextEditingController(text: data.qualificationName);
  //    selectedQuelification = data;

  //   update();
  // }



  Future<void> add_Personal_Details() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
    var user_id = sharedPreferneces.getString('user_id');
    List skillList = [];
    getSkill!.data!.skills!.forEach((element) {
      selectedSkill.forEach((e) {
        if (element.name == e) {
          skillList.add(element.id);
        }
      });
    });
    var data = skillList.join(",");
    print(data);
    print(experienceController.text);
    print("=========================7777================================");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, dynamic>{
          "phone_number": '$number',
          "user_id": '${sharedPreferneces.getString('user_id')}',
          "user_type": '2',
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": emailidController.text.toLowerCase(),
          "address": addressController.text,
          "work_title": profileController.text,
          "dob": dobController.text,
          "gender":selectedGenderOne,
          "highest_qualification": selectedqualificationOne,
          "id_proof_type": '1',
          "id_proof_no": aadharController.text,
          "id_proof_doc": aadharback,
          "address_proof_type": '2',
          "address_proof_number": pancardController.text,
          "address_proof_doc": panfront,
          "skills": data,
          "total_experience": selectedexperienceOne,
        });
        //  jsonEncode(<String, String>{
        //        "phone_number": '$number',
        //      "user_id": '${sharedPreferneces.getString('user_id')}',
        //     "user_type": '${widget.user}',
        //     "first_name": '$name',
        //     "last_name": '$lastName',
        //     "email": '$email',
        //     "address": '$address',
        //     "work_title": '$work',
        //     "dob": '$dob',
        //     "gender": '$gender',
        //     "highest_qualification": '$qualification',
        //     "id_proof_type": '1',
        //     "id_proof_no": '$pancard',
        //     "id_proof_doc": '$panfront',
        //     "address_proof_type": '2',
        //     "address_proof_number": '$aadharcard',
        //     "address_proof_doc": '$aadharback',
        //     "skills": "$multiSkill",
        //     "total_experience": '$experience',
        //   });
        print(' personal data >> $body');

        var response = await http.post(Uri.parse(APIUrls.ADD_PERSONAL_DETAILS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            //  setState(() {
            sharedPreferneces.setString(
                'user_id', '${convertJson['data']['user_id']}');
            //  _activeCurrentStep += 1;
            //  });
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('${convertJson['success_msg']}'),
            // ));
            // Get.to(Otp(number: phoneNumber));
            Get.snackbar("Data Submitted", convertJson['success_msg'],
                snackPosition: SnackPosition.BOTTOM);

            activeCurrentStep += 1;
            update();
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('${convertJson['error_msg']}'),
            // ));
          }
          update();
        } catch (e) {
          // if (kDebugMode) {
          print(e.toString());
          //  }

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
  }

  Future<void> postImage(imageName, file) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
    var user_id = sharedPreferneces.getString('user_id');
    print(imageName);
    print(file);

    print("xyzzzzz");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var request =
            http.MultipartRequest('POST', Uri.parse("${APIUrls.POST_IMAGES}"));
        request.files.add(await http.MultipartFile.fromPath('img', file));
        request.fields['phone_number'] = '$number';
        request.fields['img_name'] = '$imageName';
        request.headers['Authorization'] = 'Bearer $token';
        // print("In upload photo");
        var res = await request.send();
        print(res);
        print("xyz=========================================");
        try {
          // var convertJson = jsonDecode(res.body);
          //print(convertJson);
          print(res.statusCode);
          if (res.statusCode == 200) {
            print("xyzzzzz000000000000000000000000000000000000");
            var responseBody = await http.Response.fromStream(res);
            var myData = json.decode(responseBody.body);
            print(myData);
            print("0000000000000000000000000000000000000000000000000");

            if (myData['status']) {
              print(myData['data']['file_path']);
              if (imageName == "photo") {
                pic = myData['data']['file_path'];
              } else if (imageName == "id_proof_doc") {
                panfront = myData['data']['file_path'];
              } else if (imageName == "address_proof_doc") {
                aadharback = myData['data']['file_path'];
              } else if (imageName == "gst_doc") {
                gst = myData['data']['file_path'];
              } else if (imageName == "cancelled_cheque") {
                check = myData['data']['file_path'];
              }
            }
            // setState(() {
            //   bankData = convertJson['data']['banks'];
            // });
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('${convertJson['error_msg']}'),
            // ));
          }
          update();
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

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
  }
// ========================add business details=====================

  Future<void> register( var usertype) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
        var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
   
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",
          "user_type": usertype,
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
         
          
            


              sharedPreferneces.setString(
                  'user_id', '${convertJson['data']['user_id']}');

                   activeCurrentStep  = int.parse(convertJson['data']['user_status']);

                  update();
                    Get.to(() => profile_copy());
          
            // print(convertJson['data']['user_status']);
            // if (convertJson['data']['user_status'] != "3") {
            //   Get.to(() => profile_copy());
            //   // Get.to(() =>Profile(
            //   //     user: _selectUser,
            //   //     user_status: convertJson['data']['user_status'].toString()));
            //   print('user status ${convertJson['data']['user_status']}');
            // } else {
            //   // Get.to(Profile(user: _selectUser,
            //   //     user_status: convertJson['data']['user_status'].toString()));
            //   Get.to(profile_copy());
            // }
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
         
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
         Get.snackbar("Error","Something went wrong, try again later",
                snackPosition: SnackPosition.BOTTOM);
       
        }
      }
    } on SocketException catch (_) {
        Get.snackbar("Error"," 'No internet connection. Connect to the internet and try again.",
                snackPosition: SnackPosition.BOTTOM);
 
    }
  }




  Future<void> add_Business_Details() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
    var user_id = sharedPreferneces.getString('user_id');
    List cityList = [];
    getallcities!.data!.cities!.forEach((element) {
      selectedCity.forEach((e) {
        if (element.cityName == e) {
          cityList.add(element.cityId);
        }
      });
    });
    var data = cityList.join(",");
    print(data);
    print(
        "++++++++++++++++++++++++++++++++++++&&&&&&&&&&&&&&&&&&+++++++++++++");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = checkbox == true
            ? jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "have_gst_no": "1",
                "gst_number": gstNumberController.text,
                "gst_doc": "$gst",
                "pan_number": businessPanController.text,
                "service_area": data,
              })
            : jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "have_gst_no": "0",
                // "gst_number": "$gstnumber" ,
                // "gst_doc": "$gst",
                "pan_number": businessPanController.text,
                "service_area": "$data",
              });
        print(body);
        var response = await http.post(Uri.parse(APIUrls.ADD_BUSINESS_DETAILS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            Get.snackbar("Business Details ", convertJson['success_msg'],
                snackPosition: SnackPosition.BOTTOM);
            activeCurrentStep += 1;
            update();
            // Get.to(Otp(number: phoneNumber));
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
          }
          update();
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

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
  }

  Future<void> add_Bank_Details() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
    var user_id = sharedPreferneces.getString('user_id');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$number',
          "user_id": '${sharedPreferneces.getString('user_id')}',
          "bank": bankController.text,
          "account_no": accountController.text,
          "ifsc_code": ifscController.text,
          "account_holder_name": accountHolder.text,
          "cancel_checque": "$check",
          "account_type": accountTypeController.text
        });
        print(body);

        var response = await http.post(Uri.parse(APIUrls.ADD_Bank_DETAILS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            Get.snackbar("Bank Details ", convertJson['success_msg'],
                snackPosition: SnackPosition.BOTTOM);
            activeCurrentStep += 1;
            update();
            // Get.to(const Review());
            // Get.to(Otp(number: phoneNumber));
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
          }
          update();
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
    } on SocketException catch (_) {}
  }

  imgpan() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);

      postImage('id_proof_doc', file.path);
      // Get.back();
    }
    // address_proof_doc
    // isLoading = true;
    //  imagePan = image.path;
    print("image path");
    // print(imagePan);
    panImage = File(image.path);
    update();
    Get.back();
    // this.update_image();
  }

  imgaadhar() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('address_proof_doc', file.path);
      Get.back();
    }

    // isLoading = true;
    imageaadhar = image.path;
    print("image path");
    print(imageaadhar);
    adharImage = File(image.path);
    update();
    // Get.back();
    // this.update_image();
  }

  imggstdoc() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('gst_doc', file.path);
      Get.back();
    }
    // isLoading = true;
    imagegst = image.path;
    print("image path");
    print(imagegst);
    GstProofImage = File(image.path);
    update();
    Get.back();
    // this.update_image();
  }

  imgcheque() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('cancelled_cheque', file.path);
      Get.back();
    }
    // isLoading = true;
    imagecheque = image.path;
    print("image path");
    print(imagecheque);
    cancelCheqImage = File(image.path);
    update();
    // Get.back();
    // this.update_image();
  }

  imggallerypan() async {
    panImage = null;
    update();
    final XFile? galleryPanImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      galleryPanImage!.path,
      quality: 50,
    );
    if (galleryPanImage != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);

      postImage('id_proof_doc', file.path);
      // Get.back();
    }
    // isLoading = true;
    // imagePan = galleryPanImage.path;
    panImage = File(galleryPanImage.path);
    update();
    Get.back();
    // this.update_image();
  }

  imggalleryaadhar() async {
    adharImage = null;
    update();
    final XFile? galleryAdharImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      galleryAdharImage!.path,
      quality: 50,
    );
    if (galleryAdharImage != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('address_proof_doc', file.path);
      // Get.back();
    }
    // isLoading = true;
    imageaadhar = galleryAdharImage.path;
    adharImage = File(galleryAdharImage.path);
    update();
    Get.back();
    // this.update_image();
  }

  imggallerygst() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('gst_doc', file.path);
      Get.back();
    }
    // isLoading = true;
    imagegst = image.path;
    GstProofImage = File(image.path);
    update();
    // Get.back();
    // this.update_image();
  }

  imggallerycheque() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);
      postImage('cancelled_cheque', file.path);
      Get.back();
    }
    // isLoading = true;
    imagecheque = image.path;
    cancelCheqImage = File(image.path);
    update();
    // Get.back();
    // this.update_image();
  }

  selectDate(BuildContext context) async {
    DatePickerMode initialDatePickerMode1 = DatePickerMode.day;
    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: initialDatePickerMode1,
      context: context,
      initialDate: DateTime(1997), // Refer step 1
      firstDate: DateTime(1970),
      lastDate: DateTime(2004),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var formattedDate = dateFormat.format(selectedDate);
      dobController.text = formattedDate.toString();
    }
  }
}
