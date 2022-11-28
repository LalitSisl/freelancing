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
          child: Form(
            key: controller.bankformKey,
            child: Column(
              children: [
                Label("Bank Details (Optional)"),
                Row(
                  children: [
                    Checkbox(
                        value: controller.bankdetails,
                        onChanged: ((newValue) {
                          controller.bankdetailsoptional(newValue!);
                          controller.bankdetails = newValue;
                        })),
                    const Text("I will update it later")
                  ],
                ),
                controller.bankdetails == false
                    ? Column(
                        children: [
                          //  Padding(
                          //    padding: const EdgeInsets.all(5.0),
                          //    child: CheckboxListTile(
                          //                 contentPadding: const EdgeInsets.symmetric(
                          //                     horizontal: 0, vertical: 0),
                          //                 title: const Text(
                          //                   "I will update it later",
                          //                   style: TextStyle(fontSize: 14),
                          //                 ),
                          //                 value: controller.bankdetails,
                          //                 onChanged: ((newValue) {
                          //                    controller.bankdetailsoptional(newValue!);
                          //             controller.bankdetails = newValue;
                          //                 })),
                          //  ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButton(
                                hint: const Text("Select Bank"),
                                isDense: true,
                                isExpanded: true,
                                value: controller.selectedbankOne,
                                items: List.generate(
                                    controller.getallBanks!.data!.banks!.length,
                                    (index) => DropdownMenuItem(
                                          child: Text(controller.getallBanks!
                                              .data!.banks![index].bankName!),
                                          value: controller.getallBanks!.data!
                                              .banks![index].id
                                              .toString(),
                                        )),
                                onChanged: ((newValue) {
                                  controller.selectBanks(newValue);
                                  controller.selectedbankOne = newValue;
                                  print(newValue);
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
                                value: controller.selectedAccountType,
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
                                onChanged: ((newValue) {
                                  controller.selectAccount(newValue);
                                  controller.selectedAccountType = newValue;
                                  print(newValue);
                                  print(
                                      "~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@~~~~~~~~~~~");
                                })),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          persnolDetailTextField(
                              controller.accountController, "Account Number",
                              (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter account number";
                            }
                            return null;
                          }, TextInputType.number, 18, [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny('  ')
                          ]),
                          persnolDetailTextField(controller.cAccountController,
                              "Confirm Account Number", (value) {
                            if (value.isEmpty) {
                              return 'Please confirm your account number';
                            }
                            if (value != controller.accountController.text) {
                              return 'Account number and confirm account number should same';
                            }
                            return null;
                          }, TextInputType.number, 18, [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny('  ')
                          ]),
                          persnolDetailTextField(
                              controller.ifscController, "IFSC Code", (value) {
                            String pattern = "^[A-Z]{4}0[A-Z0-9]{6}";
                            RegExp regex = RegExp(pattern);
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Enter a valid ifsc code';
                            } else {
                              return null;
                            }
                          }, TextInputType.text, 11, [
                            FilteringTextInputFormatter.singleLineFormatter,
                            FilteringTextInputFormatter.deny(' ')
                          ]),
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
                              controller.accountHolder, "Account Holder Name",
                              (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter account holder name";
                            }
                            return null;
                          }, TextInputType.text, 50, [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z]')),
                            FilteringTextInputFormatter.deny('  ')
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
                              child: UplaodContainer(
                                  "Upload Cancel Check",
                                  context,
                                  controller.cancelCheqImage,
                                  controller.check))
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}
