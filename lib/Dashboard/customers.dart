import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/constant.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: const Icon(Icons.add),
              backgroundColor: ColorPalette.themeBlue,
              onPressed: () {}),
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
                    Text('My Customers',
                        style: GoogleFonts.adamina(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    // Row(children: const [
                    //   Icon(
                    //     Icons.notifications,
                    //     color: ColorPalette.blueTint1,
                    //   ),
                    //   SizedBox(
                    //     width: 20,
                    //   ),
                    //   Icon(
                    //     Icons.search,
                    //     color: ColorPalette.blueTint1,
                    //   ),
                    // ])
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: ColorPalette.bgGrey,
                            ),
                            borderRadius:
                                BorderRadius.circular(10.0), //<-- SEE HERE
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '1',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                  Text(
                                    'Customers',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: ColorPalette.bgGrey,
                            ),
                            borderRadius:
                                BorderRadius.circular(10.0), //<-- SEE HERE
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '0',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                  Text(
                                    'Job Done',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: ColorPalette.bgGrey,
                            ),
                            borderRadius:
                                BorderRadius.circular(10.0), //<-- SEE HERE
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\u{20B9} 0',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                  Text(
                                    'Earned',
                                    style: SWANWidget.normalTextStyle,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: ColorPalette.bgGrey,
                        ),
                        borderRadius:
                            BorderRadius.circular(10.0), //<-- SEE HERE
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 12),
                        child: ListTile(
                          leading: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.blueTint,
                              ),
                              child: const Center(
                                  child: Text(
                                'la',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ))),
                          title: Text(
                            'Lalit Sharma(LS)',
                            style: GoogleFonts.alata(
                                color: Colors.black,
                                letterSpacing: 0.5,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            '54321',
                            style: SWANWidget.normalTextStyle,
                          ),
                          trailing: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.share,
                                  size: 18,
                                  color: ColorPalette.themeBlue,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: ColorPalette.themeBlue,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
