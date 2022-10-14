import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:freelancing/global.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetail extends StatelessWidget {
  PersonalDetail({Key? key}) : super(key: key);
  profile_controller controller = Get.find();
  final multiSelectKey = GlobalKey<FormFieldState>();
  var gender;
  var option;
  var selectedOptions;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: profile_controller(),
      builder: (v) => Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  selectUser == "2"
                      ? Column(
                          children: [
                            persnolDetailTextField(
                                controller.firstNameController, "First Name",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter first name";
                              }
                              return null;
                            }, TextInputType.text, 50, [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]'))
                            ]),
                            persnolDetailTextField(
                                controller.lastNameController, "Last Name",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter last name";
                              }
                              return null;
                            }, TextInputType.text, 50, [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]'))
                            ]),
                            persnolDetailTextField1(
                              controller.emailidController,
                              "Email Id",
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
                              },
                              TextInputType.text,
                              50,
                            ),
                            persnolDetailTextField(
                                controller.profileController, "Profile",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your profile";
                              }
                              return null;
                            }, TextInputType.text, 50, [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]'))
                            ]),
                            persnolDetailTextField(
                                controller.addressController, "Address",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            }, TextInputType.text, 100, [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]'))
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: controller.dobController,

                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                        Icons.calendar_month_outlined),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    labelText: 'Date of Birth',
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPalette.themeBlue,
                                          width: 0.5),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPalette.themeBlue,
                                          width: 0.5),
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
                                    return 'Please provide date of birth';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  controller.selectDate(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Label("Gender"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text("Choose Gender"),
                                  isDense: true,
                                  isExpanded: true,
                                  value: controller.selectedGenderOne,
                                  items: controller.genderList.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item,
                                          textAlign: TextAlign.center),
                                      value: item, //FAIL
                                    );
                                  }).toList(),
                                  onChanged: ((value) {
                                    controller.selectedGenderOne = value!;
                                    controller.genderController.text =
                                        controller.selectedGenderOne;
                                    controller.selectGender(value);
                                    print(value);
                                    print(
                                        "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                                  })),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Label("Highest Qualification"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text(
                                      "Select Highest Qualification"),
                                  isDense: true,
                                  isExpanded: true,
                                  value: controller.selectedqualificationOne,
                                  items: List.generate(
                                      controller.getQualification!.data!
                                          .qualifications!.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(controller
                                                .getQualification!
                                                .data!
                                                .qualifications![index]
                                                .qualificationName
                                                .toString()),
                                            value: controller
                                                .getQualification!
                                                .data!
                                                .qualifications![index]
                                                .id,
                                          )),
                                  onChanged: ((value) {
                                    controller.selectQuelification(value);
                                    controller.selectedqualificationOne =
                                        value!;
                                    print(value);
                                    controller.highestqualController.text =
                                        value.toString();
                                    print(
                                        "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                                  })),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Label("Identity Proof"),
                            persnolDetailTextField(
                                controller.pancardController, "PAN Card Number",
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
                            }, TextInputType.text, 10, [Capatalized()]),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                                onTap: () {
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
                                                  controller.imgpan();
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
                                                  controller.imggallerypan();
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
                                            ]));
                                      });
                                },
                                child: UplaodContainer(
                                    "Upload PanCard",
                                    context,
                                    controller.panImage,
                                    controller.panfront)),
                            const SizedBox(
                              height: 15,
                            ),
                            persnolDetailTextField(controller.aadharController,
                                "Aadhar Card Number", (value) {
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
                            }, TextInputType.number, 12, [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ]),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                                onTap: () {
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
                                                  controller.imgaadhar();
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
                                                  controller.imggalleryaadhar();
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
                                            ]));
                                      });
                                },
                                child: UplaodContainer(
                                    "Upload Aadhar Card",
                                    context,
                                    controller.adharImage,
                                    controller.aadharback)),
                            const SizedBox(
                              height: 15,
                            ),
                            Label("Skills"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownSearch.multiSelection(
                                items: List.generate(
                                    controller.getSkill!.data!.skills!.length,
                                    (index) => controller
                                        .getSkill!.data!.skills![index].name),
                                onChanged: (value) {
                                  print(value);
                                  controller.selectSkill(value);
                                  //  print(controller.selectedSkill);
                                  print(
                                      "object~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                                },
                                selectedItems: controller.userDetail == null
                                    ? []
                                    : List.generate(
                                        controller
                                            .userDetail!
                                            .data!
                                            .userDetails!
                                            .profileDetails!
                                            .skills!
                                            .length,
                                        (index) => controller
                                            .userDetail!
                                            .data!
                                            .userDetails!
                                            .profileDetails!
                                            .skills![index]
                                            .skillName),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Label("Total Experience"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text("Select Experience"),
                                  isDense: true,
                                  isExpanded: true,
                                  value: controller.selectedexperienceOne,
                                  items: List.generate(
                                      controller
                                          .getExperience!.data!.workExp!.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(controller
                                                .getExperience!
                                                .data!
                                                .workExp![index]
                                                .name!),
                                            value: controller.getExperience!
                                                .data!.workExp![index].id
                                                .toString(),
                                          )),
                                  onChanged: ((newValue) {
                                    controller.selectExperience(newValue);
                                    controller.selectedexperienceOne =
                                        newValue!;
                                    print(newValue);
                                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                                  })),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            persnolDetailTextField(
                                controller.companyName, "Company Name",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter company name';
                              } else {
                                return null;
                              }
                            }, TextInputType.text, 100, [
                            UpperCaseTextFormatter()
                            ]),
                            Label2("Account Group"),
                            ListTile(
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
                                  groupValue: controller.selectedAccountGroup,
                                  onChanged: (value) {
                                    controller.selectAccountgroup(value);
                                    // controller.selectedAccountGroup = value!;
                                    print(controller.selectedAccountGroup);
                                  },
                                ),
                              ),
                              title: Text(
                                'Domestic',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            ListTile(
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              leading: Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: 'One Time Vendor',
                                  groupValue: controller.selectedAccountGroup,
                                  onChanged: (value) {
                                    controller.selectAccountgroup(value);
                                    // controller.selectedAccountGroup = value!;
                                    print(controller.selectedAccountGroup);
                                  },
                                ),
                              ),
                              title: Text(
                                'One Time Vendor',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),

                            Label2("Vendor Required For"),
                            ListTile(
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
                                  groupValue: controller.selectedVendor,
                                  onChanged: (value) {
                                    controller.selectVendorrequired(value);
                                    // controller.selectedVendor = value!;
                                  },
                                ),
                              ),
                              title: Text(
                                'For project supply/service',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            ListTile(
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
                                  groupValue: controller.selectedVendor,
                                  onChanged: (value) {
                                    controller.selectVendorrequired(value);
                                    // controller.selectedVendor = value!;
                                  },
                                ),
                              ),
                              title: Text(
                                'IT',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            ListTile(
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
                                  groupValue: controller.selectedVendor,
                                  onChanged: (value) {
                                    controller.selectVendorrequired(value);
                                    // controller.selectedVendor = value!;
                                  },
                                ),
                              ),
                              title: Text(
                                'Other',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Label("Vendor Details"),
                            persnolDetailTextField(
                                controller.companyEmail, "Email", (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid email address';
                              } else {
                                return null;
                              }
                            }, TextInputType.emailAddress, 50, [
                              FilteringTextInputFormatter.singleLineFormatter
                            ]),
                            const SizedBox(
                              height: 15,
                            ),
                            Label2("State"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text("Select State"),
                                  isDense: true,
                                  isExpanded: true,
                                   value: controller.selectedStateOne,
                                  items: List.generate(
                                      controller
                                          .getallStates!.data!.states!.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(controller
                                                .getallStates!
                                                .data!
                                                .states![index]
                                                .stateName!),
                                            value: controller.getallStates!
                                                .data!.states![index].stateId
                                                .toString(),
                                          )),
                                  onChanged: ((newValue) {
                                    
                                    controller.selectVendorstate(newValue);
                                     controller.selectedStateOne = newValue!;  
                                    controller.getcitiesData();
                                    print(newValue);
                                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                                  })),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Label2("City"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text("Select City"),
                                  isDense: true,
                                  isExpanded: true,
                                   value: controller.selectedCityone ,
                                  items: List.generate(
                                      controller
                                          .getallcities!.data!.cities!.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(controller
                                                .getallcities!
                                                .data!
                                                .cities![index]
                                                .cityName!),
                                            value: controller.getallcities!
                                                .data!.cities![index].cityId
                                                .toString(),
                                          )),
                                  onChanged: ((newValue) {
                                    controller.selectVendorcity(newValue);
                                    controller.selectedCityone = newValue!;

                                    print(newValue);
                                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                                  })),
                            ),
                     
                            const SizedBox(
                              height: 15,
                            ),
                            persnolDetailTextField(
                                controller.companyPincode, "Pincode", (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid pincode';
                              } else {
                                return null;
                              }
                            }, TextInputType.number, 6, [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                            persnolDetailTextField(
                                controller.companyPhone, "Phone Number",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid phone number';
                              } else {
                                return null;
                              }
                            }, TextInputType.number, 10, [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                            persnolDetailTextField(controller.autualTurnover,
                                "Actual Turnover (in Cr)", (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter actual turnover';
                              } else {
                                return null;
                              }
                            }, TextInputType.number, 5, [
                              FilteringTextInputFormatter.digitsOnly
                            ]),

                             Label2("Company Type"),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton(
                                  hint: const Text("Select Company Type"),
                                  isDense: true,
                                  isExpanded: true,
                                   value: controller.selectedcompanytype ,
                                  items: List.generate(
                                      controller
                                          .getallcompanytypes!.data!.companyType!.length,
                                      (index) => DropdownMenuItem(
                                            child: Text(controller
                                                .getallcompanytypes!.data!.companyType![index].name!),
                                            value: controller.getallcompanytypes!
                                                .data!.companyType![index].id
                                                .toString(),
                                          )),
                                  onChanged: ((newValue) {
                                    controller.selectcompanytype(newValue);
                                    controller.selectedcompanytype = newValue!;

                                    print(newValue);
                                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                                  })),
                            ),
                         SizedBox(height: 15,),
                            Label("Vendor Contact Information"),
                            persnolDetailTextField(controller.contactFirstname,
                                "Contact First Name", (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              } else {
                                return null;
                              }
                            }, TextInputType.text, 50, [
                             UpperCaseTextFormatter()
                            ]),
                            persnolDetailTextField(
                                controller.contactLastname, "Contact Last Name",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter last name';
                              } else {
                                return null;
                              }
                            }, TextInputType.text, 50, [
                             UpperCaseTextFormatter()
                            ]),
                            persnolDetailTextField(
                                controller.contactPosition, "Contact Position",
                                (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Designation/Position';
                              } else {
                                return null;
                              }
                            }, TextInputType.text, 50, [
                             UpperCaseTextFormatter()
                            ]),
                            persnolDetailTextField(
                                controller.contactPhonenumber,
                                "Contact Phone Number", (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              } else {
                                return null;
                              }
                            }, TextInputType.number, 10, [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                          ],
                        )
                ],
              ),
            ),
          )),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

class Capatalized extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
