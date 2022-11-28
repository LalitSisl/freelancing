import 'package:flutter/material.dart';

import '../Utils/constant.dart';

import 'dart:io';

import 'package:freelancing/Utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  File? pic;
  var name = "[Name]";
  var profile = "[Profile]";
  var phone_no = "[Phone Number]";
  var addr = "[Address]";
  var sr = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        body: Column(children: [
          Expanded(
            child: Center(
                child: Lottie.network(
                    'https://assets4.lottiefiles.com/packages/lf20_vpu1ue0i.json')),
          ),
          const Text("Please Wait Your Profile is in Review",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontFamily: FFamily.avenir)),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
