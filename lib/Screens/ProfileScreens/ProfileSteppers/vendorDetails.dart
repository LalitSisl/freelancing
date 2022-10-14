import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class VendorDetail extends StatelessWidget {
  VendorDetail({Key? key}) : super(key: key);
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
                key: controller.formKey, child: Text("ljhkjrhgkerthyelrjyulr6")

                //  Column(
                //   children: [
                //     persnolDetailTextField(
                //         controller.firstNameController, "vendorirst Name", (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Please enter first name";
                //       }
                //       return null;
                //     }, TextInputType.text, 50,
                //         [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
                //     persnolDetailTextField(
                //         controller.lastNameController, "Last Name", (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Please enter last name";
                //       }
                //       return null;
                //     }, TextInputType.text, 50,
                //         [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
                //     persnolDetailTextField1(
                //       controller.emailidController,
                //       "Email Id",
                //       (value) {
                //         String pattern =
                //             r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-z0-9](?:[a-z0-9-]"
                //             r"{0,253}[a-z0-9])?(?:\.[a-z0-9](?:[a-z0-9-]"
                //             r"{0,253}[a-z0-9])?)*$";
                //         RegExp regex = RegExp(pattern);
                //         if (value == null ||
                //             value.isEmpty ||
                //             !regex.hasMatch(value)) {
                //           return 'Enter a valid email address';
                //         } else {
                //           return null;
                //         }
                //       },
                //       TextInputType.text,
                //       50,
                //     ),
                //     persnolDetailTextField(
                //         controller.profileController, "Profile", (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Please enter your profile";
                //       }
                //       return null;
                //     }, TextInputType.text, 50,
                //         [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
                //     persnolDetailTextField(
                //         controller.addressController, "Address", (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Please enter your address";
                //       }
                //       return null;
                //     }, TextInputType.text, 100,
                //         [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: TextFormField(
                //         controller: controller.dobController,

                //         decoration: InputDecoration(
                //             suffixIcon: const Icon(Icons.calendar_month_outlined),
                //             isDense: true,
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: 12, vertical: 10),
                //             labelText: 'Date of Birth',
                //             focusedBorder: const OutlineInputBorder(
                //               borderSide: BorderSide(
                //                   color: ColorPalette.themeBlue, width: 0.5),
                //             ),
                //             enabledBorder: const OutlineInputBorder(
                //               borderSide: BorderSide(
                //                   color: ColorPalette.themeBlue, width: 0.5),
                //             ),
                //             labelStyle: SWANWidget.fieldLabelTextStyle,
                //             counterText: ""),
                //         //enabled: true,
                //         //inputFormatters: inputFormatters,
                //         maxLines: null,
                //         readOnly: true,
                //         style: SWANWidget.fieldValueTextStyle,

                //         validator: (value) {
                //           if (value!.isEmpty) {
                //             return 'Please provide date of birth';
                //           }
                //           return null;
                //         },
                //         onTap: () {
                //           controller.selectDate(context);
                //         },
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Label("Gender"),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: DropdownButton(
                //           hint: const Text("Choose Gender"),
                //           isDense: true,
                //           isExpanded: true,
                //           value: controller.selectedGenderOne,
                //           items: controller.genderList.map((item) {
                //             return DropdownMenuItem(
                //               child: Text(item, textAlign: TextAlign.center),
                //               value: item, //FAIL
                //             );
                //           }).toList(),
                //           onChanged: ((value) {
                //             controller.selectedGenderOne = value!;
                //             controller.genderController.text = controller.selectedGenderOne;
                //             controller.selectGender(value);
                //             print(value);
                //             print(
                //                 "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                //           })),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Label("Highest Qualification"),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: DropdownButton(
                //           hint: const Text("Select Highest Qualification"),
                //           isDense: true,
                //           isExpanded: true,
                //           value: controller.selectedqualificationOne,
                //           items: List.generate(
                //               controller
                //                   .getQualification!.data!.qualifications!.length,
                //               (index) => DropdownMenuItem(
                //                     child: Text(controller.getQualification!.data!
                //                         .qualifications![index].qualificationName
                //                         .toString()),
                //                     value: controller.getQualification!.data!
                //                         .qualifications![index].id,
                //                   )),
                //           onChanged: ((value) {
                //             controller.selectQuelification(value);
                //             controller.selectedqualificationOne = value!;
                //             print(value);
                //             controller.highestqualController.text = value.toString();
                //             print(
                //                 "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                //           })),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Label("Identity Proof"),
                //     persnolDetailTextField(
                //         controller.pancardController, "PAN Card Number", (value) {
                //       String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
                //       RegExp regex = RegExp(pattern);
                //       if (value == null ||
                //           value.isEmpty ||
                //           !regex.hasMatch(value)) {
                //         return 'Enter a valid pan number';
                //       } else {
                //         return null;
                //       }
                //     }, TextInputType.text, 10, [Capatalized()]),
                //     const SizedBox(
                //       height: 15,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return AlertDialog(
                //                     content: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         mainAxisSize: MainAxisSize.min,
                //                         children: [
                //                       GestureDetector(
                //                         onTap: () async {
                //                           controller.imgpan();
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
                //                           controller.imggallerypan();
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
                //                     ]));
                //               });
                //         },
                //         child: UplaodContainer("Upload PanCard", context,
                //             controller.panImage, controller.panfront)),
                //     const SizedBox(
                //       height: 15,
                //     ),
                //     persnolDetailTextField(
                //         controller.aadharController, "Aadhar Card Number",
                //         (value) {
                //       String pattern = r"^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$";
                //       RegExp regex = RegExp(pattern);

                //       if (value == null ||
                //           value.isEmpty ||
                //           !regex.hasMatch(value)) {
                //         return 'Enter a valid Aadhar number';
                //       } else {
                //         return null;
                //       }
                //     }, TextInputType.number, 12,
                //         [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]),
                //     const SizedBox(
                //       height: 15,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return AlertDialog(
                //                     content: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         mainAxisSize: MainAxisSize.min,
                //                         children: [
                //                       GestureDetector(
                //                         onTap: () async {
                //                           controller.imgaadhar();
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
                //                           controller.imggalleryaadhar();
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
                //                     ]));
                //               });
                //         },
                //         child: UplaodContainer("Upload Aadhar Card", context,
                //             controller.adharImage, controller.aadharback)),
                //     const SizedBox(
                //       height: 15,
                //     ),
                //     Label("Skills"),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: DropdownSearch.multiSelection(
                //         items: List.generate(
                //             controller.getSkill!.data!.skills!.length,
                //             (index) =>
                //                 controller.getSkill!.data!.skills![index].name),
                //         onChanged: (value) {
                //           print(value);
                //           controller.selectSkill(value);
                //           //  print(controller.selectedSkill);
                //           print("object~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                //         },
                //         selectedItems: controller.userDetail == null
                //             ? []
                //             : List.generate(
                //                 controller.userDetail!.data!.userDetails!
                //                     .profileDetails!.skills!.length,
                //                 (index) => controller
                //                     .userDetail!
                //                     .data!
                //                     .userDetails!
                //                     .profileDetails!
                //                     .skills![index]
                //                     .skillName),
                //       ),
                //     ),
                //  const   SizedBox(
                //       height: 40,
                //     ),
                //     Label("Total Experience"),
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: DropdownButton(
                //           hint: const Text("Select Experience"),
                //           isDense: true,
                //           isExpanded: true,
                //           value: controller.selectedexperienceOne,
                //           items: List.generate(
                //               controller.getExperience!.data!.workExp!.length,
                //               (index) => DropdownMenuItem(
                //                     child: Text(controller.getExperience!.data!
                //                         .workExp![index].name!),
                //                     value: controller
                //                         .getExperience!.data!.workExp![index].id
                //                         .toString(),
                //                   )),
                //           onChanged: ((newValue) {
                //             controller.selectExperience(newValue);
                //             controller.selectedexperienceOne = newValue!;
                //             print(newValue);
                //             print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                //           })),
                //     ),
                //   ],
                // ),

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
