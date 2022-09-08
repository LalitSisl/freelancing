import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../Profile/Multiple Select/multi_select.dart';

import 'package:freelancing/Dashboard/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import '../UpdateProfile/updateProfile.dart';

import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool _isVisible = true;
  bool _isBusiness = true;
  bool _isBank = true;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController business = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  // idebtity
  TextEditingController pancard = TextEditingController();
  TextEditingController aadharcard = TextEditingController();

  // business
  TextEditingController vendorid = TextEditingController();
  TextEditingController companyname = TextEditingController();

  // bank
  TextEditingController accNumber = TextEditingController();
  TextEditingController confirmAccNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController accHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var gender;
  var qualification;
  var workcity;
  var acctype;
  // ignore: prefer_typing_uninitialized_variables
  var panDropdown;
  // ignore: prefer_typing_uninitialized_variables
  var aadhar;

  var skill;

  bool _checkbox = true;

  File? panfront;
  File? panback;
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

  void _showMultiSelectskill() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'Computer Network',
      'Flutter',
      'Developer',
      'Web Developer',
      'Computer Network',
      'Flutter',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorPalette.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorPalette.white,
            leading: const Icon(Icons.arrow_back_ios_rounded,color: ColorPalette.themeBlue,),
            title: Text('Update Profile',
                style: GoogleFonts.adamina(
                  color: ColorPalette.themeBlue,
                    fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.themeBlue),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -1),
                      title: Text('Personal Details',style: SWANWidget.fieldLabelTextStyle,),
                      trailing:
                      _isVisible ?
                      const Icon(Icons.keyboard_arrow_down_outlined):
                      const Icon(Icons.keyboard_arrow_up_outlined),
                    ),
                  ),
                  _isVisible ? Container():
                  Card(
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SWANWidget.enabledTextFormField(
                            firstName,
                            'First Name',
                            TextInputType.text,
                            [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                                (value) {
                              if (value.isEmpty) {
                                return 'The field is mandatory';
                              }
                              return null;
                            },
                            250,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SWANWidget.enabledTextFormField(
                              lastName,
                              'Last Name',
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
                          SWANWidget.enabledTextFormField(
                              address,
                              'Address',
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
                          SWANWidget.enabledTextFormField(
                              work,
                              'Work Title',
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
                          TextFormField(
                            controller: dob,
                            decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.calendar_month_outlined),
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
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                isDense: true, // Added this
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorPalette.themeBlue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorPalette.themeBlue,
                                  ),
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
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Highest Qualification',
                                isDense: true, // Added this
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorPalette.themeBlue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorPalette.themeBlue,
                                  ),
                                ),
                              ),
                              value: qualification,

                              dropdownColor: Colors.white,
                              isExpanded: true,
                              iconSize: 20,
                              style: const TextStyle(color: Colors.black),

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
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: const TextSpan(
                                  text: 'Identity Proof',
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
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'ID Proof',
                                isDense: true, // Added this
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorPalette.themeBlue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorPalette.themeBlue,
                                  ),
                                ),
                              ),
                              value: panDropdown,

                              dropdownColor: Colors.white,
                              isExpanded: true,
                              iconSize: 20,
                              style: const TextStyle(color: Colors.black),

                              items: [
                                'Pan Card',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (salutation) {
                                setState(() {
                                  panDropdown = salutation!;
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
                              pancard,
                              'PAN Card Number',
                              TextInputType.text,
                              [FilteringTextInputFormatter.singleLineFormatter],
                                  (value) {
                                if (value.isEmpty) {
                                  return 'The field is mandatory';
                                }
                                return null;
                              }, 250),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  panfront != null
                                      ? GestureDetector(
                                    onTap: () async {
                                      final ImagePicker _picker =
                                      ImagePicker(); //added type ImagePicker
                                      var image1 = await _picker.getImage(
                                          source: ImageSource.camera);

                                      if (image1 != null) {
                                        setState(() {
                                          panfront = File(image1.path);
                                        });
                                      }
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
                                          panfront!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  GestureDetector(
                                    onTap: () async {
                                      final ImagePicker _picker =
                                      ImagePicker(); //added type ImagePicker
                                      var image1 = await _picker.getImage(
                                          source: ImageSource.camera);

                                      if (image1 != null) {
                                        setState(() {
                                          panfront = File(image1.path);
                                        });
                                      }
                                    },
                                    child: panfront == null
                                        ? Container(
                                      height: 130,
                                      width:
                                      MediaQuery.of(context).size.width / 1.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Address Proof',
                                isDense: true, // Added this
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorPalette.themeBlue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorPalette.themeBlue,
                                  ),
                                ),
                              ),
                              value: aadhar,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              iconSize: 20,
                              style: const TextStyle(color: Colors.black),

                              items: [
                                'Aadhar Card',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (salutation) {
                                setState(() {
                                  aadhar = salutation!;
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
                              aadharcard,
                              'Aadhar Card Number',
                              TextInputType.text,
                              [FilteringTextInputFormatter.digitsOnly], (value) {
                            if (value.isEmpty) {
                              return 'The field is mandatory';
                            }
                            return null;
                          }, 250),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              aadharfront != null
                                  ? GestureDetector(
                                onTap: () async {
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      aadharfront = File(image1.path);
                                    });
                                  }
                                },
                                child: Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      aadharfront!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                                  : Container(),
                              GestureDetector(
                                onTap: () async {
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      aadharfront = File(image1.path);
                                    });
                                  }
                                },
                                child: aadharfront == null
                                    ? Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/upload.png',
                                        scale: 3,
                                      ),
                                      Text(
                                        'Upload id proof Side of front',
                                        style: SWANWidget.subtextRegularTextStyle,
                                      )
                                    ],
                                  ),
                                )
                                    : Container(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              aadharback != null
                                  ? GestureDetector(
                                onTap: () async {
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      aadharback = File(image1.path);
                                    });
                                  }
                                },
                                child: Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      aadharback = File(image1.path);
                                    });
                                  }
                                },
                                child: aadharback == null
                                    ? Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorPalette.textGrey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/upload.png',
                                        scale: 3,
                                      ),
                                      Text(
                                        'Upload id proof Side of back',
                                        style: SWANWidget.subtextRegularTextStyle,
                                      )
                                    ],
                                  ),
                                )
                                    : Container(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          Padding(
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
                          ),
                          GestureDetector(
                            onTap: () {

                              _showMultiSelectskill();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: ColorPalette.themeBlue)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Select Skills',
                                      style: SWANWidget.disabledFieldValueTextStyle,
                                    ),
                                    const Icon(Icons.arrow_drop_down)
                                  ]),
                            ),
                          ),
                          Wrap(
                            children: _selectedItemsskill
                                .map((e) => Chip(
                              label: Text(e),
                            ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Total Experience',
                                isDense: true, // Added this
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorPalette.themeBlue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorPalette.themeBlue,
                                  ),
                                ),
                              ),
                              value: skill,

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
                                  skill = salutation!;
                                });
                              },
                              //value: dropdownProject,
                              validator: (value) =>
                              value == null ? 'field required' : null,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPalette.themeBlue),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          _isBusiness = !_isBusiness;
                        });
                      },
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -1),
                      title: Text('Business Details',style: SWANWidget.fieldLabelTextStyle,),
                      trailing:
                      _isBusiness ?
                      const Icon(Icons.keyboard_arrow_down_outlined):
                      const Icon(Icons.keyboard_arrow_up_outlined),
                    ),
                  ),
                  _isBusiness ? Container():
                  Card(
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                              vendorid,
                              'Enter GST number',
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
                          Column(
                            children: [
                              gst != null
                                  ? GestureDetector(
                                onTap: () async {
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      gst = File(image1.path);
                                    });
                                  }
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
                                  final ImagePicker _picker =
                                  ImagePicker(); //added type ImagePicker
                                  var image1 = await _picker.getImage(
                                      source: ImageSource.camera);

                                  if (image1 != null) {
                                    setState(() {
                                      gst = File(image1.path);
                                    });
                                  }
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
                              vendorid,
                              'PAN Card Number',
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
                                  border: Border.all(color: ColorPalette.themeBlue)),
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

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPalette.themeBlue),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          _isBank = !_isBank;
                        });
                      },
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -1),
                      title: Text('Bank Details',style: SWANWidget.fieldLabelTextStyle,),
                      trailing:
                      _isBank ?
                      const Icon(Icons.keyboard_arrow_down_outlined):
                      const Icon(Icons.keyboard_arrow_up_outlined),
                    ),
                  ),
                  _isBank ? Container():
                      Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Select Bank',
                                    isDense: true, // Added this
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: ColorPalette.themeBlue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorPalette.themeBlue,
                                      ),
                                    ),
                                  ),
                                  value: workcity,

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
                                      workcity = salutation!;
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
                                height: 45,
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Account Type',
                                    isDense: true, // Added this
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: ColorPalette.themeBlue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorPalette.themeBlue,
                                      ),
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
                                      final ImagePicker _picker =
                                      ImagePicker(); //added type ImagePicker
                                      var image1 = await _picker.getImage(
                                          source: ImageSource.camera);

                                      if (image1 != null) {
                                        setState(() {
                                          check = File(image1.path);
                                        });
                                      }
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
                                          aadharfront!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  GestureDetector(
                                    onTap: () async {
                                      final ImagePicker _picker =
                                      ImagePicker(); //added type ImagePicker
                                      var image1 = await _picker.getImage(
                                          source: ImageSource.camera);

                                      if (image1 != null) {
                                        setState(() {
                                          check = File(image1.path);
                                        });
                                      }
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
                                            'Upload Cancle Check',
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
                      )




                ],
              ),
            ),
          ),
        ));
  }
}
