import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodi_app_project/Api/api_manager.dart';
import 'package:foodi_app_project/model/ResponseRecipes.dart';

import '../../app_colors.dart';

// خدي بالك هنا لازم تكوني معرفة الـ ApiManager + AppColors + Recipes + ExtendedIngredients + AnalyzedInstructions قبل كده

class RecipeDeta extends StatefulWidget {
  final Recipes recipe;

  const RecipeDeta({super.key, required this.recipe});

  @override
  State<RecipeDeta> createState() => _RecipeDetaState();
}

class _RecipeDetaState extends State<RecipeDeta> {
  int selectedTab = 0; // 0 = Ingredients, 1 = Instructions

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
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      widget.recipe.image!.trim()
                          .replaceAll(RegExp(r'\.$'), ''),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // لو الصورة مش لاقياها أو رجعت 404
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
                  // باقي عناصر الـ Stack
                  Positioned(
                      top: 20,
                      left: 10,
                      child:Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close_rounded,
                            ),
                          ))),

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
                            // العنوان + الوقت
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.recipe.title ?? "",
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
                                      "${widget.recipe.readyInMinutes} min",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),


                            // Nutrition Facts
                            FutureBuilder<Map<String, dynamic>>(
                              future: ApiManager.getRecipeNutrition(
                                widget.recipe.id!.toInt(),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
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
                                    buildNutritionCard(
                                      Icons.rice_bowl,
                                      nutrition['carbs'],
                                      "Carbs",
                                    ),
                                    buildNutritionCard(
                                      Icons.egg_alt_outlined,
                                      nutrition['protein'],
                                      "Proteins",
                                    ),
                                    buildNutritionCard(
                                      Icons.local_fire_department_rounded,
                                      nutrition['calories'],
                                      "Kcal",
                                    ),
                                    buildNutritionCard(
                                      Icons.local_pizza_outlined,
                                      nutrition['fat'],
                                      "Fats",
                                    ),
                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 20),

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
                                      onTap: () =>
                                          setState(() => selectedTab = 0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedTab == 0
                                              ? Colors.black87
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Ingredients",
                                          style: TextStyle(
                                            color: selectedTab == 0
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          setState(() => selectedTab = 1),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedTab == 1
                                              ? Colors.black87
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Instructions",
                                          style: TextStyle(
                                            color: selectedTab == 1
                                                ? Colors.white
                                                : Colors.black87,
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

                            // محتوى التاب
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
                                      borderRadius: BorderRadius.circular(16),
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
                                        // دائرة بلون فاتح وخلفها الصورة
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE6EBF2), // لون الخلفية اللي حوالين الصورة
                                            shape: BoxShape.circle,
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

                                        // الاسم + الكمية
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
                              // Instructions (من الـ Recipe نفسه)
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