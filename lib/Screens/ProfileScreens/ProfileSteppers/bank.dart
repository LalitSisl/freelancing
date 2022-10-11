import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:get/get.dart';

class BankDetail extends StatelessWidget {
  BankDetail({Key? key}) : super(key: key);
  profile_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Label("Bank Details"),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                    hint: const Text("Select Bank"),
                    isDense: true,
                    isExpanded: true,
                    //  value: controller.bankController.text,
                    items: List.generate(
                        controller.getallBanks!.data!.banks!.length,
                        (index) => DropdownMenuItem(
                              child: Text(controller
                                  .getallBanks!.data!.banks![index].bankName
                                  .toString()),
                              value: controller
                                  .getallBanks!.data!.banks![index].id,
                            )),
                    onChanged: ((selectedbank) {
                      controller.selectBanks(selectedbank);
                      print(selectedbank);
                      print(
                          "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                    })),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton(
                    hint: const Text("Select Account Type"),
                    isDense: true,
                    isExpanded: true,
                    // value: controller.accountTypeController.text,
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
                    onChanged: ((accounttype) {
                      controller.accountTypeController.text =
                          accounttype.toString();
                      print(accounttype);
                      print(
                          "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                    })),
              ),
              const SizedBox(
                height: 15,
              ),
              persnolDetailTextField(
                  controller.accountController, "Account Number", (value) {
                if (value == null || value.isBlank) {
                  return "Please enter First Name";
                }
                return null;
              }, TextInputType.number, 50,
                  [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]),
              persnolDetailTextField(
                  controller.cAccountController, "Confirm Account Number",
                  (value) {
                if (value == null || value.isBlank) {
                  return "Please enter First Name";
                }
                return null;
              }, TextInputType.number, 50,
                  [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]),
              persnolDetailTextField(controller.ifscController, "IFSC Code",
                  (value) {
                if (value == null || value.isBlank) {
                  return "Please enter First Name";
                }
                return null;
              }, TextInputType.text, 50,
                  [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
              // persnolDetailTextField(
              //     controller.accountTypeController, "Account Type", (value) {
              //   if (value == null || value.isBlank) {
              //     return "Please enter First Name";
              //   }
              //   return null;
              // },
              // TextInputType.text,50,   [ FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]
              // ),
              persnolDetailTextField(
                  controller.accountHolder, "Account Holder Name", (value) {
                if (value == null || value.isBlank) {
                  return "Please enter First Name";
                }
                return null;
              }, TextInputType.text, 50,
                  [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
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
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                GestureDetector(
                                  onTap: () async {
                                    controller.imgcheque();
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
                                    controller.imggallerycheque();
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
                              ]));
                        });
                  },
                  child: UplaodContainer("Upload Cancel Check", context,
                      controller.panImage, controller.check))
            ],
          ),
        ));
  }
}
