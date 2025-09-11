import 'package:flutter/material.dart';
import 'package:foodi_app_project/pages/recipes/recipe_details/recipe_details_tab.dart';
import '../../../model/ResponseRecipes.dart';
import 'recipe_details_info.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipes recipe;
  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.9,
              child: Stack(
                children: [
                  widget.recipe.image != null
                      ? ClipRRect(
                    // borderRadius: const BorderRadius.only(Radius.circular(12)),
                    child: Image.network(
                      widget.recipe.image!.trim().replaceAll(RegExp(r'\.$'), ''),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: SvgPicture.asset(
                            'assets/images/recipe.svg',
                            height: 80,
                          ),
                        );
                      },
                    ),
                  )
                      : Center(
                    child: SvgPicture.asset(
                      'assets/images/recipe.svg',
                      height: 80,
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.close_rounded),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RecipeDetailsInfo(recipe: widget.recipe),
                            const SizedBox(height: 20),
                            RecipeDetailsTabs(recipe: widget.recipe),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}