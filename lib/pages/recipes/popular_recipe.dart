import 'package:flutter/material.dart';
import 'package:foodi_app_project/api/api_manager.dart';
import 'package:foodi_app_project/custom/popular_widget.dart';

class PopularRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getPopularRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data==null) {
          return Center(child: Text("No popular recipes found"));
        }

        final popularRecipes = snapshot.data!;
        if (popularRecipes.code != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error Code: ${popularRecipes.code}'),
                Text(popularRecipes.message ?? 'Unknown error'),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }
        var popularRecipe=popularRecipes.results??[];
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: popularRecipe.length,
      separatorBuilder: (context, _) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        return PopularWidget(popularRecipe: popularRecipe[index],);
      },
    );
        },
      );

    }
  }