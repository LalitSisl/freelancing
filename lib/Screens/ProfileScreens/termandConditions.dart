
import 'package:flutter/material.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:get/get.dart';

class Conditions extends StatefulWidget {
  const Conditions({Key? key}) : super(key: key);

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: AlertDialog(
        title: const Text("Terms & Conditions"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(children:const [
                Flexible(child: Text("I acknowledge that,",style: TextStyle(fontWeight: FontWeight.bold), ),),
             
              ],),
             const SizedBox(height: 7,),
              Row(
                children: const[
                  Flexible(child: Text("•	All the details given by me in the previous tabs are correct as per my knowledge. My candidature can be rejected if any of the details is found incorrect."))
                ],
              ),
                  const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will be representing SISL at the assigned sites."))
              ],),    const SizedBox(height: 7,),
              Row(
                children:const [
                  Flexible(child: Text("•	I/My Engineers will not disclose any personal identity and will not share personal contact details with anyone at the site."))
                ],
              ),    const SizedBox(height: 7,),
              Row(children:const [
                Flexible(child: Text("•	I/My Engineers will not collect any information other than those given in the SOPs from anyone at the site."))
              ],),    const SizedBox(height: 7,),
              Row(children:const [
                Flexible(child: Text("•	I/My Engineers will not take away any document, asset, or notes from the site if they are not authorized to do so as per the SOP."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will follow the timeline and the workflow exactly as per the SOPs, not going according to the personal inputs, interests or experience. If any change is required in the timeline or the process that must be authorized by SISL in written."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will handover all the assets and the documents (if provided by SISL for any task) to SISL after completing the project."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will not disclose the information of the project to any unauthorized person like competitors, friends, family or acquittances."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will be responsible for any damage caused by the assigned engineers’ negligence or carelessly handling of the assets, documents or notes."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	I/My Engineers will not do anything against the organizations’ (SISL as well as the client companies) policies that can cause harm to the brand value. (For ex – Smoking/Drinking inside the premises, using abusive or unprofessional language at workplace, carrying arms or ammunition at workplace, any kind of discrimination defined in Indian Constitution or sexual harassment with anybody at workplace)."))
              ],),    const SizedBox(height: 7,),
              Row(children: const[
                Flexible(child: Text("•	In case of I/My Engineers being found of violating any of the terms and conditions, defined above or as per the Indian Law, SISL is authorized to take disciplinary as well as legal action."))
              ],)
            ],
          ),
        ),
       actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
             Get.to(const Review());
          }, child:const Text("Agree & Continue")),
        ],
      )
       ],
      ),
    );
  }
}