import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';



class BannerSection extends StatefulWidget {
  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  List<String> images = [
    'assets/images/banner1.svg',
    'assets/images/banner2.svg',
    'assets/images/banner3.svg'
  ];
  int pageIndex=0;
  @override
  Widget build(BuildContext context) {

    return Column(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.28,

            child: PageView.builder(
              onPageChanged: (value){
                setState(() {
                  pageIndex=value;
                });
              },
              itemBuilder: (context, index) {
                return SvgPicture.asset(images[index],
                );
              },
              itemCount: images.length,),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
                  (index) => AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(microseconds: 100),
                width: index == pageIndex ?30:10,
                height: 8,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index == pageIndex
                      ? AppColors.primaryColor
                      : AppColors.lightGray,
                ),
              ),
            ),
          ),



        ]

    );
  }
}
