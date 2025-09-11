import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodi_app_project/app_colors.dart';


import '../firebase_authentication/login.dart';



class SplachScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          backgroundColor:  AppColors.primaryColor,
          body: SafeArea(
              child:
              SingleChildScrollView(
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/images/top_image.svg",width:500,),
                    Padding(
                      padding: const EdgeInsets.only(top:200,left:80.0),
                      child: Stack(
                        children: [ SvgPicture.asset("assets/images/splach_background.svg"),
                          Column(children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/egg.svg"),
                                SizedBox(width:100),
                                SvgPicture.asset("assets/images/stek.svg"),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/beans.svg"),
                                SizedBox(width:100),
                                SvgPicture.asset("assets/images/orange.svg"),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/cheese.svg"),
                                SizedBox(width:100),
                                SvgPicture.asset("assets/images/meat.svg"),
                              ],
                            ),
                          ],)],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:550),
                            child: Text("Help your path to health ",
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sofia',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:580),
                            child: Text("goals with happiness",
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sofia',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:620),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal:180,vertical: 20),
                                backgroundColor:  Colors.black
                            ),
                            onPressed:() {
                              Navigator.pushReplacement( context, MaterialPageRoute(builder:  (context) => LoginScreen(),));
                            }, child: Text("Login",style: TextStyle(color: Colors.white),)),
                      ),
                    ),

                        
                        
                        
                  ],
                ),
              )
        
        
          ),
        
        
        ),

         );
     }

}