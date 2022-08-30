import 'package:flutter/material.dart';

import '../Profile/profile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/constant.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ignore: prefer_typing_uninitialized_variables
  var _selectUser;
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
                    value: '0',
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
                  padding: const EdgeInsets.only(left: 10, right: 13),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('This feature coming soon')),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/images/teamuser.png'),
                      title: Text(
                        'Vendor',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 22, color: ColorPalette.bgGrey),
                      ),
                      subtitle: const Text(
                        'If you are a vendor Business Owner with a team of people.',
                        style: TextStyle(color: ColorPalette.bgGrey),
                      ),
                      trailing: const Icon(
                        Icons.radio_button_off_outlined,
                        size: 21,
                      ),
                      // trailing: Radio(
                      //   value: '1',
                      //   groupValue: _selectUser,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       //_selectUser = value!;
                      //     });
                      //   },
                      // ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const Profile());
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
