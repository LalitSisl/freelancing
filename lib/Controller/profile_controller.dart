import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/ApiHelper.dart';
import 'package:freelancing/Authentication/register.dart';
import 'package:freelancing/Model/BankModel.dart';
import 'package:freelancing/Model/city.dart';
import 'package:freelancing/Model/experienceModal.dart';
import 'package:freelancing/Model/qualificationModal.dart';
import 'package:freelancing/Model/skillModel.dart';
import 'package:freelancing/Model/stateModel.dart';
import 'package:freelancing/Model/typeofcompanymodel.dart';
import 'package:freelancing/Model/userModelClass.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/PersonalDetail.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/bank.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/business.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/vendorDetails.dart';
import 'package:freelancing/Screens/ProfileScreens/termandConditions.dart';
import 'package:freelancing/Screens/profile_copy.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:freelancing/Utils/APIURLs.dart';
import 'package:freelancing/global.dart';
import 'package:get/get.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class profile_controller extends GetxController {
  // registerController controllerRegister = Get.put(registerController());
  int activeCurrentStep = 0;
  final formKey = GlobalKey<FormState>();
  final businessformKey = GlobalKey<FormState>();
  final bankformKey = GlobalKey<FormState>();

  var profileName;

// List<UserSkill> skillsList = [];

  UserDetailModelClass? userDetail;
  SkillModelClass? getSkill;
  GetQualificationModal? getQualification;
  GetExperienceModal? getExperience;
  CityDetailModelClass? getallcities;
  CityDetailModelClass? getallcitiesrepeat;
  BankModelClass? getallBanks;
  StateModelClass? getallStates;
  TypeofcompanyModel? getallcompanytypes;
  // Qualification? selectedQuelification;
  WorkExp? selectedExperience;
  // String? qualification;
  String? experience;
  List<Qualification> highestQuelificationList = [];
// ============================Personal Details=========================
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
  // ==============================Business Details=================
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController businessPanController = TextEditingController();
  TextEditingController businessCity = TextEditingController();
  // =============================Bank Details======================
  TextEditingController bankController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController cAccountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountHolder = TextEditingController();
