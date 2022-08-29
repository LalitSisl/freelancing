import 'package:flutter/material.dart';
import 'package:freelancing/Utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MORE',
                    style: GoogleFonts.adamina(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                Row(children: const [
                  Icon(
                    Icons.notifications,
                    color: ColorPalette.blueTint1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: ColorPalette.blueTint1,
                  ),
                ])
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: (300 / 200),
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  commonWidget('Account Summary', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Terms & Policy', 'assets/images/about.png',
                      ColorPalette.white, 1.3),
                  commonWidget('My QR', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Saftey Guidelines', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('How it Workes', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget commonWidget(String text, String path, Color color, double scale) {
    return Card(
      elevation: 15,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              path,
              scale: scale,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  text,
                  style: SWANWidget.normalTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
