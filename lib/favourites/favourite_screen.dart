import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colors.dart';
import '../custom/recipe_widget.dart';
import 'favourite_provider_recipe_widget.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
        centerTitle: true,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border,
                size: 80, color: AppColors.grey),
            SizedBox(height: 16),
            Text(
              "No favorites yet",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: favorites.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return RecipeWidget(recipe: favorites[index]);
          },
        ),
      ),
    );
  }
}
