import 'package:flutter/material.dart';
import 'package:foodi_app_project/custom/banner_section.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20,top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Good Morning',
            style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Sofia',
        ),),
            Text('Alena Sabyan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sofia',
              ),),
            Text('Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sofia',
              ),),
            BannerSection(),
          ],
        ),
      ),
    );

  }
}
