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
  var name = '[Name]';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        body: Column(children: [
          SizedBox(
            height: 180,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(48), // Image radius
                                  child: pic != null
                                      ? Image.file(
                                          pic!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset('assets/images/user.png')),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -35,
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
                                  shape: const CircleBorder(),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // const Card(
                      //   elevation: 15,
                      //   child: Padding(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      //     child: Text(
                      //       '[Work title]',
                      //       style: TextStyle(fontSize: 12),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '[Profile]',
                          style: TextStyle(
                              fontSize: 12,
                              color: ColorPalette.bgGrey,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.phone,
                            size: 15,
                            color: ColorPalette.bgGrey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '[Phone number]',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: ColorPalette.bgGrey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 160,
                            child: Text(
                              '[Address]',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
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
