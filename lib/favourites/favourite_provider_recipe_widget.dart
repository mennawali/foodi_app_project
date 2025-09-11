import 'package:flutter/material.dart';
import 'package:foodi_app_project/model/ResponseRecipes.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Recipes> _favorites = [];

  List<Recipes> get favorites => _favorites;

  bool isFavorite(Recipes recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }

  void toggleFavorite(Recipes recipe) {
    final isExist = isFavorite(recipe);
    if (isExist) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
  }
}
