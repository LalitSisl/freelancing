import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _activeCurrentStep = 0;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController business = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  // idebtity
  TextEditingController pancard = TextEditingController();
  TextEditingController aadharcard = TextEditingController();
  // bank
  TextEditingController accNumber = TextEditingController();
  TextEditingController confirmAccNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController accHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var gender;
  // ignore: prefer_typing_uninitialized_variables
  var pan;
  // ignore: prefer_typing_uninitialized_variables
  var aadhar;

  File? panfront;
  File? panback;
  File? aadharfront;
  File? aadharback;
  File? pic;

  var items = [
    'Male',
    'Female',
  ];

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
          content: SingleChildScrollView(
            child: Column(
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
                }, 250),
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
                    business,
                    'Buisness/Shop Name',
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
              ],
            ),
          ),
        ),
        // This is Step2 here we will enter our address
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('Identity Proof'),
            content: SingleChildScrollView(
              child: Column(
                children: [
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
                      value: pan,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      iconSize: 20,
                      style: const TextStyle(color: Colors.black),

                      items: [
                        'PAN Card',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (salutation) {
                        setState(() {
                          pan = salutation!;
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
                      [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
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
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorPalette.themeBlue)),
                                  width: 120,
                                  height: 80,
                                  child: Image.file(
                                    panfront!,
                                    fit: BoxFit.cover,
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
                                ? Column(
                                    children: const [
                                      Icon(
                                        Icons.image_outlined,
                                        size: 100,
                                      ),
                                      Text('Upload Front Image')
                                    ],
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                      panback != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorPalette.themeBlue)),
                              width: 120,
                              height: 80,
                              child: Image.file(
                                panback!,
                                fit: BoxFit.cover,
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
                              panback = File(image1.path);
                            });
                          }
                        },
                        child: panback == null
                            ? Column(
                                children: const [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 100,
                                  ),
                                  Text('Upload Back Image')
                                ],
                              )
                            : Container(),
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
                      value: pan,
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
                      [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
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
                          aadharfront != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorPalette.themeBlue)),
                                  width: 120,
                                  height: 80,
                                  child: Image.file(
                                    panfront!,
                                    fit: BoxFit.cover,
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
                                ? Column(
                                    children: const [
                                      Icon(
                                        Icons.image_outlined,
                                        size: 100,
                                      ),
                                      Text('Upload Front Image')
                                    ],
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                      aadharback != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorPalette.themeBlue)),
                              width: 120,
                              height: 80,
                              child: Image.file(
                                aadharback!,
                                fit: BoxFit.cover,
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
                            ? Column(
                                children: const [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 100,
                                  ),
                                  Text('Upload Back Image')
                                ],
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )),

        // This is Step3 here we will display all the details
        // that are entered by the user
        Step(
            state: StepState.editing,
            isActive: _activeCurrentStep >= 2,
            title: const Text('Bank'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SWANWidget.enabledTextFormField(
                      accNumber,
                      'Account Number',
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
                      confirmAccNumber,
                      'Confirm Account Number',
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
                      ifsc,
                      'IFSC Code',
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
                  SWANWidget.enabledTextFormField(
                      bankName,
                      'Bank Name',
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
                ],
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: pic != null
                                    ? Image.file(
                                        pic!,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: ColorPalette.themeBlue,
                                      )),

                            // child:
                            //     Image.file(
                            //       pic!,
                            //       fit: BoxFit.cover,
                            //     )
                          ),
                          Positioned(
                              bottom: 0,
                              right: -35,
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
                                ),
                                //padding: const EdgeInsets.all(2.0),
                                shape: const CircleBorder(),
                              )),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lalit Sharma',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Developer',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '9927677853',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Delhi',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _activeCurrentStep,
              steps: stepList(),
              onStepContinue: () {
                if (_activeCurrentStep < (stepList().length - 1)) {
                  setState(() {
                    _activeCurrentStep += 1;
                  });
                }
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
    );
  }
}
