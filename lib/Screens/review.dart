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
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: 190,
                    width: double.infinity,
                    child: Stack(children: [
                      Positioned(
                          top: -5,
                          left: 0,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/shade2.png'),
                          )),
                      Positioned(
                          bottom: -20,
                          left: -20,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/shade4.png'),
                          )),
                      Positioned(
                          bottom: -20,
                          right: 0,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset('assets/images/shade1.png'),
                          )),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: Stack(
                          children: [
                            Container(
                                height: 130,
                                width: 130,
                                child: pic != null
                                    ? Image.file(
                                        pic!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/user.png')),
                            Positioned(
                                bottom: -5,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () async {
                                    final ImagePicker _picker =
                                        ImagePicker(); //added type ImagePicker
                                    var image1 = await _picker.getImage(
                                        source: ImageSource.camera);

                                    if (image1 != null) {
                                      setState(() {
                                        pic = File(image1.path);
                                      });
                                    }
                                  },
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                  //padding: const EdgeInsets.all(2.0),
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 30,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$name $sr',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                         
                                  const SizedBox(height: 5),
                            
                             
                                  Row(
                                      children: [
                                        Text(profile,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                            
                              const SizedBox(height: 5),
                              Row(
                                children: const[
                                  Text('123456789',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children:[
                                  Text(addr,
                                      style:const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ])),
              ),
            ),
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
