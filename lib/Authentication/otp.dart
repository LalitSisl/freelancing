import 'package:flutter/material.dart';
import 'package:freelancing/Profile/profile.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class Otp extends StatefulWidget {
  String number;
  Otp({Key? key, required this.number}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/sisl.png',
                scale: 7,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  'SWAN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: .8,
                      color: Color.fromARGB(221, 44, 44, 44)),
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Phone Number Verification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
                text: "Enter the code sent to ",
                children: [
                  TextSpan(
                      text: widget.number,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
                style: const TextStyle(color: Colors.black54, fontSize: 15)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  // pastedTextStyle: TextStyle(
                  //   color: Colors.green.shade600,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  // obscuringWidget: const FlutterLogo(
                  //   size: 24,
                  // ),
                  //blinkWhenObscuring: true,
                  //animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 6) {
                      return "All field are required";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      activeColor: Colors.white,
                      selectedColor: Colors.white,
                      inactiveColor: Colors.white,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      fieldWidth: 35,
                      activeFillColor: Colors.grey,
                      selectedFillColor: Colors.grey,
                      inactiveFillColor: Colors.grey),
                  cursorColor: Colors.grey,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,

                  controller: textEditingController,
                  keyboardType: TextInputType.number,

                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");

                    return true;
                  },
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Get.to(const Profile());
              },
              child: const Text('Verify OTP'),
            ),
          )
        ]),
      ),
    ));
  }
}
