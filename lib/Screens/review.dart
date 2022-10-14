import 'package:flutter/material.dart';

import '../Utils/constant.dart';

import 'dart:io';

import 'package:freelancing/Utils/constant.dart';
import 'package:image_picker/image_picker.dart';

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
              child: Image.asset(
                'assets/images/review.png',
                //height: MediaQuery.of(context).size.height / 1.7,
                fit: BoxFit.fill,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
