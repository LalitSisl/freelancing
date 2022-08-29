import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/APIURLs.dart';
import 'otp.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  var isLoading = false;

  Widget _buildDropdownItem(country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 5.0,
          ),
          Text("+${country.phoneCode}"),
        ],
      );

  Future<void> sendOTP(phoneNumber) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "phone_number": phoneNumber,
        });
        var response = await http.post(Uri.parse(APIUrls.LOG_IN), body: body);
        try {
          var convertJson = jsonDecode(response.body);

          if (convertJson["status"]) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
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
      backgroundColor: Colors.white,
      body: Form(
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
                                color: Color.fromARGB(221, 44, 44, 44)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Image.network(
                      'https://thumbs.dreamstime.com/b/login-illustration-letter-cubes-forming-word-36025252.jpg',
                      scale: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: ColorPalette.bgGrey,
                                border:
                                    Border.all(color: ColorPalette.textGrey),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              '+91',
                              style: TextStyle(
                                  color: ColorPalette.textGrey, fontSize: 16),
                            )),
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 35,
                            child: const VerticalDivider(
                                color: ColorPalette.textGrey)),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 5),
                                border: InputBorder.none,
                                hintText: "Phone Number",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorPalette.textGrey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorPalette.textGrey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorPalette.textGrey),
                                  borderRadius: BorderRadius.circular(5),
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
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
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
                    // const SizedBox(height: 22),
                    // IntlPhoneField(
                    //   controller: _phoneController,
                    //   decoration: const InputDecoration(
                    //     isDense: true,
                    //     labelText: 'Phone Number',
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.blue),
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //   ),
                    //   onChanged: (phone) {
                    //     if (kDebugMode) {
                    //       print(phone.completeNumber);
                    //     }
                    //   },
                    //   onCountryChanged: (country) {
                    //     if (kDebugMode) {
                    //       print('Country changed to: ' + country.name);
                    //     }
                    //   },
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.to(Otp(number: _phoneController.text));
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
    ));
  }
}
