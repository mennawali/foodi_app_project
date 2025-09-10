import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodi_app_project/custom/banner_section.dart';
import 'package:foodi_app_project/popular_recipe.dart';

import '../model/ResponseRecipes.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15,top: 35),
        child: SingleChildScrollView(
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
              SizedBox(height: 30,),
              Text('Popular Recipes' ,
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sofia',
              ),),
              SizedBox(height:250,child: PopularRecipe())


            ],
          ),
        ),
      ),
    );

  }
}
