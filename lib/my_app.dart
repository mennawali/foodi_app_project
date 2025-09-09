
import 'package:flutter/material.dart';
import 'package:foodi_app_project/home_page.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomePage()
     );
  }

}