




import 'package:flutter/material.dart';
import 'package:foodi_app_project/app_colors.dart';
import 'package:foodi_app_project/custom/banner_section.dart';
import 'package:foodi_app_project/pages/recipes/popular_recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_authentication/user_model.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15, top: 35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sofia',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.sunny,),
                  )
                ],
              ),
              Text(
                userName ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sofia',
                  color: Colors.black,
                ),
              ),
              Text(
                'Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sofia',
                ),
              ),
              BannerSection(),
              SizedBox(height: 30),
              Text(
                'Popular Recipes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sofia',
                ),
              ),
              SizedBox(height: 250, child: PopularRecipe()),
            ],
          ),
        ),
      ),
    );
  }
}
