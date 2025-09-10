import 'package:flutter/material.dart';
import 'package:foodi_app_project/pages/recipes/recipe_details.dart';

import '../../Api/api_manager.dart';
import '../../model/ResponseRecipes.dart';


class Recipes extends StatefulWidget {
  final String category;
  Recipes({required this.category});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseRecipes?>(
      future: ApiManager.getRecipes(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }
        else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text('Error: ${snapshot.error.toString()}'),

                ElevatedButton(
                  onPressed: () {
                    ApiManager.getRecipes(widget.category);
                    setState(() {});
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // لو مفيش data خالص
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              children: [
                const Text('No data received'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        final data = snapshot.data!;

        // لو فيه كود خطأ من الـ API
        if (data.code != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error Code: ${data.code}'),
                Text(data.message ?? 'Unknown error'),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getRecipes(widget.category);
                    setState(() {});
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        final recipes = data.recipes ?? [];

        return  ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, recipeIndex) {
            final recipe = recipes[recipeIndex];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailsPage(recipe: recipe),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (recipe.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          recipe.image?.trim().replaceAll(RegExp(r'\.$'), '') ?? '' ,// إزالة النقطة لو موجودة
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )

                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      },
    );

  }
}