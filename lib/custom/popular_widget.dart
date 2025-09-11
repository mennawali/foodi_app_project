import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodi_app_project/app_colors.dart';

import 'package:foodi_app_project/model/ResponseRecipes.dart';

import '../model/PopularResponse.dart';
class PopularWidget extends StatelessWidget{
Results popularRecipe;
PopularWidget({ required this.popularRecipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child:
                    Image.network(
                    popularRecipe.image??'',
                    height: 120,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),

                    onPressed: () {

                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150, // نفس عرض الصورة
                  child: Text(
                    popularRecipe.title ?? '',

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),


                const SizedBox(height: 4),
                // Text("⏱ ${popularRecipe.readyInMinutes}",
                //     style: const TextStyle(fontSize: 12)),
                // const SizedBox(height: 4),
                // Text("🥗 ${recipe["ingredients"]}",
                //     style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}