


import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/header_widget.dart';
import 'package:freelancing/Authentication/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
          padding: const EdgeInsets.only(bottom: 80),
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
                        child: HeaderWidget(_headerHeight, false, Icons.login_rounded),
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
          ) 
        ],
      ),
    ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 200,),

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
                                          const SizedBox(height: 40,),
                                          FittedBox(
                                            child:   Row(
                                            
                                              children: const[
                                            
                                                  Icon(Icons.arrow_circle_right_outlined),
                                            
                                                  Text("Join a Team of 3500+ Members",style: TextStyle(fontSize: 20),)
                                            
                                              ],
                                            
                                            ),
                                          ),
                                                const SizedBox(height: 10,),
                                                FittedBox(
                                                  child:   Row(
                                                  
                                                    children:const [
                                                  
                                                        Icon(Icons.arrow_circle_right_outlined),
                                                  
                                                        Text("Partner with one of the Top IT Company",style: TextStyle(fontSize: 20))
                                                  
                                                    ],
                                                  
                                                  ),
                                                ),
                                        const SizedBox(height: 10,),
                                        FittedBox(
                                          child:   Row(
                                          
                                            children:const [
                                          
                                                Icon(Icons.arrow_circle_right_outlined),
                                          
                                                Text("Flexible Working Hours",style: TextStyle(fontSize: 20))
                                          
                                            ],
                                          
                                          ),
                                        ),
                                                          const SizedBox(height: 10,),
                                                          FittedBox(
                                                            child:   Row(
                                                            
                                                              children:const [
                                                            
                                                                  Icon(Icons.arrow_circle_right_outlined),
                                                            
                                                                  Text("Easy Processing and Faster Payment",style: TextStyle(fontSize: 20))
                                                            
                                                              ],
                                                            
                                                            ),
                                                          ),
                                          const SizedBox(height: 10,),
                                          // FittedBox(
                                          //   child:   Row(
                                            
                                          //     children:const [
                                            
                                          //         Icon(Icons.arrow_circle_right_outlined),
                                            
                                          //         Text("Work with High Tech Projects of PSU & Government Sectors",style: TextStyle(fontSize: 20))
                                            
                                          //     ],
                                            
                                          //   ),
                                          // )
                                                  ],
                                              ),
                                                )

                                              ),

            ],
          ),
        ),
        bottomSheet:  isLastPage?
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            
               style: TextButton.styleFrom(
            
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          primary: Colors.white,
          backgroundColor: Colors.lightBlue.shade400,
          minimumSize: const Size.fromHeight(70),
      ),
            onPressed: (){
              Get.to(const Login());

            }, child: const Text("Get Started")),
        ):
        
         Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: ()=> controller.jumpToPage(1)  , child: const Text('Skip')),
                              Center(
                                child:SmoothPageIndicator(
                                  effect: const WormEffect(
                                    
                                    activeDotColor: Colors.blueAccent
                                  ),
                                  controller: controller, count: 2) ,
                              ),
                              TextButton(
                            
                                
                                onPressed: ()=>controller.jumpToPage(2) , child: const Text('Next'))
                            ],
                          ),
                                  ),
                                ),
                              );
                            }
                          }
class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
    height: 10.0,
    width:10.0,
    // ignore: prefer_const_constructors
    decoration: BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),
  );
  }
}