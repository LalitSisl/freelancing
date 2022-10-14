import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:freelancing/Screens/profile_copy.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/APIURLs.dart';
import 'otp.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();

  var isLoading = false;

  Future<void> sendOTP(phoneNumber) async {
      
    print(phoneNumber);
    setState(() {
      isLoading = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": '$phoneNumber',
        });
        var response = await http.post(Uri.parse(APIUrls.LOG_IN), body: body);
        try {
          var convertJson = jsonDecode(response.body);
          print('   lalit $convertJson');
          if (convertJson["status"]) {
            setState(() {
              isLoading = false;
             
            });
            Get.snackbar("Success", convertJson['success_msg'],
                duration: const Duration(seconds: 1),
                snackPosition: SnackPosition.BOTTOM);

            Get.to(Otp(number: phoneNumber));
          } else {
            setState(() {
              isLoading = false;
            
            });
            Get.snackbar("Error", convertJson['error_msg'],
                snackPosition: SnackPosition.BOTTOM);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // _phoneController = TextEditingController(text: "8295019701");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.red.shade500,
          Colors.red.shade400,
          Colors.red.shade300,
        ])),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    // Text("Be Your Own Boss",style: TextStyle(fontSize: 20,color: Colors.white)),
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText("Be Your Own Boss",
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .8,
                              color: Colors.white,
                            ),
                            speed: Duration(milliseconds: 200)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 243, 243),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 22),
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
                                          color:
                                              Color.fromARGB(221, 44, 44, 44)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 40),
                              // Image.network(
                              //   'https://thumbs.dreamstime.com/b/login-illustration-letter-cubes-forming-word-36025252.jpg',
                              //   scale: 10,
                              // ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 22),
                                      alignment: Alignment.center,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.white,
                                          border: Border.all(
                                              color: ColorPalette.textGrey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text(
                                        '+91',
                                        style: TextStyle(
                                            color: ColorPalette.textGrey,
                                            fontSize: 16),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      height: 35,
                                      child: const VerticalDivider(
                                          color: ColorPalette.textGrey)),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedErrorBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 13, horizontal: 5),
                                          border: InputBorder.none,
                                          hintText: "Phone Number",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: ColorPalette.textGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: ColorPalette.textGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: ColorPalette.textGrey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          )),
                                      maxLength: 10,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        // this.phoneNo=value;
                                        print(value);
                                      },
                                      validator: (value) {
                                        String pattern =
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                        RegExp regExp = new RegExp(pattern);
                                        if (value?.length == 0) {
                                          return 'Please enter mobile number';
                                        } else if (!regExp.hasMatch(value!)) {
                                          return 'Please enter valid mobile number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 50,
                              ),
                              isLoading
                                  ? const Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircularProgressIndicator())
                                  : Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            sendOTP(_phoneController.text);
                                          }
                                        },
                                        child: const Text('Send OTP'),
                                      ),
                                    )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
