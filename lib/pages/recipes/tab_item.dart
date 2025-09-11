import 'package:flutter/material.dart';
import 'package:foodi_app_project/app_colors.dart';

class TabItem extends StatelessWidget {
  // Source source;
  String categoryName;
  bool isSelected ;
  TabItem({
    required this.categoryName,
    required this.isSelected
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(15,10,15,10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? AppColors.primaryColor: AppColors.lightGray,
      ),
      child: Text(categoryName,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600
        ),),
    );
  }
}