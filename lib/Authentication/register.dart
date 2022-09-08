import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/Screens/review.dart';
import 'package:http/http.dart' as http;
import '../Profile/profile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/APIURLs.dart';
import '../Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ignore: prefer_typing_uninitialized_variables
  var _selectUser;

var isLoading =false;


  @override
  initState() {
    super.initState();

    getdata();
  }

  var number;
  var token;
  void getdata() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    setState(() {
      number = sharedPreferneces.getString('number');
      token = sharedPreferneces.getString('token');
    });
  }

  Future<void> register() async {
    SharedPreferences sharedPreferneces = await SharedPreferences.getInstance();
    setState(() {
      isLoading=true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var queryParams = {
          "phone_number": "$number",
          "user_type": "$_selectUser"
        };
        var response = await http.get(
            Uri.http("${APIUrls.DOMAIN}", "${APIUrls.REGISTER_AS}", queryParams),
            headers: {'Authorization': 'Bearer $token'});
        // var response = await http.post(Uri.parse(APIUrls.LOG_IN, queryParams),
        //     headers: {'Authorization': 'Bearer ${SharedPref.token}'});
        try {
          var convertJson = jsonDecode(response.body);
          print('   lalit $convertJson');
          if (convertJson["status"]) {

            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${convertJson['success_msg']}'),
            ));
            setState(() {
              sharedPreferneces.setString('user_id','${convertJson['data']['user_id']}');
            });
            print(convertJson['data']['user_status']);
            if(convertJson['data']['user_status'] != "3") {
              Get.to(Profile(user: _selectUser,
                  user_status: convertJson['data']['user_status'].toString()));
              print('user status ${convertJson['data']['user_status']}');
            }else {
              Get.to(Review());
            }

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
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Register as',
                      style: GoogleFonts.alike(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 24),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Image.asset('assets/images/userservice.png'),
                  title: Text(
                    'Freelancer',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 22, color: ColorPalette.green),
                  ),
                  subtitle: const Text(
                    'If you are an individual Register as Freelancer.',
                    style: TextStyle(color: ColorPalette.bgGrey),
                  ),
                  trailing: Radio(
                    value: '2',
                    groupValue: _selectUser,
                    onChanged: (value) {
                      setState(() {
                        _selectUser = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  child: ListTile(
                    leading: Image.asset('assets/images/teamuser.png'),
                    title: Text(
                      'Vendor',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 22, color: ColorPalette.green),
                    ),
                    subtitle: const Text(
                      'If you are a vendor Business Owner with a team of people.',
                      style: TextStyle(color: ColorPalette.bgGrey),
                    ),
                    trailing: Radio(
                      value: '1',
                      groupValue: _selectUser,
                      onChanged: (value) {
                        setState(() {
                          _selectUser = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child:
                  isLoading ? CircularProgressIndicator():
                  ElevatedButton(
                    onPressed: () {
                      print('$_selectUser');
                      if(_selectUser == null){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Please select User Type'),
                        ));
                      }else{
                        register();
                      }
                      //Get.to(Profile(user: _selectUser));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text('Continue'),
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
