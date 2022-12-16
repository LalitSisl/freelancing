import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/register.dart';
import 'package:freelancing/Controller/profile_controller.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:get/get.dart';

bool agree_tnc = false;

class Conditions extends StatefulWidget {
  const Conditions({Key? key}) : super(key: key);

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  profile_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.shade100,
      body: AlertDialog(
        title: const Text("Terms & Conditions"),
        content: Container(
          height: MediaQuery.of(context).size.height / 1.45,
          // width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                selectUser == "2"
                    ? Column(
                        children: [
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                "General Terms",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	All the details given by me to SISL in the previous tabs are absolutely true and correct. My application to work as a freelancer with SISL can be rejected if any of the details is found incorrect."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I authorize SISL to do my background verification and SISL reserves all the rights to accept or reject my application."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	My application is not entitled for any kind of employment with SISL or its associates. I shall not seek any benefits which employees of SISL would be entitled from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	Any task/project assigned by SISL will be for a specific time period and on certain payment terms as specifically agreed."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I am fully competent of doing tasks assigned by SISL as per declared skills."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I expressly agree to become the freelancer for SISL at the consideration duly agreed, and shall not be entitled to any other benefits from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                "Information Security",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will represent and perform the work contracted with SISL at the assigned sites."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not engage in any assignment with Clients and Competitors of SISL without express permission from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not disclose any professional credentials of Client and Competitors of SISL, and will not share personal contact details with anyone at and off site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not collect any information other than those given in the SOPs from anyone at the site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not disclose the information of any of the projects o SISL to any person including its competitors and acquittances."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not collect any information other than those given in the SOPs from anyone at the site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not disclose the information of any of the projects o SISL to any person including its competitors and acquittances."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Process Adherence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not take any document, asset, notes or any such similar document from the site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will strictly follow the timeline and the workflow as per the SOPs. If any change is required in the timeline or the process, it will be intimated to me by SISL in writing and I shall be bound by it."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will hand over, against written acknowledgement, all the assets and the documents (if provided by SISL for any task) to SISL after completion of the project."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will submit the sign-off in the formats provided by SISL for every project, as per the timelines agreed, and in absence of such timeline, upon completion of the project."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Liability and Indemnity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will be absolutely responsible for all and any damage caused by my negligence or careless handling of the assets, documents or notes at and off site. I undertake to indemnify SISL of any such damages."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will be responsible for claims, suits, actions, judgements, legal expenses, costs and expenses whatsoever arising out of, or in any way connected with fraud, gross negligence or willful misconduct by me."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Code of Conduct",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will act professionally, ethically and with integrity with everyone at the site, and perform accordingly."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not do anything against the organizations’ (SISL as well as its clients) policies that can cause harm to the brand value/ SISL/ Client of SISL. Such acts will include Smoking/Drinking inside the premises, using abusive or unprofessional language at workplace, carrying arms or ammunition at workplace, harassment, bullying, any kind of discrimination etc."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will not accept gifts, bribes or favors of any nature from the SISL Employees or from its clients. If I am found doing so, I can be removed from the site immediately. "))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I will follow and abide with all the provisions of law involved while working at the site, including all Labour Laws. "))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "Note - In case of I being found of violating any of the above-mentioned terms and conditions, SISL is authorized to take legal action and penalize for any loss caused to it.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          CheckboxListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              title: const Text(
                                "I accept the terms and condition",
                                style: TextStyle(fontSize: 14),
                              ),
                              value: agree_tnc,
                              onChanged: ((value) {
                                setState(() {
                                  agree_tnc = value!;
                                });
                              }))
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                "General Terms",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	All the details given by me to SISL in the previous tabs are absolutely true and correct. My application to work as a service partner with SISL can be rejected if any of the details is found incorrect."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I authorize SISL to do my background verification and SISL reserves all the rights to accept or reject my application."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	My application is not entitled for any kind of permanent partnership with SISL or its associates. I shall not seek any benefits which permanent partner of SISL would be entitled from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	Any task/project assigned by SISL will be for a specific time period and on certain payment terms as specifically agreed."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers/Employees are fully competent of doing tasks assigned by SISL as per declared skills. I shall duly give names of all my Engineers/Employees who shall be tasked with the work of SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I expressly agree to become the Service Partner for SISL at the consideration duly agreed, and shall not be entitled to any other benefits from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                "Information Security",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers/Employees will represent and perform the work contracted with SISL at the assigned sites."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not engage in any assignment with Clients and Competitors of SISL without express permission from SISL."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not disclose any professional credentials of Client and Competitors of SISL, and will not share personal contact details with anyone at and off site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not collect any information other than those given in the SOPs from anyone at the site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not disclose the information of any of the projects o SISL to any person including its competitors and acquittances."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Process Adherence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not take any document, asset, notes or any such similar document from the site."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will strictly follow the timeline and the workflow as per the SOPs. If any change is required in the timeline or the process, it will be intimated to me by SISL in writing and I shall be bound by it."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will hand over, against written acknowledgement, all the assets and the documents (if provided by SISL for any task) to SISL after completion of the project."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will submit the sign-off in the formats provided by SISL for every project, as per the timelines agreed, and in absence of such timeline, upon completion of the project."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Liability and Indemnity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will be absolutely responsible for all and any damage caused by me/my assigned engineers’ negligence or careless handling of the assets, documents or notes at and off site. I undertake to indemnify SISL of any such damages."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will be responsible for claims, suits, actions, judgements, legal expenses, 	costs and expenses whatsoever arising out of, or in any way connected with fraud, gross negligence or willful misconduct by me/my engineers."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text("Code of Conduct",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will act professionally, ethically and with integrity with everyone at the site, and perform accordingly."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not do anything against the organizations’ (SISL as well as its clients) policies that can cause harm to the brand value/ SISL/ Client of SISL. Such acts will include Smoking/Drinking inside the premises, using abusive or unprofessional language at workplace, carrying arms or ammunition at workplace, harassment, bullying, any kind of discrimination etc."))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will not accept gifts, bribes or favors of any nature from the SISL Employees or from its clients. If any engineer is found doing so, he shall be removed from the site immediately. "))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I/My Engineers will follow and abide with all the provisions of law involved while working at the site, including all Labour Laws. "))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "•	I shall pay salary/ commission to my engineers/Employees from my own account, and SISL shall not be liable in any form towards any compensation/ salary/ Fees/ Commission to my Engineers/ workers/ Employees whatsoever. Any deficit/ delayed / outstanding amount to them shall be my liability and responsibility, and shall compensate SISL for any loss/ penalty which they may have to incur at the behest of my Engineers/ Employees. "))
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: const [
                              Flexible(
                                  child: Text(
                                      "Note - In case of I/My Engineers being found of violating any of the above-mentioned terms and conditions, SISL is authorized to take legal action and penalize for any loss caused to it",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                          CheckboxListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              title: const Text(
                                "I accept the terms and condition",
                                style: TextStyle(fontSize: 14),
                              ),
                              value: agree_tnc,
                              onChanged: ((value) {
                                setState(() {
                                  agree_tnc = value!;
                                });
                              }))
                        ],
                      )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (agree_tnc == true) {
                      controller.agree_term_conditions();
                      Get.to(const Review());
                    } else {
                      Get.snackbar(
                          "Message", "Please check the checkbox to agree T&C",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 1));
                    }
                  },
                  child: const Text("Agree & Continue")),
            ],
          )
        ],
      ),
    );
  }
}
