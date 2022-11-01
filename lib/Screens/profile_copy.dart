import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freelancing/Authentication/login.dart';
import 'package:freelancing/Authentication/register.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Controller/registercontroller.dart';
import 'package:freelancing/Screens/ProfileScreens/ProfileSteppers/PersonalDetail.dart';
import 'package:freelancing/Screens/ProfileScreens/termandConditions.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:freelancing/Utils/APIURLs.dart';
import 'package:freelancing/global.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

var pic;

class profile_copy extends StatefulWidget {
  profile_copy({Key? key}) : super(key: key);

  @override
  State<profile_copy> createState() => _profile_copyState();
}

class _profile_copyState extends State<profile_copy> {
  profile_controller controller = Get.put(profile_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GetBuilder(
        init: profile_controller(),
        builder: (v) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 4,
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
                                  child: controller.profileimage == null &&
                                          controller.pic == null
                                      ? Image.asset('assets/images/user.png')
                                      : controller.profileimage != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                  controller.profileimage!,
                                                  fit: BoxFit.fill))
                                          : Image.network(
                                              '${APIUrls.BASE_URL_IMAGE}$pic',
                                              fit: BoxFit.cover,
                                            )),
                              Positioned(
                                  bottom: -5,
                                  right: -25,
                                  child: RawMaterialButton(
                                    onPressed: () async {
                                      controller.imgprofile();
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
                             '${controller.name} ${controller.lastName}' ,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(),
                              Text(
                                 controller.profile,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 5),
                              Text(loginNumber,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: AutoSizeText(controller.address,
                                maxLines: 3,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ])),
                ),
                Expanded(
                  child: Container(
                    //  height: MediaQuery.of(context).size.width,
                    //  width: MediaQuery.of(context).size.width,
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: controller.activeCurrentStep,
                      steps: controller.stepsList(),
                      onStepContinue: () {
                        // if (controller.formKey.currentState!.validate()) {
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }

                        // final isLastStep = controller.activeCurrentStep ==
                        //     controller.stepsList().length - 1;

                        if (controller.formKey.currentState!.validate() &&
                            controller.activeCurrentStep == 0) {
                          if (selectUser == "2") {
                            controller.add_Personal_Details();
                          } else {
                            controller.add_Vendor_Details();
                          }

                          //   controller.add_Personal_Details();
                        } else if ( controller.activeCurrentStep == 1&&controller.businessformKey.currentState!
                                .validate() ) {
                          // print("==================================================6666666");
                          controller.add_Business_Details();
                        } else if(controller.activeCurrentStep==2 && controller.bankformKey.currentState!.validate()){
                            controller.add_Bank_Details();
                            Get.to(() => Conditions());
                          
                        }
                      },
                      onStepCancel: () {
                        controller.activeCurrentStep == 0
                            ? null
                            : setState(() {
                                controller.activeCurrentStep -= 1;
                              });
                      },
                      onStepTapped: (int index) {
                        setState(() {
                          controller.activeCurrentStep = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
