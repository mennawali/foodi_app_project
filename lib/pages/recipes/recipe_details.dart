import 'package:flutter/material.dart';
import 'package:foodi_app_project/Api/api_manager.dart';
import 'package:foodi_app_project/model/ResponseRecipes.dart'; // استبدليها بالملف اللي فيه كلاس Recipe

class RecipeDetailsPage extends StatelessWidget {
  final Recipes recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(recipe.title ?? "Recipe Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.image!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.extendedIngredients?.length ?? 0,
              itemBuilder: (context, index) {
                final ingredient = recipe.extendedIngredients![index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3), // مكان الشادو
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ingredient.image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ingredient.name ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${ingredient.amount} ${ingredient.unit}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),


            const SizedBox(height: 16),

            const Text(
              "Nutrition Facts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            FutureBuilder<Map<String, dynamic>>(
              future: ApiManager.getRecipeNutrition(recipe.id!.toInt()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                final nutrition = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Calories: ${nutrition['calories']}"),
                    Text("Carbs: ${nutrition['carbs']}"),
                    Text("Fat: ${nutrition['fat']}"),
                    Text("Protein: ${nutrition['protein']}"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}