import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/intro_screen.dart';
import 'package:get/get.dart';

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

    Timer(const Duration(seconds: 2), () => navigation());
    // startTimer();
  }

  void navigation() async {
    Get.off(() => const Intro_screens());
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
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText("SWAN",
                      textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .8,
                          color: Color.fromARGB(221, 44, 44, 44)),
                      speed: Duration(milliseconds: 200)),
                ],
              ),
              // child: Text(
              //   'SWAN',
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 40,
              //       letterSpacing: .8,
              //       color: Color.fromARGB(221, 44, 44, 44)),
              // ),
            )
          ],
        )),
      ),
    );
  }
}
