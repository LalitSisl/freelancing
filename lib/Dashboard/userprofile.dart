import 'package:flutter/material.dart';
import 'package:freelancing/Utils/constant.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVRopoqUaK_Umb0m-1H9kdtuuTglgIcGG-3g&usqp=CAU"),
                      fit: BoxFit.cover)),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(0.0, 2.5),
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Lalit Sharma",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "F00000004472",
              style: TextStyle(
                  fontSize: 15.0,
                  color: ColorPalette.themeBlue,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Delhi, India",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
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
                  commonWidget('My Docs', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('About Us', 'assets/images/about.png',
                      ColorPalette.white, 1.3),
                  commonWidget('Skills', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Business Details', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Assets & Tools', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Certificates', 'assets/images/about.png',
                      ColorPalette.white, 1.3),
                  commonWidget('Insurance', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                  commonWidget('Bank Details', 'assets/images/doc.png',
                      ColorPalette.white, 3.0),
                ],
              ),
            )
          ],
        ),
      )),
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
