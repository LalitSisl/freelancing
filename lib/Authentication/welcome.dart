import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () => navigation());
    // startTimer();
  }

  void navigation() async {
    Get.off(() => const Login());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Row(
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
        )),
      ),
    );
  }
}
