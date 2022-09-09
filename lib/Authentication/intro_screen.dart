
import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/header_widget.dart';
import 'package:freelancing/Authentication/login.dart';

import 'package:get/get.dart';

class Intro_screens extends StatefulWidget {
  const Intro_screens({Key? key}) : super(key: key);

  @override
  State<Intro_screens> createState() => _Intro_screensState();
}
class _Intro_screensState extends State<Intro_screens> {
   double _headerHeight = 250;
  final controller = PageController();
bool isLastPage = false;

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         
          child: PageView(
            controller: controller,
            onPageChanged: (index){
              setState(() => isLastPage = index == 1);
            },
            children: [
                Container(
                  // color: Colors.red,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    
                    children: [
                      Container(
                        height: _headerHeight,
                        child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
                      ),
                      const SizedBox(height: 100,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/images/sisl.png')),
                                const Text("SWAN",
                                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,letterSpacing: .8,color: Color.fromARGB(221, 44, 44, 44)),)

                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        RichText(
              text: const TextSpan(
                text: 'S',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: 'ervice', style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(text: ' on',style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(text: ' W'),
                  TextSpan(text: 'heels',style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(text: ' A'),
                  TextSpan(text: 'cross',style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(text: ' the',style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(text: ' N'),
                  TextSpan(text: 'ation',style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            )
            ],
          ) , 
                SizedBox(height: MediaQuery.of(context).size.height/4,),
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SizedBox(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/15,
            child: ElevatedButton(onPressed: ()=>controller.jumpToPage(2), child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                 Text("Next"),
                 SizedBox(width: 10,),
                Icon(Icons.arrow_forward)
              ],
            ),)),
         ],
       )   
        ],

      ),
      
    ),
           Container(
           child: SingleChildScrollView(
             child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
               children: [
 Container(
                          height: _headerHeight,
                          child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
                        ),
                        SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Container(

                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8,20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset('assets/images/sisl.png')),
                                    const Text("SWAN",
                                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,letterSpacing: .8,color: Color.fromARGB(221, 44, 44, 44)),)
                    ],
                  ),
               const  SizedBox(height: 20,),
                                  Row(
                       children: [
                      const    Text(
                      '\u2022',
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.55,

                      ),
                    ),
                                 const   SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      child:const Text("Join a Team of 3500+ Members.",style: TextStyle(fontSize:20,letterSpacing: 1,)),
                    ))

                       ]
                     ),
                          const   SizedBox(height: 10,),
                            Row(
                       children: [
                      const    Text(
                      '\u2022',
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.55,

                      ),
                    ),
                                 const   SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Container(
                      child:const Text("Partner with one of the Top IT Company",style: TextStyle(fontSize: 20,letterSpacing: 1,)),
                    ))

                       ]
                     ),
                          const   SizedBox(height: 10,),
                            Row(
                       children: [
                      const    Text(
                      '\u2022',
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.55,

                      ),
                    ),
                                 const   SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Container(
                      child:const Text("Flexible Working Hours.",style: TextStyle(fontSize: 20,letterSpacing: 1,)),
                    ))

                       ]
                     ),
                          const   SizedBox(height: 10,),
                            Row(
                       children: [
                      const    Text(
                      '\u2022',
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.55,

                      ),
                    ),
                                 const   SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Container(
                      child:const Text("Easy Processing and Faster Payment.",style: TextStyle(fontSize: 20,letterSpacing: 1,)),
                    ))

                       ]
                     ),
                  const   SizedBox(height: 10,),
                     Row(
                       children: [
                      const    Text(
                      '\u2022',
                      style: TextStyle(
                          fontSize: 25,
                          height: 1.55,

                      ),
                    ),
                                 const   SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Container(
                      child:const Text("Work with High Tech Projects of PSU & Government Sectors.",style: TextStyle(fontSize: 20,letterSpacing: 1,)),
                    ))

                       ]
                     ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
                  SizedBox(height: 20,),
              Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
             SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/15,
              child: ElevatedButton(onPressed: (){
                Get.to(const Login());
              }, child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                   Text("Let's Go"),
                   SizedBox(width: 10,),
                  Icon(Icons.arrow_forward)
                ],
              ),)),
         ],
       ),
                 SizedBox(height: 10,)

               ],

             ),
           ),
           
           )
            ],
          ),
        ),
      
        
      
                                ),
                              );
                            }
                          }