// ===========================Vendor Deatils=====================

  TextEditingController companyName = TextEditingController();
  TextEditingController accountGroup = TextEditingController();
  TextEditingController vendorRequired = TextEditingController();
  TextEditingController companyEmail = TextEditingController();
  TextEditingController comapnyState = TextEditingController();
  TextEditingController comapnyCity = TextEditingController();
  TextEditingController companyPincode = TextEditingController();
  TextEditingController companyPhone = TextEditingController();
  TextEditingController autualTurnover = TextEditingController();
  TextEditingController typeOfCompany = TextEditingController();
  TextEditingController contactFirstname = TextEditingController();
  TextEditingController contactLastname = TextEditingController();
  TextEditingController contactPosition = TextEditingController();
  TextEditingController contactPhonenumber = TextEditingController();

  bool checkbox = false;
  bool bankdetails = false;
  // List<ValueItem> selectedSkill = [];
  List selectedSkill = [];
  List selectedCity = [];
  var qulificationId;

  File? panImage;
  File? profileimage;
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
  var profilePic;
  var imagecheque;
  var image1;
  var selectedGenderOne;
  var selectedqualificationOne;
  var selectedexperienceOne;
  var selectedbankOne;
  var selectedAccountType;
  var selectedAccountGroup;
  var selectedVendor;
  var selectedStateOne;
  var selectedCityone;
  var selectedcompanytype;
  var vendorType;
  var designation;
  var loginNumber;
  var name = '[Name]';
  var lastName = '';
  var profile = '[Profile]';
  var address = "[Address]";
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
    // getuserDetail();
    getskilldata();
    getQualificationData();
    getExperienceData();
    getcitiesData();
    getStatesData();
    getBanksData();
    getcitiesDatarepeat();
    getcompanytypes();
    // print(selectUser);
    // print(selectUser);

    print(")))))))))))))))))))))))))))))))))))))))))))))))");
  }

  selectSkill(item) {
    selectedSkill = item;
    update();
  }

  changeCardName(value) {
    name = value;
    update();
  }

  changeVendoraddress(value) {
    address = value;
    update();
  }

  changeCardLastname(value) {
    lastName = value;
    update();
  }

  changeCardProfile(value) {
    profile = value;
    update();
  }

  changeCardAddress(value) {
    address = value;
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
    selectedbankOne = bank;
    update();
  }

  selectAccount(type) {
    accountTypeController = TextEditingController(text: type);
    selectedAccountType = type;
    update();
  }

  selectAccountgroup(group) {
    accountGroup = TextEditingController(text: group);
    selectedAccountGroup = group;
    update();
  }

  selectVendorrequired(required) {
    vendorRequired = TextEditingController(text: required);
    selectedVendor = required;
    update();
  }

  List<Step> stepsList() => [
        Step(
            state:
                activeCurrentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: true,
            title: Text(selectUser == "2" ? "Personal" : "Vendor"),
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
    // print(getSkill!.status);
    // print("@@@@@@@@@@@@@@@@");
    update();
  }

  getcitiesData() async {
    getallcities = await ApiHelper().getCities(selectedStateOne);
    // print(getallcities!.status);
    // print(
    //     "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    update();
  }

  getcitiesDatarepeat() async {
    getallcitiesrepeat = await ApiHelper().getallCitiesrepeat();
    // print(getallcities!.status);
    // print(
    //     "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    update();
  }

  getStatesData() async {
    getallStates = await ApiHelper().getStates();
    // print(getallStates!.status);
    // print(
    //     "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<States<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    update();
  }

  getBanksData() async {
    getallBanks = await ApiHelper().getBanksList();
    // print(getallBanks!.status);
    // print(
    //     "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<&&&&&&&&&&&&&&&&&");
    update();
  }

  getcompanytypes() async {
    getallcompanytypes = await ApiHelper().getVendorComapnyType();
    // print(getallBanks!.status);
    // print(
    //     "@@@@@@@@@@@@@@@@@@@@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<&&&&&&&&&&&&&&&&&");
    update();
  }

  getExperienceData() async {
    getExperience = await ApiHelper().getExperience();
    // print(getExperience!.status);
    // print("&&&&&&&&&&&&&&&&&&&&&");
  }

  gstNumberCheckBox(bool value) {
    checkbox = value;
    print(checkbox);
    update();
  }

  bankdetailsoptional(bool value) {
    bankdetails = value;
    print(bankdetails);
    update();
  }

  selectGender(gender) {
    genderController = TextEditingController(text: gender);
    selectedGenderOne = gender;
    update();
  }

  selectExperience(data) {
    //   = data.id.toString();
    experinceId = data;
    experienceController = TextEditingController(text: data);
    selectedexperienceOne = data;
    update();
  }

  selectVendorstate(data) {
    //   = data.id.toString();
    // experinceId = data;
    comapnyState = TextEditingController(text: data);
    selectedStateOne = data;
    update();
  }

  selectVendorcity(data) {
    //   = data.id.toString();
    // experinceId = data;
    comapnyCity = TextEditingController(text: data);
    selectedCityone = data;
    update();
  }

  var userNumber;
  selectcompanytype(data) {
    //   = data.id.toString();
    // experinceId = data;
    typeOfCompany = TextEditingController(text: data);
    selectedcompanytype = data;
    update();
  }

  getuserDetail() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    userDetail = await ApiHelper().getFrelencer();
    userNumber = sharedPreferneces.getString("phone");
    loginNumber = userNumber;
    update();
    // print(userDetail!.status);
    print("mainData fetch");
    print(userDetail);
    print(userDetail?.status);

    //  print(userDetail?.data!.userDetails!.vendorDetails!.companyName);
    // genderController.clear();
    update();
    if (userDetail != null) {
      if (userDetail!.status == true) {
        // ==============================Vendor details=======================

        companyName = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.companyName);
        designation =
            userDetail!.data!.userDetails!.vendorDetails?.contactPosition;
        // profileName = userDetail!.data!.userDetails!.vendorDetails?.companyName;
        selectedAccountGroup =
            userDetail!.data!.userDetails!.vendorDetails?.accountGroup;
        selectedVendor =
            userDetail!.data!.userDetails!.vendorDetails?.vendorRequiredFor;
        companyEmail = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.contactEmail);
        selectedStateOne =
            userDetail!.data!.userDetails!.vendorDetails?.vendorState;
        selectedCityone =
            userDetail!.data!.userDetails!.vendorDetails?.vendorCity;
        selectedcompanytype =
            userDetail!.data!.userDetails!.vendorDetails?.vendorCompanyType;
        companyPincode = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.vendorPin);
        companyPhone = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.vendorPhone);
        autualTurnover = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.turnover);
        contactFirstname = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactFirstName);
        contactLastname = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactLastName);
        contactPosition = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactPosition);
        contactPhonenumber = TextEditingController(
            text: userDetail!
                .data!.userDetails!.vendorDetails?.contactPhoneNumber);
        print(contactPhonenumber);
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@dfdgdfgdfgdgdgdf######################");
        // =================================================
        name = userDetail!.data!.userDetails!.profileDetails!.firstName!;
        lastName = userDetail!.data!.userDetails!.profileDetails!.lastName!;
        profile = userDetail!.data!.userDetails!.profileDetails!.workTitle!;
        address = userDetail!.data!.userDetails!.profileDetails!.address!;
        firstNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.firstName!);
        lastNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.lastName!);
        emailidController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.email!);
        profileController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.workTitle!);
        addressController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.address!);
        dobController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.dob!);
        selectedGenderOne =
            userDetail!.data!.userDetails!.profileDetails?.gender;
        update();
        selectedqualificationOne = userDetail!
            .data!.userDetails!.profileDetails?.highestQualification!;
        pancardController = TextEditingController(
            text: userDetail!
                .data!.userDetails!.profileDetails?.addressProofNumber!);
        aadharController = TextEditingController(
            text:
                userDetail!.data!.userDetails!.profileDetails?.idProofNumber!);
        panfront =
            userDetail!.data!.userDetails!.profileDetails?.addressProofDoc;
        aadharback = userDetail!.data!.userDetails!.profileDetails?.idProofDoc;
        selectedexperienceOne =
            userDetail!.data!.userDetails!.profileDetails?.experience;
        print(experienceController.text);
        print("---------------8888-------------------------");
        // selectedQuelification = Qualification(
        //   id: userDetail!
        //         .data!.userDetails!.profileDetails!.highestQualification!,
        //  qualificationName: userDetail!.data!.userDetails!.profileDetails!.highestQualificationName
        //     );
        selectedExperience = WorkExp(
            name: userDetail!.data!.userDetails!.profileDetails?.experience!);
        userDetail!.data!.userDetails!.profileDetails?.skills!.forEach(
          (element) {
            selectedSkill.add(element.skillName);
          },
        );
        update();
        // ==========================Business Details==============================
        userDetail!.data!.userDetails!.businessDetails!.gstNumber != null
            ? checkbox = true
            : checkbox = false;
        gstNumberController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.gstNumber!);
        businessPanController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.panNumber!);
        gst = userDetail!.data!.userDetails!.businessDetails?.gstDoc;

        userDetail!.data!.userDetails!.businessDetails?.serviceAreas!.forEach(
          (element) {
            selectedCity.add(element.serviceAreaName);
          },
        );
        // userDetail!.data!.userDetails!.businessDetails?.gstNumber != null?checkbox==true:checkbox==false;
        // ==============================Bank Details Data===============================
        accountController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountNo);
        cAccountController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountNo);
        ifscController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.ifscCode);
        accountHolder = TextEditingController(
            text:
                userDetail!.data!.userDetails!.bankDetails?.accountHolderName);
        check = userDetail!.data!.userDetails!.bankDetails?.cancelChecque;
        selectedbankOne = userDetail!.data!.userDetails!.bankDetails?.bank;
        accountTypeController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountType);

        update();
      }
    }
    update();
  }

  getvendorDetail() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    userDetail = await ApiHelper().getVendor();
    userNumber = sharedPreferneces.getString("phone");
    loginNumber = userNumber;
    update();
    // print(userDetail!.status);
    print("mainData fetch");
    print(userDetail);
    print(userDetail?.status);

    //  print(userDetail?.data!.userDetails!.vendorDetails!.companyName);
    // genderController.clear();
    update();
    if (userDetail != null) {
      if (userDetail!.status == true) {
        // ==============================Vendor details=======================
        address = userDetail!.data!.userDetails!.vendorDetails!.companyName!;
        name = userDetail!.data!.userDetails!.vendorDetails!.contactFirstName!;
        lastName =
            userDetail!.data!.userDetails!.vendorDetails!.contactLastName!;
        profile =
            userDetail!.data!.userDetails!.vendorDetails!.contactPosition!;
        companyName = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.companyName);
        designation =
            userDetail!.data!.userDetails!.vendorDetails?.contactPosition;
        // profileName = userDetail!.data!.userDetails!.vendorDetails?.companyName;
        selectedAccountGroup =
            userDetail!.data!.userDetails!.vendorDetails?.accountGroup;
        selectedVendor =
            userDetail!.data!.userDetails!.vendorDetails?.vendorRequiredFor;
        companyEmail = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.contactEmail);
        selectedStateOne =
            userDetail!.data!.userDetails!.vendorDetails?.vendorState;
        selectedCityone =
            userDetail!.data!.userDetails!.vendorDetails?.vendorCity;
        selectedcompanytype =
            userDetail!.data!.userDetails!.vendorDetails?.vendorCompanyType;
        companyPincode = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.vendorPin);
        companyPhone = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.phoneNumber);
        autualTurnover = TextEditingController(
            text: userDetail!.data!.userDetails!.vendorDetails?.turnover);
        contactFirstname = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactFirstName);
        contactLastname = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactLastName);
        contactPosition = TextEditingController(
            text:
                userDetail!.data!.userDetails!.vendorDetails?.contactPosition);
        contactPhonenumber = TextEditingController(
            text: userDetail!
                .data!.userDetails!.vendorDetails?.contactPhoneNumber);
        print(contactPhonenumber);
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@dfdgdfgdfgdgdgdf######################");
        // =================================================
        // name =userDetail!.data!.userDetails!.profileDetails!.firstName!;  userDetail!.data!.userDetails!.profileDetails!.lastName;
        profileName = userDetail!.data!.userDetails!.profileDetails?.workTitle;
        // address =userDetail!.data!.userDetails!.profileDetails!.address!;
        firstNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.firstName!);
        lastNameController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.lastName!);
        emailidController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.email!);
        profileController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.workTitle!);
        addressController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.address!);
        dobController = TextEditingController(
            text: userDetail!.data!.userDetails!.profileDetails?.dob!);
        selectedGenderOne =
            userDetail!.data!.userDetails!.profileDetails?.gender;
        update();
        selectedqualificationOne = userDetail!
            .data!.userDetails!.profileDetails?.highestQualification!;
        pancardController = TextEditingController(
            text: userDetail!
                .data!.userDetails!.profileDetails?.addressProofNumber!);
        aadharController = TextEditingController(
            text:
                userDetail!.data!.userDetails!.profileDetails?.idProofNumber!);
        panfront =
            userDetail!.data!.userDetails!.profileDetails?.addressProofDoc;
        aadharback = userDetail!.data!.userDetails!.profileDetails?.idProofDoc;
        selectedexperienceOne =
            userDetail!.data!.userDetails!.profileDetails?.experience;
        print(experienceController.text);
        print("---------------8888-------------------------");
        // selectedQuelification = Qualification(
        //   id: userDetail!
        //         .data!.userDetails!.profileDetails!.highestQualification!,
        //  qualificationName: userDetail!.data!.userDetails!.profileDetails!.highestQualificationName
        //     );
        selectedExperience = WorkExp(
            name: userDetail!.data!.userDetails!.profileDetails?.experience!);
        userDetail!.data!.userDetails!.profileDetails?.skills!.forEach(
          (element) {
            selectedSkill.add(element.skillName);
          },
        );
        update();
        // ==========================Business Details==============================
        gstNumberController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.gstNumber!);
        businessPanController = TextEditingController(
            text: userDetail!.data!.userDetails!.businessDetails?.panNumber!);
        gst = userDetail!.data!.userDetails!.businessDetails?.gstDoc;

        userDetail!.data!.userDetails!.businessDetails?.serviceAreas!.forEach(
          (element) {
            selectedCity.add(element.serviceAreaName);
          },
        );
        // userDetail!.data!.userDetails!.businessDetails?.gstNumber != null?checkbox==true:checkbox==false;
        // ==============================Bank Details Data===============================
        accountController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountNo);
        cAccountController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountNo);
        ifscController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.ifscCode);
        accountHolder = TextEditingController(
            text:
                userDetail!.data!.userDetails!.bankDetails?.accountHolderName);
        check = userDetail!.data!.userDetails!.bankDetails?.cancelChecque;
        selectedbankOne = userDetail!.data!.userDetails!.bankDetails?.bank;
        accountTypeController = TextEditingController(
            text: userDetail!.data!.userDetails!.bankDetails?.accountType);

        update();
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
          "gender": selectedGenderOne,
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
                duration: const Duration(seconds: 1),
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

  Future<void> add_Vendor_Details() async {
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
          "company_name": companyName.text,
          "account_group": "$selectedAccountGroup",
          "vendor_required_for": "$selectedVendor",
          "vendor_state": "$selectedStateOne",
          "vendor_city": "$selectedCityone",
          "vendor_pin": companyPincode.text,
          "vendor_phone": companyPhone.text,
          "turnover": autualTurnover.text,
          "vendor_company_type": "1",
          "contact_first_name": contactFirstname.text,
          "contact_last_name": contactLastname.text,
          "contact_phone_number": contactPhonenumber.text,
          "contact_email": companyEmail.text,
          "user_type": "1",
          "contact_position": contactPosition.text,
        });
        //   jsonEncode(<String, String>{
        //   "phone_number": '$number',
        //   "user_id": '${sharedPreferneces.getString('user_id')}',
        //   "company_name": "$companyname",
        //   "account_group": "$_selectaccount",
        //   "vendor_required_for": "$_selectvendor",
        //   "vendor_state": "$vendor_state",
        //   "vendor_city": "$vendor_city",
        //   "vendor_pin": "$pincode",
        //   "vendor_phone": "$phone",
        //   "turnover": "$turnover",
        //   "vendor_company_type": "$vendor_company",
        //   "contact_first_name":"$c_firstName",
        //   "contact_last_name":"$c_lastName",
        //   "contact_phone_number": "$c_phone",
        //   "contact_email": "$email",
        //   "user_type":"1",
        //   "contact_position": "$c_position",
        // });
        print(body);

        var response = await http.post(Uri.parse(APIUrls.ADD_VENDOR_DETAILS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            Get.snackbar("Data Submitted", convertJson['success_msg'],
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);

            activeCurrentStep += 1;
            update();
          } else {
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          Get.snackbar("Error", 'Something went wrong, try again later',
              snackPosition: SnackPosition.BOTTOM);
          update();
        }
      }
    } on SocketException catch (_) {
      Get.snackbar("Error",
          'No internet connection. Connect to the internet and try again.',
          snackPosition: SnackPosition.BOTTOM);
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
                "service_area": "$data",
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
                duration: const Duration(seconds: 1),
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
        var body = bankdetails == false
            ? jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "skip_bank_details": '0',
                "bank": selectedbankOne,
                "account_no": accountController.text,
                "ifsc_code": ifscController.text,
                "account_holder_name": accountHolder.text,
                "cancel_checque": "$check",
                "account_type": accountTypeController.text
              })
            : jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "skip_bank_details": '1',
              });
        print(body);
        var response = await http.post(Uri.parse(APIUrls.ADD_Bank_DETAILS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            Get.snackbar("Bank Details ", convertJson['success_msg'],
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);
            // Get.to(const Review());
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
        }
      }
    } on SocketException catch (_) {}
  }

  Future<void> agree_term_conditions() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    var number = sharedPreferneces.getString('number');
    var token = sharedPreferneces.getString('token');
    var user_id = sharedPreferneces.getString('user_id');
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = agree_tnc == false
            ? jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "agree_tnc": '0',
              })
            : jsonEncode(<String, String>{
                "phone_number": '$number',
                "user_id": '${sharedPreferneces.getString('user_id')}',
                "agree_tnc": '1',
              });
        print(body);
        var response = await http.post(Uri.parse(APIUrls.AGREE_TERM_CONDITIONS),
            headers: {'Authorization': 'Bearer $token'}, body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            Get.snackbar("Term And Conditions ", convertJson['success_msg'],
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);
            // Get.to(const Review());
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

  imgprofile() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File compressedFile = await FlutterNativeImage.compressImage(
      image!.path,
      quality: 50,
    );
    if (image != null) {
      final File file = File(compressedFile.path);
      //pic = File(image1.path);

      postImage('photo', file.path);
      // Get.back();
    }
    // address_proof_doc
    // isLoading = true;
    profilePic = image.path;
    print("image path");
    // print(imagePan);
    profileimage = File(image.path);
    update();

    // Get.back();
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
      firstDate: DateTime(1942),
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
