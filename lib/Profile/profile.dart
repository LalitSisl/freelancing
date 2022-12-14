import 'dart:convert';

import 'dart:io';
import 'dart:ui';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../Controller/app_data_controller.dart';
import '../Model/subject_data_model.dart';
import '../Utils/APIURLs.dart';
import 'Multiple Select/multi_select.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

class Profile extends StatefulWidget {
  String? user;
  String? user_status;
  Profile({Key? key, required this.user, required this.user_status}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AppDataController controller = Get.put(AppDataController());
  final AppDataControllerCIty controllercity = Get.put(AppDataControllerCIty());
  List subjectData = [];
  List subjectDatacity = [];

  // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  // controller.getSubjectData();
  // });




  var _selectaccount;
  var _selectvendor;
  var addr1 ='';
  int _activeCurrentStep = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController business = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();

  //Vendor
  TextEditingController company_name = TextEditingController();
  TextEditingController search_item = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController fax = TextEditingController();
  TextEditingController c_firstName = TextEditingController();
  TextEditingController c_lastName = TextEditingController();
  TextEditingController company_email = TextEditingController();
  TextEditingController c_position = TextEditingController();
  TextEditingController c_phone = TextEditingController();
  TextEditingController turnover = TextEditingController();

  // idebtity
  TextEditingController pancard = TextEditingController();
  TextEditingController aadharcard = TextEditingController();

  // business
  TextEditingController gstnumber = TextEditingController();
  TextEditingController businessPanCard = TextEditingController();
  TextEditingController companyname = TextEditingController();

  // bank
  TextEditingController accNumber = TextEditingController();
  TextEditingController confirmAccNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController accHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();

var skill;

  Future<void> getUSERALLDETAILS() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "${sharedPreferneces.getString('number')}",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_USER_COMPLETE_DETAILS}", queryParams),
            headers: {'Authorization': 'Bearer ${sharedPreferneces.getString('token')}'});
        // var response = await http.post(Uri.parse(APIUrls.LOG_IN, queryParams),
        //     headers: {'Authorization': 'Bearer ${SharedPref.token}'});
        try {
          var convertJson = jsonDecode(response.body);
          print('   lalit $convertJson');
          if (convertJson["status"]) {
            setState(() {

              if(widget.user == "2") {
                sharedPreferneces.setString('user_id',
                    '${convertJson['data']['user_details']['profile_details']['id']}');
                name =
                '${convertJson['data']['user_details']['profile_details']['first_name']} ${convertJson['data']['user_details']['profile_details']['last_name']} ';
                profile =
                '${convertJson['data']['user_details']['profile_details']['work_title']}';
                addr =
                '${convertJson['data']['user_details']['profile_details']['address']}';
                firstName.text =
                '${convertJson['data']['user_details']['profile_details']['first_name']}';
                lastName.text =
                '${convertJson['data']['user_details']['profile_details']['last_name']}';
                email.text =
                '${convertJson['data']['user_details']['profile_details']['email']}';
                address.text =
                '${convertJson['data']['user_details']['profile_details']['address']}';
                work.text =
                '${convertJson['data']['user_details']['profile_details']['work_title']}';
                dob.text =
                '${convertJson['data']['user_details']['profile_details']['dob']}';
                panfront =
                '${convertJson['data']['user_details']['profile_details']['id_proof_doc']}';
                aadharback =
                '${convertJson['data']['user_details']['profile_details']['address_proof_doc']}';
                gender = '${convertJson['data']['user_details']['profile_details']['gender']}';
               qualification = '${convertJson['data']['user_details']['profile_details']['highest_qualification']}';
                experience = '${convertJson['data']['user_details']['profile_details']['experience']}';
                pancard.text =
                '${convertJson['data']['user_details']['profile_details']['id_proof_number']}';
                aadharcard.text =
                '${convertJson['data']['user_details']['profile_details']['address_proof_number']}';
                 skill =
                '${convertJson['data']['user_details']['profile_details']['skills']['skill_id']}';
             
              }else {
                name = '${convertJson['data']['user_details']['vendor_details']['company_name']}';
                addr = '${convertJson['data']['user_details']['vendor_details']['vendor_city_name']}, ${convertJson['data']['user_details']['vendor_details']['vendor_state_name']} ${convertJson['data']['user_details']['vendor_details']['vendor_pin']}';
                company_name.text = '${convertJson['data']['user_details']['vendor_details']['company_name']}';
                pincode.text = '${convertJson['data']['user_details']['vendor_details']['vendor_pin']}';
                phone.text = '${convertJson['data']['user_details']['vendor_details']['vendor_phone']}';
                turnover.text = '${convertJson['data']['user_details']['vendor_details']['turnover']}';
                c_firstName.text = '${convertJson['data']['user_details']['vendor_details']['contact_first_name']}';
                c_lastName.text = '${convertJson['data']['user_details']['vendor_details']['contact_last_name']}';
                company_email.text = '${convertJson['data']['user_details']['vendor_details']['contact_email']}';
                c_position.text = '${convertJson['data']['user_details']['vendor_details']['contact_position']}';
                c_phone.text = '${convertJson['data']['user_details']['vendor_details']['contact_phone_number']}';
               // _selectaccount = '${convertJson['data']['user_details']['vendor_details']['account_group']}';
                vendor_state = '${convertJson['data']['user_details']['vendor_details']['vendor_state']}';
                vendor_city = '${convertJson['data']['user_details']['vendor_details']['vendor_city']}';
                vendor_company = '${convertJson['data']['user_details']['vendor_details']['vendor_company_type']}';
              }
              // print('>>>>>>>>>>sandeep ${skill}');
              if(gstnumber.text != null){
                _checkbox = true;
                _checkboxvalue = 1;
              }
              var service_areas_arrey  = convertJson['data']['user_details']['business_details']['service_areas'];

              for (var imageAsset in service_areas_arrey) {
                // subjectDatacity = convertJson['data']['user_details']['business_details']['service_areas'][i]['service_area_id'];
                 print('area>>>>>>>>>>>>>${imageAsset['service_area_id']}');
                 subjectDatacity.add(imageAsset['service_area_id']);
                 print('are/////>$subjectDatacity');
              
              }
              //subjectDatacity = imageAsset['service_area_id'];
              gstnumber.text = '${convertJson['data']['user_details']['business_details']['gst_number']}';
               gst = '${convertJson['data']['user_details']['business_details']['gst_doc']}';
               businessPanCard.text = '${convertJson['data']['user_details']['business_details']['pan_number']}';
               bank = '${convertJson['data']['user_details']['bank_details']['bank']}';
               accNumber.text = '${convertJson['data']['user_details']['bank_details']['account_no']}';
               confirmAccNumber.text = '${convertJson['data']['user_details']['bank_details']['account_no']}';
               ifsc.text = '${convertJson['data']['user_details']['bank_details']['ifsc_code']}';
              // acctype = '${convertJson['data']['user_details']['bank_details']['account_type']}';
               accHolderName.text = '${convertJson['data']['user_details']['bank_details']['account_holder_name']}';
               check = '${convertJson['data']['user_details']['bank_details']['cancel_checque']}';
               // vendor

            });
          } else {
            // setState(() {
            //   isLoading = false;
            // });
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('${convertJson['error_msg']}'),
            // ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
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
  }







  //vendor dropdown
  var vendor_city;
  var vendor_state;
  var vendor_company;

  // ignore: prefer_typing_uninitialized_variables
  var gender;
  var qualification;
  var workcity;
  var acctype;
  var bank;
  // ignore: prefer_typing_uninitialized_variables
  var panDropdown;
  // ignore: prefer_typing_uninitialized_variables
  var aadhar;

  String? multiSkill;
  String? multiCity;


  var experience;
  var name = "[Name]";
  var profile = "[Profile]";
  var phone_no = "[Phone Number]";
  var addr = "[Address]";
  var sr = '';
  bool _checkbox = false;
  var _checkboxvalue;

  String? panfront;
  File? aadharfront;
  String? aadharback;
  String? pic;
  String? gst;
  String? check;

  // var items = [
  //   'Male',
  //   'Female',
  // ];

// mutli sleect state

  List<String> _selectedItems = [];
  List<String> _selectedItemscity = [];
  List _selectedItemsskill = [];
  var selectedItem;

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'Delhi',
      'Mumbai',
      'Bangalore',
      'Noida',
      'Gurgaon',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  void _showMultiSelectcity() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'Roorkee',
      'Dehradun',
      'Saharanpur',
      'Patna',
      'Agra',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectcity(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItemscity = results;
      });
    }
  }

  @override
  initState() {
    super.initState();
    print('>>>>>>>>>> $_checkbox');
    print(widget.user);
    //getSkills();
    getQualification();
    getBank();
    getdata();
    getExperience();
    getStates();
    getVendorComapnyType();
    getUSERALLDETAILS();

    //controller.getSubjectData();
    controller.getSkills();
    controllercity.getCity();
  }

  var number;
  var token;
  var user_id;
  void getdata() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
   setState(() {
     if(widget.user_status == "0"){
     _activeCurrentStep = 0;
     }else if(widget.user_status == "1"){
       _activeCurrentStep = 1;
     }else if(widget.user_status == "2"){
       _activeCurrentStep = 2;
     }
     number = sharedPreferneces.getString('number');
     token = sharedPreferneces.getString('token');
     user_id = sharedPreferneces.getString('user_id');
   });
  }
  List<dynamic> _items =<dynamic>[];
  void _showMultiSelectskill() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    // _items  = [
    //   'Computer Network',
    //   'Flutter',
    //   'Developer',
    //   'Web Developer',
    // ];

     List results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectskill(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItemsskill = results;
      });
    }
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    DatePickerMode initialDatePickerMode1 = DatePickerMode.day;
    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: initialDatePickerMode1,
      context: context,
      initialDate: DateTime(1997), // Refer step 1
      firstDate: DateTime(1970),
      lastDate: DateTime(2004),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        var formattedDate = dateFormat.format(selectedDate);
        dob.text = formattedDate.toString();
      });
    }
  }

  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          
          title:  Text(widget.user == "1" ?'Vendor' : 'Personal'),
          //subtitle: const Text('Personal Details'),
          content: SingleChildScrollView(
            child: Form(
              key: formKeys[0],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  TextFormField(
                    controller: widget.user == "2" ? firstName : company_name,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                        labelText:
                            widget.user == "2" ? 'First Name' : 'Company Name',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorPalette.themeBlue, width: 0.5),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorPalette.themeBlue, width: 0.5),
                        ),
                        labelStyle: SWANWidget.fieldLabelTextStyle,
                        counterText: ""),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                    ],
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        name = value;
                        if (value.isEmpty) {
                          name = '[Name]';
                        }
                      });
                    },
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    style: SWANWidget.fieldValueTextStyle,
                    maxLength: 250,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The field is mandatory';
                      }
                      return null;
                    },
                  ),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),

                  widget.user == "1"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Account Group',
                                style: TextStyle(
                                    color: ColorPalette.themeBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ]),
                            //textScaleFactor: labelTextScale,
                          ),
                        )
                      : Container(),

                  widget.user == "1"
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          leading: Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'Domestic',
                              groupValue: _selectaccount,
                              onChanged: (value) {
                                setState(() {
                                  _selectaccount = value!;
                                  print(_selectaccount);
                                });
                              },
                            ),
                          ),
                          title: Text(
                            'Domestic',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12, color: Colors.black),
                          ),
                        )
                      : Container(),
                  widget.user == "1"
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          leading: Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'One time Vendor',
                              groupValue: _selectaccount,
                              onChanged: (value) {
                                setState(() {
                                  _selectaccount = value!;
                                  print(_selectaccount);
                                });
                              },
                            ),
                          ),
                          title: Text(
                            'One time Vendor',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12, color: Colors.black),
                          ),
                        )
                      : Container(),

                  widget.user == "1"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Vendor required for',
                                style: TextStyle(
                                    color: ColorPalette.themeBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ]),
                            //textScaleFactor: labelTextScale,
                          ),
                        )
                      : Container(),

                  widget.user == "1"
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          leading: Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'For project supply/service',
                              groupValue: _selectvendor,
                              onChanged: (value) {
                                setState(() {
                                  _selectvendor = value!;
                                });
                              },
                            ),
                          ),
                          title: Text(
                            'For project supply/service',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12, color: Colors.black),
                          ),
                        )
                      : Container(),
                  widget.user == "1"
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          leading: Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'IT',
                              groupValue: _selectvendor,
                              onChanged: (value) {
                                setState(() {
                                  _selectvendor = value!;
                                });
                              },
                            ),
                          ),
                          title: Text(
                            'IT',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12, color: Colors.black),
                          ),
                        )
                      : Container(),
  widget.user == "1"
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          leading: Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'Other',
                              groupValue: _selectvendor,
                              onChanged: (value) {
                                setState(() {
                                  _selectvendor = value!;
                                });
                              },
                            ),
                          ),
                          title: Text(
                            'Other',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12, color: Colors.black),
                          ),
                        )
                      : Container(),
                  widget.user == "1"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Vendor Details',
                                style: TextStyle(
                                    color: ColorPalette.themeBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ]),
                            //textScaleFactor: labelTextScale,
                          ),
                        )
                      : Container(),

                  widget.user == "2"
                      ? TextFormField(
                          controller: lastName,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(12),
                              labelText: widget.user == "2"
                                  ? 'Last Name'
                                  : 'Search Item',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              labelStyle: SWANWidget.fieldLabelTextStyle,
                              counterText: ""),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]'))
                          ],
                          onChanged: (value) {
                            setState(() {
                              sr = value;
                              if (value.isEmpty) {
                                sr = '';
                              }
                            });
                          },
                          //enabled: true,
                          //inputFormatters: FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          style: SWANWidget.fieldValueTextStyle,
                          maxLength: 250,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The field is mandatory';
                            }
                            return null;
                          },
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
 widget.user == "2"?
                  SWANWidget.enabledTextFormField2(
                  
                      email ,
                      'Email id',
                      TextInputType.emailAddress,
                      [UpperCaseTextFormatter()],
                      (value) {
                    String pattern =
                        r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-z0-9](?:[a-z0-9-]"
                        r"{0,253}[a-z0-9])?(?:\.[a-z0-9](?:[a-z0-9-]"
                        r"{0,253}[a-z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (value == null ||
                        value.isEmpty ||
                        !regex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    } else {
                      return null;
                    }
                  }, 250,TextCapitalization.none):Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "2"
                      ? TextFormField(
                          controller: work,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(12),
                              labelText: 'Profile',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              labelStyle: SWANWidget.fieldLabelTextStyle,
                              counterText: ""),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(
                          //       RegExp('[a-zA-Z]'))
                          // ],
                          onChanged: (value) {
                            setState(() {
                              profile = value;
                              if (value.isEmpty) {
                                profile = '[Profile]';
                              }
                            });
                          },
                          //enabled: true,
                          //inputFormatters: FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          style: SWANWidget.fieldValueTextStyle,
                          maxLength: 250,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The field is mandatory';
                            }
                            return null;
                          },
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? TextFormField(
                          controller: address,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(12),
                              labelText: 'Address',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              labelStyle: SWANWidget.fieldLabelTextStyle,
                              counterText: ""),
                          onChanged: (value) {
                            setState(() {
                              addr = value;
                              if (value.isEmpty) {
                                addr = '[Address]';
                              }
                            });
                          },
                          //enabled: true,
                          //inputFormatters: FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          style: SWANWidget.fieldValueTextStyle,
                          maxLength: 250,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The field is mandatory';
                            }
                            return null;
                          },
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),

                  // SWANWidget.enabledTextFormField(
                  //     business,
                  //     'Buisness/Shop Name',
                  //     TextInputType.text,
                  //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                  //     (value) {
                  //   if (value.isEmpty) {
                  //     return 'The field is mandatory';
                  //   }
                  //   return null;
                  // }, 250),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  widget.user == "2"
                      ? TextFormField(
                          controller: dob,

                          decoration: InputDecoration(
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(12),
                              labelText: 'Date of Birth',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              labelStyle: SWANWidget.fieldLabelTextStyle,
                              counterText: ""),
                          //enabled: true,
                          //inputFormatters: inputFormatters,
                          maxLines: null,
                          readOnly: true,
                          style: SWANWidget.fieldValueTextStyle,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The field is mandatory';
                            }
                            return null;
                          },
                          onTap: () {
                            _selectDate(context);
                          },
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          //height: 100,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: gender,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),

                            items: [
                              'M',
                              'F',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),

                            onChanged: (salutation) {
                              setState(() {
                                gender = salutation!;
                              });
                            },

                            //value: dropdownProject,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<dynamic>(
                            decoration: const InputDecoration(
                              labelText: 'Highest Qualification',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: qualification,

                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),
                            items: qualificationData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['qualification_name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            // items: [
                            //   '12th',
                            //   'BCA',
                            //   'B.Tech',
                            //   'M.Tech',
                            //   'Bsc',
                            //   'MCA',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     child: Text(value),
                            //     value: value,
                            //   );
                            // }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                qualification = salutation!;
                              });
                            },
                            //value: dropdownProject,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),

                  // const SizedBox(
                  //   height: 8,
                  // ), 
                   widget.user == "1"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'State',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: vendor_state,
                           
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),
                            items: stateData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['state_name']),
                                value: item['state_id'].toString(),
                              );
                            }).toList(),
                            // items: [
                            //   'Delhi',
                            //   'Karnataka',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     child: Text(value),
                            //     value: value,
                            //   );
                            // }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                vendor_state = salutation!;
                                vendor_city = null;
                                getVendorCity(vendor_state);
                              });
                            },
                            //value: dropdownProject,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                     const SizedBox(height:8),
                  widget.user == "1"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration( 
                              labelText: 'City',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: vendor_city,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),
                            items: vendorCityData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['city_name']),
                                value: item['city_id'].toString(),
                              );
                            }).toList(),
                            // items: [
                            //   'Delhi',
                            //   'Mumbai',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     child: Text(value),
                            //     value: value,
                            //   );
                            // }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                vendor_city = salutation!;
                              });
                            },
                            //value: dropdownProject,
                           
                            validator: (value) =>
                                value == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          pincode,
                          'Pincode',
                          TextInputType.text,
                          [FilteringTextInputFormatter.digitsOnly], (value) {
                          if (value.isEmpty) {
                            return 'Enter pincode';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          phone,
                          'Phone Number',
                          TextInputType.text,
                          [FilteringTextInputFormatter.digitsOnly], (value) {
                          if (value.isEmpty) {
                            return 'Enter phone number';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          turnover,
                          'Actual Turnover',
                          TextInputType.text,
                          [FilteringTextInputFormatter.digitsOnly], (value) {
                          if (value.isEmpty) {
                            return 'Enter turnover number';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "1"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Type of Company ',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: vendor_company,

                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),
                            items: vendorCompanyTypeData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            // items: [
                            //   'MNC',
                            //   'Other',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     child: Text(value),
                            //     value: value,
                            //   );
                            // }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                vendor_company = salutation!;
                              });
                            },
                            //value: dropdownProject,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: widget.user == "2"
                              ? 'Identity Proof'
                              : 'Vendor Contact Information',
                          style: const TextStyle(
                              color: ColorPalette.themeBlue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14))
                          ]),
                      //textScaleFactor: labelTextScale,
                    ),
                  ),
                  widget.user == "1"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          c_firstName,
                          'Contact First Name',
                          TextInputType.text,
                          [FilteringTextInputFormatter.singleLineFormatter],
                          (value) {
                          if (value.isEmpty) {
                            return 'Enter pincode';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  widget.user == "1"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          c_lastName,
                          'Contact Last Name',
                          TextInputType.text,
                          [FilteringTextInputFormatter.singleLineFormatter],
                          (value) {
                          if (value.isEmpty) {
                            return 'Enter pincode';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                       const SizedBox(height: 8,),
                       widget.user == "1" ?
                  SWANWidget.enabledTextFormField(
                      company_email,
                       'Contact Email id',
                      TextInputType.text,
                      [FilteringTextInputFormatter.singleLineFormatter],
                      (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (value == null ||
                        value.isEmpty ||
                        !regex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    } else {
                      return null;
                    }
                  }, 250):Container(),
                  widget.user == "1"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          c_position,
                          'Contact Position',
                          TextInputType.text,
                          [FilteringTextInputFormatter.singleLineFormatter],
                          (value) {
                          if (value.isEmpty) {
                            return 'Enter pincode';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  widget.user == "1"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "1"
                      ? SWANWidget.enabledTextFormField(
                          c_phone,
                          'Contact Phone Number',
                          TextInputType.text,
                          [FilteringTextInputFormatter.digitsOnly], (value) {
                          if (value.isEmpty) {
                            return 'Enter pincode';
                          } else {
                            return null;
                          }
                        }, 250)
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? SWANWidget.enabledTextFormField(
                          pancard,
                          'PAN Card Number',
                          TextInputType.text,
                          [Capatalized()],
                          (value) {
                          String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
                          RegExp regex = RegExp(pattern);
                          if (value == null ||
                              value.isEmpty ||
                              !regex.hasMatch(value)) {
                            return 'Enter a valid pan number';
                          } else {
                            return null;
                          }
                        }, 10)
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  widget.user == "2"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                panfront != null
                                    ? GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final ImagePicker
                                                          _picker =
                                                          ImagePicker(); //added type ImagePicker
                                                      var image1 = await _picker
                                                          .getImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                      File
                                                      compressedFile =
                                                      await FlutterNativeImage
                                                          .compressImage(
                                                        image1!.path,
                                                        quality: 50,
                                                      );

                                                      if (image1 != null) {
                                                        setState(() {
                                                          final File file = File(
                                                              compressedFile
                                                                  .path);
                                                          //pic = File(image1.path);
                                                          postImage('id_proof_doc', file.path);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/camera.png',
                                                          scale: 2.5,
                                                        ),
                                                        const Text('Camera')
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final ImagePicker
                                                          _picker =
                                                          ImagePicker(); //added type ImagePicker
                                                      var image1 = await _picker
                                                          .getImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                      if (image1 != null) {
                                                        setState(() {
                                                          final File file = File(
                                                              image1
                                                                  .path);
                                                          //pic = File(image1.path);
                                                          postImage('id_proof_doc', file.path);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/gallery.png',
                                                          scale: 2.5,
                                                        ),
                                                        const Text('Gallery')
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 130,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color:
                                                      ColorPalette.textGrey)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              '${APIUrls.BASE_URL_IMAGE}$panfront',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                final ImagePicker _picker =
                                                    ImagePicker(); //added type ImagePicker
                                                var image1 =
                                                    await _picker.getImage(
                                                        source:
                                                            ImageSource.camera);
                                                File
                                                compressedFile =
                                                await FlutterNativeImage
                                                    .compressImage(
                                                  image1!.path,
                                                  quality: 50,
                                                );

                                                if (image1 != null) {
                                                  setState(() {
                                                    final File file = File(
                                                        compressedFile
                                                            .path);
                                                    //pic = File(image1.path);
                                                    postImage('id_proof_doc', file.path);
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/camera.png',
                                                    scale: 2.5,
                                                  ),
                                                  const Text('Camera')
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                final ImagePicker _picker =
                                                    ImagePicker(); //added type ImagePicker
                                                var image1 =
                                                    await _picker.getImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (image1 != null) {
                                                  setState(() {

                                                    final File file = File(
                                                        image1
                                                            .path);
                                                    //pic = File(image1.path);
                                                    postImage('id_proof_doc', file.path);
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/gallery.png',
                                                    scale: 2.5,
                                                  ),
                                                  const Text('Gallery')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                                      },
                                    );
                                  },
                                  child: panfront == null
                                      ? Container(
                                          height: 130,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color:
                                                      ColorPalette.textGrey)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/upload.png',
                                                scale: 3,
                                              ),
                                              Text(
                                                'Upload ID proof',
                                                style: SWANWidget
                                                    .subtextRegularTextStyle,
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: DropdownButtonFormField<String>(
                  //     decoration: const InputDecoration(
                  //       labelText: 'Address Proof',
                  //       isDense: true, // Added this
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: ColorPalette.themeBlue, width: 0.5),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: ColorPalette.themeBlue, width: 0.5),
                  //       ),
                  //     ),
                  //     value: aadhar,
                  //     dropdownColor: Colors.white,
                  //     isExpanded: true,
                  //     iconSize: 20,
                  //     style: const TextStyle(color: Colors.black),

                  //     items: [
                  //       'Aadhar Card',
                  //     ].map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         child: Text(value),
                  //         value: value,
                  //       );
                  //     }).toList(),
                  //     onChanged: (salutation) {
                  //       setState(() {
                  //         aadhar = salutation!;
                  //       });
                  //     },
                  //     //value: dropdownProject,
                  //     validator: (value) =>
                  //         value == null ? 'field required' : null,
                  //   ),
                  // ),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? SWANWidget.enabledTextFormField(
                          aadharcard,
                          'Aadhar Card Number',
                          TextInputType.text,
                          [FilteringTextInputFormatter.digitsOnly], (value) {
                          String pattern =
                              r"^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$";
                          RegExp regex = RegExp(pattern);

                          if (value == null ||
                              value.isEmpty ||
                              !regex.hasMatch(value)) {
                            return 'Enter a valid Aadhar number';
                          } else {
                            return null;
                          }
                        }, 12)
                      : Container(),

                  const SizedBox(
                    height: 5,
                  ),
                  // widget.user == "2" ?
                  // Column(
                  //   children: [
                  //     aadharfront != null
                  //         ? GestureDetector(
                  //             onTap: () async {
                  //               showDialog(
                  //                 context: context,
                  //                 builder: (BuildContext context) {
                  //                   return AlertDialog(
                  //                       content: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceAround,
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       GestureDetector(
                  //                         onTap: () async {
                  //                           final ImagePicker _picker =
                  //                               ImagePicker(); //added type ImagePicker
                  //                           var image1 = await _picker.getImage(
                  //                               source: ImageSource.camera);
                  //
                  //                           if (image1 != null) {
                  //                             setState(() {
                  //                               aadharfront = File(image1.path);
                  //                               Navigator.pop(context);
                  //                             });
                  //                           }
                  //                         },
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             Image.asset(
                  //                               'assets/images/camera.png',
                  //                               scale: 2.5,
                  //                             ),
                  //                             const Text('Camera')
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       GestureDetector(
                  //                         onTap: () async {
                  //                           final ImagePicker _picker =
                  //                               ImagePicker(); //added type ImagePicker
                  //                           var image1 = await _picker.getImage(
                  //                               source: ImageSource.gallery);
                  //
                  //                           if (image1 != null) {
                  //                             setState(() {
                  //                               aadharfront = File(image1.path);
                  //                               Navigator.pop(context);
                  //                             });
                  //                           }
                  //                         },
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             Image.asset(
                  //                               'assets/images/gallery.png',
                  //                               scale: 2.5,
                  //                             ),
                  //                             const Text('Gallery')
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ));
                  //                 },
                  //               );
                  //             },
                  //             child: Container(
                  //               height: 130,
                  //               width: MediaQuery.of(context).size.width / 1.5,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   border: Border.all(
                  //                       color: ColorPalette.textGrey)),
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 child: Image.file(
                  //                   aadharfront!,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //         : Container(),
                  //     const SizedBox(
                  //       height: 8,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () async {
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //                 content: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceAround,
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 GestureDetector(
                  //                   onTap: () async {
                  //                     final ImagePicker _picker =
                  //                         ImagePicker(); //added type ImagePicker
                  //                     var image1 = await _picker.getImage(
                  //                         source: ImageSource.camera);
                  //
                  //                     if (image1 != null) {
                  //                       setState(() {
                  //                         aadharfront = File(image1.path);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     }
                  //                   },
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       Image.asset(
                  //                         'assets/images/camera.png',
                  //                         scale: 2.5,
                  //                       ),
                  //                       const Text('Camera')
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 GestureDetector(
                  //                   onTap: () async {
                  //                     final ImagePicker _picker =
                  //                         ImagePicker(); //added type ImagePicker
                  //                     var image1 = await _picker.getImage(
                  //                         source: ImageSource.gallery);
                  //
                  //                     if (image1 != null) {
                  //                       setState(() {
                  //                         aadharfront = File(image1.path);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     }
                  //                   },
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       Image.asset(
                  //                         'assets/images/gallery.png',
                  //                         scale: 2.5,
                  //                       ),
                  //                       const Text('Gallery')
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ));
                  //           },
                  //         );
                  //       },
                  //       child: aadharfront == null
                  //           ? Container(
                  //               height: 130,
                  //               width: MediaQuery.of(context).size.width / 1.5,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   border: Border.all(
                  //                       color: ColorPalette.textGrey)),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   Image.asset(
                  //                     'assets/images/upload.png',
                  //                     scale: 3,
                  //                   ),
                  //                   Text(
                  //                     'Upload address proof Side of front',
                  //                     style: SWANWidget.subtextRegularTextStyle,
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //           : Container(),
                  //     ),
                  //   ],
                  // ):Container(),
                  widget.user == "2"
                      ? Column(
                          children: [
                            aadharback != null
                                ? GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final ImagePicker _picker =
                                                      ImagePicker(); //added type ImagePicker
                                                  var image1 =
                                                      await _picker.getImage(
                                                          source: ImageSource
                                                              .camera);
                                                  File
                                                  compressedFile =
                                                  await FlutterNativeImage
                                                      .compressImage(
                                                    image1!.path,
                                                    quality: 50,
                                                  );

                                                  if (image1 != null) {
                                                    setState(() {
                                                      final File file = File(
                                                          compressedFile
                                                              .path);
                                                      //pic = File(image1.path);
                                                      postImage('address_proof_doc', file.path);
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/camera.png',
                                                      scale: 2.5,
                                                    ),
                                                    const Text('Camera')
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final ImagePicker _picker =
                                                      ImagePicker(); //added type ImagePicker
                                                  var image1 =
                                                      await _picker.getImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  if (image1 != null) {
                                                    setState(() {
                                                      final File file = File(
                                                          image1
                                                              .path);
                                                      //pic = File(image1.path);
                                                      postImage('address_proof_doc', file.path);
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/gallery.png',
                                                      scale: 2.5,
                                                    ),
                                                    const Text('Gallery')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ));
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorPalette.textGrey)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '${APIUrls.BASE_URL_IMAGE}$aadharback',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final ImagePicker _picker =
                                                ImagePicker(); //added type ImagePicker
                                            var image1 = await _picker.getImage(
                                                source: ImageSource.camera);
                                            File
                                            compressedFile =
                                            await FlutterNativeImage
                                                .compressImage(
                                              image1!.path,
                                              quality: 50,
                                            );
                                            if (image1 != null) {
                                              setState(() {
                                                final File file = File(
                                                    compressedFile
                                                        .path);
                                                //pic = File(image1.path);
                                                postImage('address_proof_doc', file.path);
                                                Navigator.pop(context);
                                              });
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/images/camera.png',
                                                scale: 2.5,
                                              ),
                                              const Text('Camera')
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            final ImagePicker _picker =
                                                ImagePicker(); //added type ImagePicker
                                            var image1 = await _picker.getImage(
                                                source: ImageSource.gallery);

                                            if (image1 != null) {
                                              setState(() {
                                                final File file = File(
                                                    image1
                                                        .path);
                                                //pic = File(image1.path);
                                                postImage('address_proof_doc', file.path);
                                                Navigator.pop(context);
                                              });
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/images/gallery.png',
                                                scale: 2.5,
                                              ),
                                              const Text('Gallery')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                                  },
                                );
                              },
                              child: aadharback == null
                                  ? Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorPalette.textGrey)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/upload.png',
                                            scale: 3,
                                          ),
                                          Text(
                                            'Upload address proof',
                                            style: SWANWidget
                                                .subtextRegularTextStyle,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 5,
                        )
                      : Container(),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: RichText(
                  //     text: const TextSpan(
                  //         text: 'Service Area',
                  //         style: TextStyle(
                  //             color: ColorPalette.themeBlue,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 16),
                  //         children: [
                  //           TextSpan(
                  //               text: ' *',
                  //               style: TextStyle(
                  //                   color: Colors.red,
                  //                   fontWeight: FontWeight.w400,
                  //                   fontSize: 14))
                  //         ]),
                  //     //textScaleFactor: labelTextScale,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // SWANWidget.enabledTextFormField(
                  //     address,
                  //     'Address',
                  //     TextInputType.text,
                  //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                  //     (value) {
                  //   if (value.isEmpty) {
                  //     return 'The field is mandatory';
                  //   }
                  //   return null;
                  // }, 250),
                  // const SizedBox(
                  //   height: 8,
                  // ),

                  // SWANWidget.enabledTextFormField(
                  //     city,
                  //     'City',
                  //     TextInputType.text,
                  //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                  //     (value) {
                  //   if (value.isEmpty) {
                  //     return 'The field is mandatory';
                  //   }
                  //   return null;
                  // }, 250),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // SWANWidget.enabledTextFormField(
                  //     state,
                  //     'State',
                  //     TextInputType.text,
                  //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                  //     (value) {
                  //   if (value.isEmpty) {
                  //     return 'The field is mandatory';
                  //   }
                  //   return null;
                  // }, 250),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),
                  widget.user == "2"
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Skills',
                                style: TextStyle(
                                    color: ColorPalette.themeBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ]),
                            //textScaleFactor: labelTextScale,
                          ),
                        )
                      : Container(),

                  widget.user == "2" ?
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                 //  height: 120,
                    child: GetBuilder<AppDataController>(builder: (controller) {
                      return MultiSelectDialogField(
                       dialogHeight: MediaQuery.of(context).size.height/2.5,
                        items: controller.dropDownData,
                        title: const Text(
                          "Select Skills",
                          style: TextStyle(color: Colors.black),
                        ),
                        selectedColor: Colors.black,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: ColorPalette.themeBlue, width: 0.5)),
                        buttonIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        buttonText: const Text(
                          "Select Skills",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          subjectData = [];
                          for (var i = 0; i < results.length; i++) {
                            SubjectModel data = results[i] as SubjectModel;
                            print(data.subjectId);
                            print(data.subjectName);
                            subjectData.add(data.subjectId);
                          }
                          print("datalalitbank $subjectData");
                          multiSkill = subjectData.join(',');
                          print("afterlist $multiSkill");


                          //_selectedAnimals = results;
                        },
                        // validator: (value){
                        //  if(multiSkill == null)
                        //    return 'Please select skill';
                        //  return null;
                        // },
                      );
                    }),
                  ):Container(),
                  widget.user == "2" ?
                   const SizedBox(height: 8,):Container(),


                  // widget.user == "2"
                  //     ? GestureDetector(
                  //         onTap: () {
                  //           print(_selectedItems);
                  //           _showMultiSelectskill();
                  //         },
                  //         child: Container(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(4),
                  //               border: Border.all(
                  //                   color: ColorPalette.themeBlue, width: 0.5)),
                  //           child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   'Select Skills',
                  //                   style:
                  //                       SWANWidget.disabledFieldValueTextStyle,
                  //                 ),
                  //                 const Icon(Icons.arrow_drop_down)
                  //               ]),
                  //         ),
                  //       )
                  //     : Container(),
                  // widget.user == "2"
                  //     ? Wrap(
                  //         children: _selectedItemsskill
                  //             .map((e) => Chip(
                  //                   label: Text(e),
                  //                 ))
                  //             .toList(),
                  //       )
                  //     : Container(),
                  // widget.user == "2"
                  //     ? const SizedBox(
                  //         height: 8,
                  //       )
                  //     : Container(),

                  // MultiChip(
                  //   reportList,
                  //   onSelectionChanged: (selectedList) {
                  //     setState(() {
                  //       selectedReportList = selectedList;
                  //     });
                  //   },
                  //   maxSelection: 5,
                  // ),
                  // Text(selectedReportList.join(" , ")),
                  widget.user == "2"
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Total Experience',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                            ),
                            value: experience,

                            dropdownColor: Colors.white,
                            isExpanded: true,
                            iconSize: 20,
                            style: const TextStyle(color: Colors.black),
                            items: experinceData.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            // items: [
                            //   '0-1 year',
                            //   '1-2 year',
                            //   '2-3 year',
                            //   '3-4 year',
                            //   '4-5 year',
                            //   '5+ year',
                            // ].map<DropdownMenuItem<String>>((String value) {
                            //   return DropdownMenuItem<String>(
                            //     child: Text(value),
                            //     value: value,
                            //   );
                            // }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                experience = salutation!;
                              });
                            },
                            //value: dropdownProject,
                            validator: (value) =>
                                value == null && multiSkill == null ? 'field required' : null,
                          ),
                        )
                      : Container(),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // Chip(
                  //   deleteIcon: const Icon(
                  //     Icons.close,
                  //     size: 15,
                  //   ),
                  //   onDeleted: () {
                  //     setState(() {});
                  //   },
                  //   elevation: 2,
                  //   padding: const EdgeInsets.all(8),
                  //   backgroundColor: Colors.greenAccent[100],
                  //   shadowColor: Colors.black,
                  //   //CircleAvatar
                  //   label: const Text(
                  //     'GeeksforGeeks',
                  //     style: TextStyle(fontSize: 10),
                  //   ), //Text
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  // SWANWidget.enabledTextFormField(
                  //     address,
                  //     'Total Experiance',
                  //     TextInputType.text,
                  //     [FilteringTextInputFormatter.singleLineFormatter],
                  //     (value) {
                  //   if (value.isEmpty) {
                  //     return 'The field is mandatory';
                  //   }
                  //   return null;
                  // }, 250),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                ],
              ),
            ),
          ),
        ),
        // This is Step2 here we will enter our address
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('Business'),
            //subtitle: const Text('Business'),
            content: SingleChildScrollView(
              child: Form(
                key: formKeys[1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: const TextSpan(
                            text: 'Business Details',
                            style: TextStyle(
                                color: ColorPalette.themeBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))
                            ]),
                        //textScaleFactor: labelTextScale,
                      ),
                    ),

                    CheckboxListTile(
                      title:
                          const Text("Do you have GST number"), //    <-- label
                      value: _checkbox,
                      onChanged: (newValue) {
                        setState(() {
                          _checkbox = !_checkbox;
                          if(_checkbox == false){
                            _checkboxvalue = 0;
                          }else{
                            _checkboxvalue = 1;
                          }
                          print('checkbox value $_checkboxvalue');
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _checkbox == true ?
                    SWANWidget.enabledTextFormField(
                        gstnumber,
                        'Enter GST number',
                        TextInputType.text,
                        [FilteringTextInputFormatter.singleLineFormatter],
                        (value) {
                      String pattern =
                          r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$";
                      RegExp regex = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          !regex.hasMatch(value)) {
                        return 'Enter a valid GST number';
                      } else {
                        return null;
                      }
                    }, 250):Container(),
                    const SizedBox(
                      height: 8,
                    ),
                    _checkbox == true ?
                    Column(
                      children: [
                        gst != null
                            ? GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker(); //added type ImagePicker
                                              var image1 =
                                                  await _picker.getImage(
                                                      source:
                                                          ImageSource.camera);
                                              File
                                              compressedFile =
                                              await FlutterNativeImage
                                                  .compressImage(
                                                image1!.path,
                                                quality: 50,
                                              );
                                              if (image1 != null) {
                                                setState(() {
                                                  final File file = File(
                                                      compressedFile
                                                          .path);
                                                  //pic = File(image1.path);
                                                  postImage('gst_doc', file.path);
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/camera.png',
                                                  scale: 2.5,
                                                ),
                                                const Text('Camera')
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker(); //added type ImagePicker
                                              var image1 =
                                                  await _picker.getImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (image1 != null) {
                                                setState(() {
                                                  final File file = File(
                                                      image1
                                                          .path);
                                                  //pic = File(image1.path);
                                                  postImage('gst_doc', file.path);
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/gallery.png',
                                                  scale: 2.5,
                                                ),
                                                const Text('Gallery')
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                    },
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${APIUrls.BASE_URL_IMAGE}$gst',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker(); //added type ImagePicker
                                        var image1 = await _picker.getImage(
                                            source: ImageSource.camera);
                                        // File croppedFile =
                                        // (await ImageCropper()
                                        //     .cropImage(
                                        //   sourcePath:
                                        //   image1!.path,
                                        // )) as File;
                                        File
                                        compressedFile =
                                        await FlutterNativeImage
                                            .compressImage(
                                          image1!.path,
                                          quality: 50,
                                        );
                                        if (image1 != null) {
                                          setState(() {
                                            final File file = File(
                                                compressedFile
                                                    .path);
                                            //pic = File(image1.path);
                                            postImage('gst_doc', file.path);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/camera.png',
                                            scale: 2.5,
                                          ),
                                          const Text('Camera')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker(); //added type ImagePicker
                                        var image1 = await _picker.getImage(
                                            source: ImageSource.gallery);

                                        if (image1 != null) {
                                          setState(() {
                                            final File file = File(
                                                image1
                                                    .path);
                                            //pic = File(image1.path);
                                            postImage('gst_doc', file.path);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/gallery.png',
                                            scale: 2.5,
                                          ),
                                          const Text('Gallery')
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                              },
                            );
                          },
                          child: gst == null
                              ? Container(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/upload.png',
                                        scale: 3,
                                      ),
                                      Text(
                                        'Upload GST proof',
                                        style:
                                            SWANWidget.subtextRegularTextStyle,
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ):Container(),
                    const SizedBox(
                      height: 8,
                    ),

                    SWANWidget.enabledTextFormField(
                        businessPanCard,
                        'PAN Card Number',
                        TextInputType.text,
                        [Capatalized()],
                        (value) {
                      String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
                      RegExp regex = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          !regex.hasMatch(value)) {
                        return 'Enter a valid pan number';
                      } else {
                        return null;
                      }
                    }, 10),
                    const SizedBox(
                      height: 8,
                    ),
                    // SWANWidget.enabledTextFormField(
                    //     companyname,
                    //     'Company Name',
                    //     TextInputType.text,
                    //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    //     (value) {
                    //   if (value.isEmpty) {
                    //     return 'The field is mandatory';
                    //   }
                    //   return null;
                    // }, 250),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: const TextSpan(
                            text: 'Service Area',
                            style: TextStyle(
                                color: ColorPalette.themeBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))
                            ]),
                        //textScaleFactor: labelTextScale,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),

                    // SWANWidget.enabledTextFormField(
                    //     city,
                    //     'City',
                    //     TextInputType.text,
                    //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    //     (value) {
                    //   if (value.isEmpty) {
                    //     return 'The field is mandatory';
                    //   }
                    //   return null;
                    // }, 250),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // SWANWidget.enabledTextFormField(
                    //     state,
                    //     'State',
                    //     TextInputType.text,
                    //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    //     (value) {
                    //   if (value.isEmpty) {
                    //     return 'The field is mandatory';
                    //   }
                    //   return null;
                    // }, 250),

                    // ElevatedButton(
                    //   child: const Text('Select Your Favorite Topics'),
                    //   onPressed: _showMultiSelect,
                    // ),
                    // const Divider(
                    //   height: 30,
                    // ),
                    // display selected items

                    const SizedBox(
                      height: 8,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     print(_selectedItems);
                    //     _showMultiSelect();
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 10, vertical: 10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(4),
                    //         border: Border.all(color: ColorPalette.themeBlue)),
                    //     child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             'Select State',
                    //             style: SWANWidget.disabledFieldValueTextStyle,
                    //           ),
                    //           const Icon(Icons.arrow_drop_down)
                    //         ]),
                    //   ),
                    // ),
                    // Wrap(
                    //   children: _selectedItems
                    //       .map((e) => Chip(
                    //             label: Text(e),
                    //           ))
                    //       .toList(),
                    // ),

                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 45,
                    //   child: DropdownButtonFormField<String>(
                    //     decoration: const InputDecoration(
                    //       labelText: 'Select State',
                    //       isDense: true, // Added this
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: ColorPalette.themeBlue),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: ColorPalette.themeBlue,
                    //         ),
                    //       ),
                    //     ),
                    //     value: workcity,

                    //     dropdownColor: Colors.white,
                    //     isExpanded: true,
                    //     iconSize: 20,
                    //     style: const TextStyle(color: Colors.black),

                    //     items: [
                    //       'Delhi',
                    //       'Mumbai',
                    //       'Bangalore',
                    //       'Noida',
                    //       'Gurgaon',
                    //     ].map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         child: Text(value),
                    //         value: value,
                    //       );
                    //     }).toList(),
                    //     onChanged: (salutation) {
                    //       setState(() {
                    //         _showMultiSelect;
                    //         //workcity = salutation!;
                    //       });
                    //     },
                    //     //value: dropdownProject,
                    //     validator: (value) =>
                    //         value == null ? 'field required' : null,
                    //   ),
                    // ),

                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      //  height: 120,
                      child: GetBuilder<AppDataControllerCIty>(builder: (controller) {
                        return MultiSelectDialogField(
                          dialogHeight: MediaQuery.of(context).size.height/2.5,
                          items: controller.dropDownDatacity,
                          title: const Text(
                            "Select City",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: ColorPalette.themeBlue, width: 0.5)),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          buttonText: const Text(
                            "Select City",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            subjectDatacity = [];
                            for (var i = 0; i < results.length; i++) {
                              SubjectModel data = results[i] as SubjectModel;
                              print(data.subjectId);
                              print(data.subjectName);
                              subjectDatacity.add(data.subjectId);
                            }
                            print("datalalitbank $subjectDatacity");
                            multiCity = subjectDatacity.join(',');


                            //_selectedAnimals = results;
                          },
                        );
                      }),
                    ),






                   
                    Wrap(
                      children: _selectedItemscity
                          .map((e) => Chip(
                                label: Text(e),
                              ))
                          .toList(),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 45,
                    //   child: DropdownButtonFormField<String>(
                    //     decoration: const InputDecoration(
                    //       labelText: 'Select City',
                    //       isDense: true, // Added this
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: ColorPalette.themeBlue),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: ColorPalette.themeBlue,
                    //         ),
                    //       ),
                    //     ),
                    //     value: workcity,

                    //     dropdownColor: Colors.white,
                    //     isExpanded: true,
                    //     iconSize: 20,
                    //     style: const TextStyle(color: Colors.black),

                    //     items: [
                    //       'Delhi',
                    //       'Mumbai',
                    //       'Bangalore',
                    //       'Noida',
                    //       'Gurgaon',
                    //     ].map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         child: Text(value),
                    //         value: value,
                    //       );
                    //     }).toList(),
                    //     onChanged: (salutation) {
                    //       setState(() {
                    //         workcity = salutation!;
                    //       });
                    //     },
                    //     //value: dropdownProject,
                    //     validator: (value) =>
                    //         value == null ? 'field required' : null,
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 8,
                    // ),

                    // MultiChiplocation(
                    //   location,
                    //   onSelectionChanged: (selectedList) {
                    //     setState(() {
                    //       selectedlocation = selectedList;
                    //     });
                    //   },
                    //   maxSelection: 5,
                    // ),
                  ],
                ),
              ),
            )),

        // This is Step3 here we will display all the details
        // that are entered by the user
        Step(
            state: StepState.editing,
            isActive: _activeCurrentStep >= 2,
            title: const Text('Bank'),
            //subtitle: const Text('Bank'),
            content: SingleChildScrollView(
              child: Form(
                key: formKeys[2],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Bank',
                          isDense: true, // Added this
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.themeBlue, width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.themeBlue, width: 0.5),
                          ),
                        ),
                        value: bank,

                        dropdownColor: Colors.white,
                        isExpanded: true,
                        iconSize: 20,
                        style: const TextStyle(color: Colors.black),
                        items: bankData.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['bank_name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        // items: [
                        //   'State Bank of India',
                        //   'Centrel Bank of india',
                        //   'Punjab nationa l bank',
                        // ].map<DropdownMenuItem<String>>((String value) {
                        //   return DropdownMenuItem<String>(
                        //     child: Text(value),
                        //     value: value,
                        //   );
                        // }).toList(),
                        onChanged: (salutation) {
                          setState(() {
                            bank = salutation!;

                          });
                        },
                        //value: dropdownProject,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SWANWidget.enabledTextFormField(
                        accNumber,
                        'Account Number',
                        TextInputType.text,
                        [FilteringTextInputFormatter.digitsOnly], (value) {
                      if (value.isEmpty) {
                        return 'The field is mandatory';
                      }
                      return null;
                    }, 18),
                    const SizedBox(
                      height: 8,
                    ),
                    SWANWidget.enabledTextFormField(
                        confirmAccNumber,
                        'Confirm Account Number',
                        TextInputType.text,
                        [FilteringTextInputFormatter.digitsOnly], (value) {
                      if (value.isEmpty) {
                        return 'The field is mandatory';
                      }
                      if(value != accNumber.text){
                        return 'Account number not Match';}
                      return null;
                    }, 18),
                    const SizedBox(
                      height: 8,
                    ),
                    SWANWidget.enabledTextFormField(
                        ifsc,
                        'IFSC Code',
                        TextInputType.text,
                        [FilteringTextInputFormatter.singleLineFormatter],
                        (value) {
                      if (value.isEmpty) {
                        return 'The field is mandatory';
                      }
                      return null;
                    }, 250),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Account Type',
                          isDense: true, // Added this
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.themeBlue, width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.themeBlue, width: 0.5),
                          ),
                        ),
                        value: acctype,

                        dropdownColor: Colors.white,
                        isExpanded: true,
                        iconSize: 20,
                        style: const TextStyle(color: Colors.black),

                        items: [
                          'Saving',
                          'Current',
                          'Other',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (salutation) {
                          setState(() {
                            acctype = salutation!;
                          });
                        },
                        //value: dropdownProject,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SWANWidget.enabledTextFormField(
                        accHolderName,
                        'Account Holder Name',
                        TextInputType.text,
                        [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                        (value) {
                      if (value.isEmpty) {
                        return 'The field is mandatory';
                      }
                      return null;
                    }, 250),
                    const SizedBox(
                      height: 8,
                    ),
                    // SWANWidget.enabledTextFormField(
                    //     bankName,
                    //     'Bank Name',
                    //     TextInputType.text,
                    //     [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    //     (value) {
                    //   if (value.isEmpty) {
                    //     return 'The field is mandatory';
                    //   }
                    //   return null;
                    // }, 250),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Column(
                      children: [
                        check != null
                            ? GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker(); //added type ImagePicker
                                              var image1 =
                                                  await _picker.getImage(
                                                      source:
                                                          ImageSource.camera);
                                              File
                                              compressedFile =
                                              await FlutterNativeImage
                                                  .compressImage(
                                                image1!.path,
                                                quality: 50,
                                              );
                                              if (image1 != null) {
                                                setState(() {
                                                  final File file = File(
                                                      compressedFile
                                                          .path);
                                                  //pic = File(image1.path);
                                                  postImage('cancelled_cheque', file.path);
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/camera.png',
                                                  scale: 2.5,
                                                ),
                                                const Text('Camera')
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker(); //added type ImagePicker
                                              var image1 =
                                                  await _picker.getImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (image1 != null) {
                                                setState(() {
                                                  final File file = File(
                                                      image1
                                                          .path);
                                                  //pic = File(image1.path);
                                                  postImage('cancelled_cheque', file.path);
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/gallery.png',
                                                  scale: 2.5,
                                                ),
                                                const Text('Gallery')
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                    },
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${APIUrls.BASE_URL_IMAGE}$check',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker(); //added type ImagePicker
                                        var image1 = await _picker.getImage(
                                            source: ImageSource.camera);
                                        File
                                        compressedFile =
                                        await FlutterNativeImage
                                            .compressImage(
                                          image1!.path,
                                          quality: 50,
                                        );
                                        if (image1 != null) {
                                          setState(() {
                                            final File file = File(
                                                compressedFile
                                                    .path);
                                            //pic = File(image1.path);
                                            postImage('cancelled_cheque', file.path);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/camera.png',
                                            scale: 2.5,
                                          ),
                                          const Text('Camera')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker(); //added type ImagePicker
                                        var image1 = await _picker.getImage(
                                            source: ImageSource.gallery);

                                        if (image1 != null) {
                                          setState(() {
                                            final File file = File(
                                                image1
                                                    .path);
                                            //pic = File(image1.path);
                                            postImage('cancelled_cheque', file.path);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/gallery.png',
                                            scale: 2.5,
                                          ),
                                          const Text('Gallery')
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                              },
                            );
                          },
                          child: check == null
                              ? Container(
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/upload.png',
                                        scale: 3,
                                      ),
                                      Text(
                                        'Upload Cancel Check',
                                        style:
                                            SWANWidget.subtextRegularTextStyle,
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
      ];

  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black87,
        //   ),
        //   title: const Text(
        //     'Profile',
        //     style: TextStyle(
        //       color: Colors.black87,
        //     ),
        //   ),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height:MediaQuery.of(context).size.height/4,
                    width: double.infinity,
                    child: Stack(children: [
                      Positioned(
                          top: -5,
                          left: 0,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/shade2.png'),
                          )),
                      Positioned(
                          bottom: -20,
                          left: -20,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/shade4.png'),
                          )),
                      Positioned(
                          bottom: -20,
                          right: 0,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset('assets/images/shade1.png'),
                          )),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Stack(
                          children: [
                            Container(
                                height: 130,
                                width: 130,
                                child: pic != null
                                    ? Image.network(
                                  '${APIUrls.BASE_URL_IMAGE}$pic',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/user.png')),
                            Positioned(
                                bottom: -5,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () async {
                                    final ImagePicker _picker =
                                        ImagePicker(); //added type ImagePicker
                                    var image1 = await _picker.getImage(
                                        source: ImageSource.camera);
                                    File
                                    compressedFile =
                                    await FlutterNativeImage
                                        .compressImage(
                                      image1!.path,
                                      quality: 50,
                                    );
                                    if (image1 != null) {
                                      setState(() {
                                        final File file = File(
                                            compressedFile
                                                .path);
                                        //pic = File(image1.path);
                                        postImage('photo', file.path);
                                      });
                                    }
                                  },
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                  //padding: const EdgeInsets.all(2.0),
                                  shape: const CircleBorder(),
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           
                            Text(
                              '$name $sr',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           
                            widget.user == "2"
                                ? const SizedBox(height: 5)
                                : Container(),
                            widget.user == "2"
                                ? Text(profile,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ))
                                : Container(),
                            const SizedBox(height: 5),
                            Text('$number',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 60,
                              width:MediaQuery.of(context).size.width/2.1,
                              child: SingleChildScrollView(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    Text(addr,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )),
                                       
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ])),
              ),
            ),
            // SizedBox(
            //   height: 170,
            //   child: Card(
            //     elevation: 5,
            //     child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //       child: Row(children: [
            //         Column(
            //           children: [
            //             SizedBox(
            //               height: 80,
            //               width: 80,
            //               child: Stack(
            //                 clipBehavior: Clip.none,
            //                 fit: StackFit.expand,
            //                 children: [
            //                   ClipOval(

            //                     child: SizedBox.fromSize(

            //                         size: const Size.fromRadius(
            //                             20), // Image radius
            //                         child: pic != null
            //                             ? Image.file(
            //                                 pic!,
            //                                 fit: BoxFit.cover,
            //                               )
            //                             : Image.asset(
            //                                 'assets/images/user.png',)),
            //                   ),
            //                   Positioned(
            //                       bottom: 0,
            //                       right: -35,
            //                       child: RawMaterialButton(
            //                         onPressed: () async {
            //                           final ImagePicker _picker =
            //                               ImagePicker(); //added type ImagePicker
            //                           var image1 = await _picker.getImage(
            //                               source: ImageSource.camera);

            //                           if (image1 != null) {
            //                             setState(() {
            //                               pic = File(image1.path);
            //                             });
            //                           }
            //                         },
            //                         elevation: 2.0,
            //                         fillColor: const Color(0xFFF5F6F9),
            //                         child: const Icon(
            //                           Icons.camera_alt_outlined,
            //                           color: Colors.blue,
            //                           size: 16,
            //                         ),
            //                         //padding: const EdgeInsets.all(2.0),
            //                         shape: const CircleBorder(),
            //                       )),
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 30,
            //             ),
            //             // SizedBox(
            //             //   width: 100,
            //             //   child: const Card(
            //             //     elevation: 15,
            //             //     child: Padding(
            //             //       padding: EdgeInsets.symmetric(
            //             //           horizontal: 10, vertical: 2),
            //             //       child: Text(
            //             //         '[Work title title title title ]',
            //             //         style: TextStyle(fontSize: 12),
            //             //       ),
            //             //     ),
            //             //   ),
            //             // ),
            //           ],
            //         ),
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 5),
            //               child: Text(
            //                 '${name} ${sr}',
            //                 style: const TextStyle(
            //                     fontSize: 16, fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 5),
            //               child: Text(
            //                 profile,
            //                 style: const TextStyle(
            //                     fontSize: 12,
            //                     color: ColorPalette.bgGrey,
            //                     fontWeight: FontWeight.w300),
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //             Row(
            //               children: const [
            //                 Icon(
            //                   Icons.phone,
            //                   size: 15,
            //                   color: ColorPalette.bgGrey,
            //                 ),
            //                 SizedBox(
            //                   width: 5,
            //                 ),
            //                 Text(
            //                   '[Phone number]',
            //                   style: TextStyle(
            //                       fontSize: 16, fontWeight: FontWeight.w500),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 const Icon(
            //                   Icons.location_on_outlined,
            //                   size: 18,
            //                   color: ColorPalette.bgGrey,
            //                 ),
            //                 const SizedBox(
            //                   width: 5,
            //                 ),
            //                 SizedBox(
            //                   width: 160,
            //                   child: Text(
            //                     '$userAddress',
            //                     style: const TextStyle(
            //                         fontSize: 14, fontWeight: FontWeight.w400),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ]),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: _activeCurrentStep,
                steps: stepList(),
                onStepContinue: () {
                  if (_activeCurrentStep < (stepList().length - 1)) {
                    setState(() {
                      print(widget.user);
                      // if (formKeys[_activeCurrentStep]
                      //     .currentState!
                      //     .validate()) {
                        if (_activeCurrentStep == 0) {


                          //_selectedItemsskill.join(",");

                       // if(pic !=null && panfront !=null && aadharback != null){

                          if(multiSkill != null) {

                            if (widget.user == "2") {
                              add_Personal_Details(
                                firstName.text,
                                lastName.text,
                                email.text.toLowerCase(),
                                address.text,
                                work.text,
                                dob.text,
                                gender,
                                qualification,
                                pancard.text,
                                panfront,
                                aadharcard.text,
                                aadharback,
                                multiSkill,
                                experience,
                              );
                            }
                            else {
                              add_Vendor_Details(
                                  company_name.text,
                                  _selectaccount,
                                  _selectvendor,
                                  vendor_state,
                                  vendor_city,
                                  pincode.text,
                                  phone.text,
                                  turnover.text,
                                  vendor_company,
                                  c_firstName.text,
                                  c_lastName.text,
                                 company_email.text,
                                  c_position.text,
                                  c_phone.text
                              );
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Please select skill'),
                                ));
                          }
                        // }else{
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text('Please upload files'),
                        //   ));
                        // }
                         // _activeCurrentStep += 1;
                        } else if (_activeCurrentStep == 1) {
                          add_Business_Details(
                            gstnumber.text,
                            gst,
                            businessPanCard.text,
                            multiCity
                          );
                        }
                        // Get.to(const Dashboard());
                      //}
                    });
                  } else {
                    setState(() {
                      if (formKeys[_activeCurrentStep]
                          .currentState!
                          .validate()) {
                        add_Bank_Details(
                            bank,
                          accNumber.text,
                          confirmAccNumber.text,
                          ifsc.text,
                          acctype,
                          accHolderName.text,
                          check

                        );
                        //_activeCurrentStep += 1;

                      }
                    });
                  }
                  //if (_activeCurrentStep != 2 && _activeCurrentStep != 1) {
                  //print('lalit $_activeCurrentStep');
                  //}
                },
                onStepCancel: () {
                  if (_activeCurrentStep == 0) {
                    return;
                  }
                  setState(() {
                    _activeCurrentStep -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    _activeCurrentStep = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> reportList = [
    'Computer Network',
    'Mobile Application',
    'Computers & Others',
    'Digital Display Services',
    'Flutter',
    'Developement',
  ];

  List<String> selectedReportList = [];

  List<String> location = [
    'Delhi',
    'Mumbai',
    'Bangelore',
    'Gurgaon',
    'Ahmedabad',
    'Noida',
  ];

  List<String> selectedlocation = [];

  //personal details api
  Future<void> add_Personal_Details(
    name,
    lastName,
    email,
    address,
    work,
    dob,
    gender,
    qualification,
    pancard,
    panfront,
    aadharcard,
    aadharfront,
    multiSkill,
    experience,
  ) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body =
     
        jsonEncode(<String, String>{
   
              "phone_number": '$number',
               "user_id": '${sharedPreferneces.getString('user_id')}',
          "user_type": '${widget.user}',
          "first_name": '$name',
          "last_name": '$lastName',
          "email": '$email',
          "address": '$address',
          "work_title": '$work',
          "dob": '$dob',
          "gender": '$gender',
          "highest_qualification": '$qualification',
          "id_proof_type": '1',
          "id_proof_no": '$pancard',
          "id_proof_doc": '$panfront',
          "address_proof_type": '2',
          "address_proof_number": '$aadharcard',
          "address_proof_doc": '$aadharback',
          "skills": "$multiSkill",
          "total_experience": '$experience',
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
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {

            setState(() {
              sharedPreferneces.setString('user_id','${convertJson['data']['user_id']}');
              _activeCurrentStep += 1;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            // Get.to(Otp(number: phoneNumber));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }


  //add business details

  Future<void> add_Business_Details(
  gstnumber,
  gst,
  businessPanCard,
      multiCity
      ) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      
        var body =
        _checkboxvalue == 1 ?
        jsonEncode(<String, String>{
           
           "phone_number": '$number',
          "user_id": '${sharedPreferneces.getString('user_id')}',
          "have_gst_no": "$_checkboxvalue",
          // "gst_number": "$gstnumber" ,
          // "gst_doc": "$gst",
          "pan_number": "$businessPanCard",
          "service_area": "$multiCity"
   
        }):
        jsonEncode(<String, String>{
         "phone_number": '$number',
          "user_id": '${sharedPreferneces.getString('user_id')}',
          "have_gst_no": "$_checkboxvalue",
          "gst_number": "$gstnumber" ,
          "gst_doc": "$gst",
          "pan_number": "$businessPanCard",
          "service_area": "$multiCity"
       
        });
        print(body);
        var response = await http.post(Uri.parse(APIUrls.ADD_BUSINESS_DETAILS),
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            setState(() {
              _activeCurrentStep += 1;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            // Get.to(Otp(number: phoneNumber));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

  
  //add bank details
  
  Future<void> add_Bank_Details(
  bank,
  accNumber,
  confirmAccNumber,
  ifsc,
  acctype,
  accHolderName,
  check
      ) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$number',
          "user_id": '${sharedPreferneces.getString('user_id')}',
          "bank": "$bank",
          "account_no": "$accNumber",
          "ifsc_code": "$ifsc",
          "account_holder_name": "$accHolderName",
          "cancel_checque":"$check",
          "account_type":"$acctype"
        });
        print(body);

        var response = await http.post(Uri.parse(APIUrls.ADD_Bank_DETAILS),
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            Get.to(const Review());
            // Get.to(Otp(number: phoneNumber));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }


  Future<void> add_Vendor_Details(
  company_name,
  _selectaccount,
  _selectvendor,
  vendor_state,
  vendor_city,
  pincode,
  phone,
  turnover,
  vendor_company,
  c_firstName,
  c_lastName,
 company_email,
  c_position,
  c_phone
      ) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = 
         jsonEncode(<String, String>{
          "phone_number": '$number',
           "user_id": '${sharedPreferneces.getString('user_id')}',
          "company_name": "$company_name",
          "account_group": "$_selectaccount",
          "vendor_required_for": "$_selectvendor",
          "vendor_state": "$vendor_state",
          "vendor_city": "$vendor_city",
          "vendor_pin": "$pincode",
          "vendor_phone": "$phone",
          "turnover": "$turnover",
          "vendor_company_type": "$vendor_company",
          "contact_first_name":"$c_firstName",
          "contact_last_name":"$c_lastName",
          "contact_phone_number": "$c_phone",
          "contact_email": "$company_email",
          "user_type":"1",
          "contact_position": "$c_position",
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
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            setState(() {
              _activeCurrentStep += 1;
            });

          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }


  // get qualification

  List qualificationData = [];
  Future<void> getQualification() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",

        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_QUALIFICATION}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
         // print(' qualification >> $convertJson');
          if (convertJson["status"]) {
          setState(() {
            qualificationData = convertJson['data']['qualifications'];
          });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

  List stateData = [];
  Future<void> getStates() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",

        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_STATE}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          // print(' qualification >> $convertJson');
          if (convertJson["status"]) {
            setState(() {
              stateData = convertJson['data']['states'];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

  List vendorCompanyTypeData = [];
  Future<void> getVendorComapnyType() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",

        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_VENDOR_COMAPNY_TYPE}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          // print(' qualification >> $convertJson');
          if (convertJson["status"]) {
            setState(() {
              vendorCompanyTypeData = convertJson['data']['company_type'];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }


  List vendorCityData = [];
  Future<void> getVendorCity(String id) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",
          "state_id": "$id",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_CITY}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          // print(' qualification >> $convertJson');
          if (convertJson["status"]) {
            setState(() {
              vendorCityData = convertJson['data']['cities'];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

  List bankData = [];
  Future<void> getBank() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",

        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_BANK}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          //print(' bank >>> $convertJson');
          if (convertJson["status"]) {
            setState(() {
              bankData = convertJson['data']['banks'];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

  List experinceData = [];
  Future<void> getExperience() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",

        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_EXPERIENCE}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          //print(' experince >> $convertJson');
          if (convertJson["status"]) {
            setState(() {
              experinceData = convertJson['data']['work_exp'];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }


  Future<void> postImage(imageName, file) async {
    print(imageName);
    print(file);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var request = http.MultipartRequest(
            'POST', Uri.parse("${APIUrls.POST_IMAGES}"));
        request.files.add(await http.MultipartFile.fromPath('img', file));
        request.fields['phone_number'] = '$number';
        request.fields['img_name'] = '$imageName';
        request.headers['Authorization'] = 'Bearer $token';
        // print("In upload photo");
        var res = await request.send();
        print(res);
        try {
         // var convertJson = jsonDecode(res.body);
          //print(convertJson);
          print(res.statusCode);
          if (res.statusCode == 200){
            var responseBody = await http.Response.fromStream(res);
            var myData = json.decode(responseBody.body);
            print(myData);
            if (myData['status']) {
              setState(() {
                print(myData['data']['file_path']);
                if(imageName == "photo") {
                  pic = myData['data']['file_path'];
                }else if(imageName == "id_proof_doc"){
                  panfront = myData['data']['file_path'];
                }else if(imageName == "address_proof_doc"){
                  aadharback = myData['data']['file_path'];
                }else if(imageName == "gst_doc"){
                  gst = myData['data']['file_path'];
                }else if(imageName == "cancelled_cheque"){
                  check = myData['data']['file_path'];
                }
              });
            }
            // setState(() {
            //   bankData = convertJson['data']['banks'];
            // });
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text('${convertJson['error_msg']}'),
            // ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}
String capitalize(String value) {
  if(value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
class Capatalized extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}