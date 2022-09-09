import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/register.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/APIURLs.dart';

// ignore: must_be_immutable
class Otp extends StatefulWidget {
  String number;
  Otp({Key? key, required this.number}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController _otpController = TextEditingController();
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
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();

  }


  int _start = 30;
  late Timer _timer;
  bool isLoading = false;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            //isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }



  Future<void> verifyOTP(otp) async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    print(widget.number);
    print(otp);
    setState(() {
      isLoading=true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": "${widget.number}",
          "otp":'$otp'
        });
        var response = await http.post(Uri.parse(APIUrls.OTP_VERIFY), body: body);
        try {
          var convertJson = jsonDecode(response.body);
          print(' allit $convertJson');
          if (convertJson["status"]) {
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));

            setState(() {
              sharedPreferneces.setString('number', '${widget.number}');
              sharedPreferneces.setString('token', '${convertJson['token']}');
              print(sharedPreferneces.getString('number'));
            });
            Get.to(const Register());
          } else {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         
      body: Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
          Colors.red.shade500,
          Colors.red.shade400,
          Colors.red.shade300,
        ])
       ),
        child: Column(
          children: [
               Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:80,),
                    Text("Verify OTP",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: 5,),

                      // Text("Be Your Own Boss",style: TextStyle(fontSize: 20,color: Colors.white)),
                       AnimatedTextKit(

                totalRepeatCount: 1,
                    animatedTexts: [
                    TyperAnimatedText("Join a Team of 3500+ Members.",
                    textStyle: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,letterSpacing: .8,color: Colors.white,),
                    speed: Duration(milliseconds: 100)
                    ),
               ],
                  ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
               decoration:const BoxDecoration(
                color: Color.fromARGB(255, 255, 233, 232),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                )
               ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
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
                      const SizedBox(height: 30),

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
                                  activeFillColor: Colors.white,
                                  selectedFillColor: Colors.grey,
                                  inactiveFillColor: Colors.grey),
                              cursorColor: Colors.grey,
                              animationDuration: const Duration(milliseconds: 300),
                              enableActiveFill: true,

                              controller: _otpController,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            _start != 0 ?
                            Text('Resend in ${_start.toString()}'):Container(),
                            _start == 0 ?GestureDetector(
                              onTap: (){
                                setState(() {
                                  _start = 30;
                                  //isLoading = true;
                                  startTimer();
                                  resendOTP();
                                });
                              },
                              child: const Text('Resend OTP'),
                            ):Container(),
                          ],
                        ),
                      ),


                      const SizedBox(
                        height: 30,
                      ),
                      isLoading ?
                      const Align(
                          alignment: Alignment.bottomRight,
                          child: CircularProgressIndicator()):
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            //_modalBottomSheet();
                            if (formKey.currentState!.validate()) {
                              verifyOTP(_otpController.text);
                              //Get.to(const Register());
                            }
                          },
                          child: const Text('Verify OTP'),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> resendOTP() async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": "${widget.number}",
        });
        var response = await http.post(Uri.parse(APIUrls.OTP_RESEND), body: body);
        try {
          var convertJson = jsonDecode(response.body);
          print(convertJson);
          if (convertJson["status"]) {

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            // Get.to(Otp(number: phoneNumber));
          } else {

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['error_msg']}'),
            ));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong, try again later'),
          ));
        }
      }
    } on SocketException catch (_) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'No internet connection. Connect to the internet and try again.'),
      ));
    }
  }

}
