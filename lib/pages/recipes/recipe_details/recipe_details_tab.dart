import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../model/ResponseRecipes.dart';

class RecipeDetailsTabs extends StatefulWidget {
  final Recipes recipe;
  const RecipeDetailsTabs({required this.recipe});

  @override
  State<RecipeDetailsTabs> createState() => _RecipeDetailsTabsState();
}

class _RecipeDetailsTabsState extends State<RecipeDetailsTabs> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Switcher
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == 0 ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Ingredients",
                      style: TextStyle(
                        color: selectedTab == 0 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Instructions",
                      style: TextStyle(
                        color: selectedTab == 1 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        if (selectedTab == 0) ...[
          Text(
            "${widget.recipe.extendedIngredients?.length ?? 0} Items",
            style: const TextStyle(color: Colors.grey),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.recipe.extendedIngredients?.length ?? 0,
            itemBuilder: (context, index) {
              final ingredient = widget.recipe.extendedIngredients![index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color(0xffE6EBF2), // لون الخلفية اللي حوالين الصورة
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ingredient.image != null
                          ? ClipOval(
                        child: Image.network(
                          "https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(
                        Icons.fastfood,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(width: 16),
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
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )

        ]
        else ...[
          if (widget.recipe.analyzedInstructions != null &&
              widget
                  .recipe
                  .analyzedInstructions!
                  .isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.recipe.analyzedInstructions!
                  .expand((analyzed) {
                return analyzed.steps!.map(
                      (step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // عشان الخطوات الطويلة تبدأ من فوق
                      children: [
                        Text(
                          "Step ${step.number}: ",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sofia',
                          ),
                        ),
                        const SizedBox(width: 6),
                        // هنا بقى Expanded علشان النص يلف
                        Expanded(
                          child: Text(
                            step.step ?? "",
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
                  .toList(),
            )

          else if (widget.recipe.instructions != null &&
              widget.recipe.instructions!.isNotEmpty)
            Text(
              widget.recipe.instructions!,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            )
          else
            const Text("No instructions available."),
        ],
      ],
    );
  }
}