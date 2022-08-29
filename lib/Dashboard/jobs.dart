import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/constant.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('JOBS',
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
                  Icons.search,
                  color: ColorPalette.blueTint1,
                ),
              ])
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/sisl.png'),
                        radius: 25,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        //width: 50,
                        child: Text(
                          'All',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.actor(color: ColorPalette.red),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  row('https://m.economictimes.com/thumb/msid-88979978,width-1200,height-900,resizemode-4,imgsize-65132/telecom.jpg',
                      'Telecom'),
                  const SizedBox(
                    width: 20,
                  ),
                  row('https://s30876.pcdn.co/wp-content/uploads/Career-Connections-1170x630.jpg.optimal.jpg',
                      'Network'),
                  const SizedBox(
                    width: 20,
                  ),
                  row('https://i.pcmag.com/imagery/reviews/04xTDKsqdUzgKvWI7MGVnG3-1..v1598204639.jpg',
                      'Computers and others')
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  // height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    children: [
                      Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CCTV Repair Service',
                                      style: GoogleFonts.alata(
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
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
                                      'T15600028793',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: ColorPalette.red,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.currency_rupee_sharp,
                                          size: 15,
                                          color: Colors.black87,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '2800',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: ColorPalette.themeBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '    -    0.0 KM away',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorPalette.textGrey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.timelapse,
                                          size: 15,
                                          color: Colors.black87,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '10.00 AM',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorPalette.themeBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '  ,  08 Aug',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorPalette.textGrey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: const Text(
                                            'Malviya Nagar Delhi',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: ColorPalette.textGrey,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                              Positioned(
                                  right: 0.0,
                                  top: 0.0,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/pdf.png',
                                        scale: 3.5,
                                      ),
                                      Text(
                                        'Download SOP',
                                        style: SWANWidget.extraSmallTextStyle,
                                      )
                                    ],
                                  )),
                              Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: ColorPalette.themeBlue,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: ColorPalette.themeBlue)),
                                    child: const Text('Accept',
                                        style: TextStyle(
                                            fontFamily: FFamily.avenir,
                                            color: ColorPalette.white,
                                            fontSize: FSize.dp16,
                                            fontWeight: FWeight.regular)),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  //height: 190,
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    children: [
                      Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TV Installation Service',
                                      style: GoogleFonts.alata(
                                          color: Colors.black,
                                          letterSpacing: 0.5,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
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
                                      'T15600022515',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: ColorPalette.red,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.currency_rupee_sharp,
                                          size: 15,
                                          color: Colors.black87,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '300',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: ColorPalette.themeBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '    -    0.0 KM away',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorPalette.textGrey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.timelapse,
                                          size: 15,
                                          color: Colors.black87,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '10.00 AM',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorPalette.themeBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '  , Today',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorPalette.textGrey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.8,
                                          child: const Text(
                                            '1750 Parvatiya Colony, Nit Faridabad Haryana Haryana',
                                            overflow: TextOverflow
                                                .ellipsis, // default is .clip
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: ColorPalette.textGrey,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                              Positioned(
                                  right: 0.0,
                                  top: 0.0,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/pdf.png',
                                        scale: 3.5,
                                      ),
                                      Text(
                                        'Download SOP',
                                        style: SWANWidget.extraSmallTextStyle,
                                      )
                                    ],
                                  )),
                              Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: ColorPalette.themeBlue,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: ColorPalette.themeBlue)),
                                    child: const Text('Accept',
                                        style: TextStyle(
                                            fontFamily: FFamily.avenir,
                                            color: ColorPalette.white,
                                            fontSize: FSize.dp16,
                                            fontWeight: FWeight.regular)),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }

  Widget row(String link, String text) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(link), fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          width: 70,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.actor(color: ColorPalette.textGrey),
          ),
        )
      ],
    );
  }
}
