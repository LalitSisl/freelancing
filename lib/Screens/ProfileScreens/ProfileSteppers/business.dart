import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Model/city.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/PersonalDetail.dart';
import 'package:freelancing/Screens/ProfileScreens/termandConditions.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:get/get.dart';

class BusinessDetail extends StatelessWidget {
  BusinessDetail({Key? key}) : super(key: key);
  profile_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: profile_controller(),
        builder: (v) {
          return Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: controller.businessformKey,
                  child: Column(
                    children: [
                      Label("Business Details"),
                      CheckboxListTile(
                        title: const Text(
                            "Do you have GST number"), //    <-- label
                        value: controller.checkbox,
                        onChanged: (newValue) {
                          print("h");
                          controller.gstNumberCheckBox(newValue!);
                          controller.checkbox = newValue;
                        },
                      ),
                      (controller.checkbox==true || controller.userDetail?.data!.userDetails!.businessDetails?.gstNumber !=null)
                          ? Column(
                              children: [
                                persnolDetailTextField(
                                    controller.gstNumberController,
                                    "Enter GST Number", (value) {
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
                                }, TextInputType.text, 30, [
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      print(controller.gst);
                                                      controller.imggstdoc();
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
                                                      controller
                                                          .imggallerygst();
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
                                        "Upload GST Proof",
                                        context,
                                        controller.GstProofImage,
                                        controller.gst)),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          : Container(),
                      persnolDetailTextField(controller.businessPanController,
                          "Business PAN Number", (value) {
                        String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
                        RegExp regex = RegExp(pattern);
                        if (value == null ||
                            value.isEmpty ||
                            !regex.hasMatch(value)) {
                          return 'Enter a valid pan number';
                        } else {
                          return null;
                        }
                      }, TextInputType.text, 11, [Capatalized()]),
                      Label("Service Area"),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownSearch.multiSelection(
                               popupProps:const PopupPropsMultiSelection.bottomSheet(
                                
                                showSearchBox: true,
                              
                                searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  hintText: "Type to search city ",
                                ),
                                 strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)
                                )
                              ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.themeBlue, width: 0.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.red, width: 0.5),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: "Select City",
                              // hintText: "country in menu mode",
                            ),
                          ),
                          items: List.generate(
                              controller
                                  .getallcitiesrepeat!.data!.cities!.length,
                              (index) => controller.getallcitiesrepeat!.data!
                                  .cities![index].cityName),
                          onChanged: (value) {
                            print(value);
                            controller.selectCity(value);
                            // print(controller.selectedSkill);
                            print(
                                "object~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                          },
                          selectedItems: controller.userDetail?.data!
                                      .userDetails!.businessDetails ==
                                  null
                              ? []
                              : List.generate(
                                  controller.userDetail!.data!.userDetails!
                                      .businessDetails!.serviceAreas!.length,
                                  (index) => controller
                                      .userDetail!
                                      .data!
                                      .userDetails!
                                      .businessDetails!
                                      .serviceAreas![index]
                                      .serviceAreaName),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
