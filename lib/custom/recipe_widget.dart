import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodi_app_project/app_colors.dart';
import 'package:foodi_app_project/model/ResponseRecipes.dart';
import 'package:provider/provider.dart';

import '../favourites/favourite_provider_recipe_widget.dart';


class RecipeWidget extends StatelessWidget {
  final Recipes recipe;
  const RecipeWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoritesProvider.isFavorite(recipe);

    return SizedBox(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: recipe.image != null
                      ? ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      recipe.image
                          ?.trim()
                          .replaceAll(RegExp(r'\.$'), '') ??
                          '',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Center(
                      child: SvgPicture.asset('assets/images/recipe.svg')),
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
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: isFav ? AppColors.primaryColor: Colors.grey,
                      ),
                      onPressed: () {
                        favoritesProvider.toggleFavorite(recipe);
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
                    width: double.infinity,
                    child: Text(
                      recipe.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${recipe.readyInMinutes}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 28),
                      Row(
                        children: [
                          const Icon(
                            Icons.room_service_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 7),
                          Text("Serves: ${recipe.servings}",
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 15,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text("${recipe.aggregateLikes} likes",
                          style: const TextStyle(fontSize: 12)),
                    ],
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
