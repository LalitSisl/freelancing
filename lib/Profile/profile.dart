import 'dart:convert';
import 'dart:io';
import 'dart:ui';

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
import '../Utils/APIURLs.dart';
import 'Multiple Select/multi_select.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String? user;
  String? user_status;
  Profile({Key? key, required this.user, required this.user_status}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _selectaccount;
  var _selectvendor;
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

  var skill;
  var experience;
  var name = "[Name]";
  var profile = "[Profile]";
  var phone_no = "[Phone Number]";
  var addr = "[Address]";
  var sr = '';
  bool _checkbox = false;

  File? panfront;
  File? aadharfront;
  File? aadharback;
  File? pic;
  File? gst;
  File? check;

  // var items = [
  //   'Male',
  //   'Female',
  // ];

// mutli sleect state

  List<String> _selectedItems = [];
  List<String> _selectedItemscity = [];
  List<String> _selectedItemsskill = [];
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

    print(widget.user);
    getdata();
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
  List<String> _items =[];
  void _showMultiSelectskill() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    _items  = [
      'Computer Network',
      'Flutter',
      'Developer',
      'Web Developer',
    ];

    final List<String>? results = await showDialog(
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
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
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
          title: const Text('Personal Details'),
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
                                    fontSize: 12),
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
                              value: '0',
                              groupValue: _selectaccount,
                              onChanged: (value) {
                                setState(() {
                                  _selectaccount = value!;
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
                              value: '1',
                              groupValue: _selectaccount,
                              onChanged: (value) {
                                setState(() {
                                  _selectaccount = value!;
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
                                    fontSize: 12),
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
                              value: '0',
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
                              value: '1',
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
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Account Group',
                                style: TextStyle(
                                    color: ColorPalette.themeBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
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

                  SWANWidget.enabledTextFormField(
                      email,
                      'Email id',
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
                  }, 250),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]'))
                          ],
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
                              'Male',
                              'Female',
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
                          child: DropdownButtonFormField<String>(
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
                            // items: qualificationData.map((item) {
                            //   return DropdownMenuItem(
                            //     child: Text(item['item_name']),
                            //     value: item['id'].toString(),
                            //   );
                            // }).toList(),
                            items: [
                              '12th',
                              'BCA',
                              'B.Tech',
                              'M.Tech',
                              'Bsc',
                              'MCA',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
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

                            items: [
                              'Delhi',
                              'Mumbai',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
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

                            items: [
                              'Delhi',
                              'Karnataka',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
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
                  SizedBox(
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

                            items: [
                              'MNC',
                              'Other',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
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
                          [FilteringTextInputFormatter.singleLineFormatter],
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
                        }, 250)
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

                                                      if (image1 != null) {
                                                        setState(() {
                                                          panfront =
                                                              File(image1.path);
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
                                                          panfront =
                                                              File(image1.path);
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
                                            child: Image.file(
                                              panfront!,
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

                                                if (image1 != null) {
                                                  setState(() {
                                                    panfront =
                                                        File(image1.path);
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
                                                    panfront =
                                                        File(image1.path);
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

                                                  if (image1 != null) {
                                                    setState(() {
                                                      aadharback =
                                                          File(image1.path);
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
                                                      aadharback =
                                                          File(image1.path);
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
                                        child: Image.file(
                                          aadharback!,
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

                                            if (image1 != null) {
                                              setState(() {
                                                aadharback = File(image1.path);
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
                                                aadharback = File(image1.path);
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
                  widget.user == "2"
                      ? GestureDetector(
                          onTap: () {
                            print(_selectedItems);
                            _showMultiSelectskill();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: ColorPalette.themeBlue, width: 0.5)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Skills',
                                    style:
                                        SWANWidget.disabledFieldValueTextStyle,
                                  ),
                                  const Icon(Icons.arrow_drop_down)
                                ]),
                          ),
                        )
                      : Container(),
                  widget.user == "2"
                      ? Wrap(
                          children: _selectedItemsskill
                              .map((e) => Chip(
                                    label: Text(e),
                                  ))
                              .toList(),
                        )
                      : Container(),
                  widget.user == "2"
                      ? const SizedBox(
                          height: 8,
                        )
                      : Container(),

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

                            items: [
                              '0-1 year',
                              '1-2 year',
                              '2-3 year',
                              '3-4 year',
                              '4-5 year',
                              '5+ year',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (salutation) {
                              setState(() {
                                experience = salutation!;
                              });
                            },
                            //value: dropdownProject,
                            validator: (value) =>
                                value == null ? 'field required' : null,
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
                        setState(() => _checkbox = !_checkbox);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                    }, 250),
                    const SizedBox(
                      height: 8,
                    ),
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

                                              if (image1 != null) {
                                                setState(() {
                                                  gst = File(image1.path);
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
                                                  gst = File(image1.path);
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
                                    child: Image.file(
                                      gst!,
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

                                        if (image1 != null) {
                                          setState(() {
                                            gst = File(image1.path);
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
                                            gst = File(image1.path);
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
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    SWANWidget.enabledTextFormField(
                        businessPanCard,
                        'PAN Card Number',
                        TextInputType.text,
                        [FilteringTextInputFormatter.singleLineFormatter],
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
                    }, 250),
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

                    GestureDetector(
                      onTap: () {
                        //print(_selectedItems);
                        _showMultiSelectcity();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: ColorPalette.themeBlue, width: 0.5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select City',
                                style: SWANWidget.disabledFieldValueTextStyle,
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ]),
                      ),
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

                        items: [
                          'State Bank of India',
                          'Centrel Bank of india',
                          'Punjab nationa l bank',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
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
                    }, 250),
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
                      return null;
                    }, 250),
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

                                              if (image1 != null) {
                                                setState(() {
                                                  check = File(image1.path);
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
                                                  check = File(image1.path);
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
                                    child: Image.file(
                                      check!,
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

                                        if (image1 != null) {
                                          setState(() {
                                            check = File(image1.path);
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
                                            check = File(image1.path);
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
                    height: 190,
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
                        right: 10,
                        child: Stack(
                          children: [
                            Container(
                                height: 130,
                                width: 130,
                                child: pic != null
                                    ? Image.file(
                                        pic!,
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

                                    if (image1 != null) {
                                      setState(() {
                                        pic = File(image1.path);
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
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 30,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$name $sr',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              widget.user == "2"
                                  ? const SizedBox(height: 5)
                                  : Container(),
                              widget.user == "2"
                                  ? Row(
                                      children: [
                                        Text(profile,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text('$number',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(addr,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ],
                          ),
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
                      if (formKeys[_activeCurrentStep]
                          .currentState!
                          .validate()) {
                        if (_activeCurrentStep == 0) {
                          print('lalit');
                          add_Personal_Details(
                            firstName.text,
                            lastName.text,
                            email.text,
                            address.text,
                            work.text,
                            dob.text,
                            gender,
                            qualification,
                            pancard.text,
                            panfront,
                            aadharcard.text,
                            aadharfront,
                            _selectedItemsskill,
                            experience,
                          );
                          _activeCurrentStep += 1;
                        } else if (_activeCurrentStep == 1) {
                          add_Business_Details(
                            gstnumber.text,
                            gst,
                            businessPanCard.text,
                            _selectedItemscity
                          );
                        }

                        // Get.to(const Dashboard());
                      }
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
    _selectedItemsskill,
    experience,
  ) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$number',
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
          "skills": "$_selectedItemsskill",
          "total_experience": '$experience',
        });

        var response = await http.post(Uri.parse(APIUrls.ADD_PERSONAL_DETAILS),
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
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
  _selectedItemscity
      ) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$number',
          "user_id": '$user_id',
          "gst_number": "$gstnumber",
          "gst_doc": "$gst",
          "pan_number": "$businessPanCard",
          "service_area": "1,2"
        });

        var response = await http.post(Uri.parse(APIUrls.ADD_BUSINESS_DETAILS),
            headers: {'Authorization': 'Bearer $token'},
            body: body);

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
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
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$number',
          "user_id": '$user_id',
          "bank": "1",
          "account_no": "$accNumber",
          "ifsc_code": "$ifsc",
          "account_holder_name": "$accHolderName",
          "cancel_checque":"$check",
          "account_type":"2"
        });

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
          print(convertJson);
          if (convertJson["status"]) {
            qualificationData = convertJson['data']['qualifications'];
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

  //getSkills

  Future<void> getSkills() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.GET_SKILLS}", queryParams),
            headers: {'Authorization': 'Bearer $token'});

        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {
           // _items = convertJson['data']['skills'];
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

}
