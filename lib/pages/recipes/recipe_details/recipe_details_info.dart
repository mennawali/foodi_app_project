import 'package:flutter/material.dart';

import '../../../Api/api_manager.dart';
import '../../../model/ResponseRecipes.dart';


class RecipeDetailsInfo extends StatelessWidget {
  final Recipes recipe;
  const RecipeDetailsInfo({required this.recipe});

  Widget buildNutritionCard(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffE6EBF2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 24, color: Colors.black87),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            width: 90,
            height: 6,
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                recipe.title ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sofia',
                ),
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 15,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  "${recipe.readyInMinutes} min",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        FutureBuilder<Map<String, dynamic>>(
          future: ApiManager.getRecipeNutrition(recipe.id!.toInt()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            final nutrition = snapshot.data!;
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3.6,
              children: [
                buildNutritionCard(Icons.rice_bowl, nutrition['carbs'], "Carbs"),
                buildNutritionCard(Icons.egg_alt_outlined, nutrition['protein'], "Proteins"),
                buildNutritionCard(Icons.local_fire_department_rounded, nutrition['calories'], "Kcal"),
                buildNutritionCard(Icons.local_pizza_outlined, nutrition['fat'], "Fats"),
              ],
            );
          },
        ),
      ],
    );
  }
}