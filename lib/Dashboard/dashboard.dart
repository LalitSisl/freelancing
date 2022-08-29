import 'package:flutter/material.dart';
import 'package:freelancing/Dashboard/jobs.dart';
import 'package:freelancing/Dashboard/more.dart';
import 'package:freelancing/Dashboard/userprofile.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: buildSpeedDial(),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dashboard',
                        style: GoogleFonts.adamina(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorPalette.themeBlue, width: 0.4)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/premium.png',
                            scale: 4.5,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Upgrade To Premium',
                              style: GoogleFonts.adamina(
                                  fontSize: 8, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorPalette.bgGrey, width: 0.4),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/sisl.png',
                      scale: 10,
                    ),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Click here to know all about your new ',
                              style: TextStyle(
                                fontSize: 14,
                              )),
                          TextSpan(
                            text: 'SISL SWAN',
                            style: GoogleFonts.adamina(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(text: ' App!'),
                        ],
                      ),
                    ),
                    trailing: Image.asset(
                      'assets/images/video.png',
                      scale: 2.5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 110,
                        width: MediaQuery.of(context).size.width / 1.4,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                ColorPalette.blueTint,
                                ColorPalette.blueTint1,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'NEWS',
                                  style: TextStyle(
                                      color: ColorPalette.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    'Get ratings and reviews from customers',
                                    style: GoogleFonts.adamina(),
                                    // style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w400),
                                  ),
                                )
                              ]),
                          Positioned(
                              right: 0.0,
                              bottom: 0.0,
                              child: Image.asset(
                                'assets/images/news.png',
                                scale: 1.3,
                              ))
                        ]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 110,
                        width: MediaQuery.of(context).size.width / 1.4,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                ColorPalette.chartOrange,
                                ColorPalette.chipBgBlue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ANNOUNCEMENT',
                                  style: TextStyle(
                                      color: ColorPalette.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'Get Your Digital profile created in seconds',
                                    style: GoogleFonts.adamina(),
                                    // style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w400),
                                  ),
                                )
                              ]),
                          Positioned(
                              right: 0.0,
                              bottom: 0.0,
                              child: Image.network(
                                'https://img.icons8.com/external-filled-outline-icons-maxicons/344/external-advertisement-borrow-book-filled-outline-filled-outline-icons-maxicons.png',
                                scale: 5,
                              ))
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 180,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: ColorPalette.bgGrey, width: 0.4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        48), // Image radiu
                                    child
                                        // child: pic != null
                                        //     ? Image.file(
                                        //         pic!,
                                        //         fit: BoxFit.cover,
                                        //       )
                                        : Image.asset(
                                      'assets/images/profile.png',
                                      scale: 0.5,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '[Department]',
                              style: GoogleFonts.alata(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              // style: TextStyle(
                              //     color: Colors.black,
                              //     letterSpacing: 0.5,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              '[Profile]',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // Row(
                            //   children: const [
                            //     Icon(
                            //       Icons.star,
                            //       size: 15,
                            //       color: Colors.black87,
                            //     ),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Text(
                            //       'New',
                            //       style: TextStyle(
                            //           fontSize: 14,
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '[Phone Number]',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorPalette.themeBlue,
                                      fontWeight: FontWeight.w400),
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
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '[Address]',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
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
              ],
            ),
          )),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 24.0),
      backgroundColor: ColorPalette.themeBlue,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Image.asset(
            'assets/images/jobs.png',
            scale: 1.5,
          ),
          //backgroundColor: Colors.green,
          onTap: () => Get.to(() => const Jobs()),
          label: 'Jobs',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
          child: const Icon(Icons.more, color: ColorPalette.themeBlue),
          //backgroundColor: Colors.green,
          onTap: () => Get.to(() => const More()),
          label: 'More',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
          child: Image.asset(
            'assets/images/profile.png',
            //scale: 1,
          ),
          //backgroundColor: Colors.green,
          onTap: () => Get.to(() => const UserProfile()),
          label: 'Profile',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          labelBackgroundColor: Colors.white,
        ),
        // SpeedDialChild(
        //   child: Image.asset(
        //     'assets/images/user1.png',
        //     scale: 1,
        //   ),
        //   //backgroundColor: Colors.green,
        //   onTap: () => Get.to(() => Customers()),
        //   label: 'Customers',
        //   labelStyle:
        //       const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        //   labelBackgroundColor: Colors.white,
        // ),
      ],
    );
  }
}
