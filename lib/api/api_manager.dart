import 'dart:convert';
import 'package:foodi_app_project/model/ResponseRecipes.dart';
import 'package:http/http.dart' as http;
class ApiManager{

  static Future<ResponseRecipes?> getRecipes(String category) async {
    //https://api.spoonacular.com/recipes/random?number=20&apiKey=aa1341df60d54b9dac3e343d9a90007d
    Uri url=Uri.https('api.spoonacular.com','/recipes/random',{
      'apiKey':'aa1341df60d54b9dac3e343d9a90007d',
      'number':'20',
      'include-tags': category,
    });
    var response= await http.get(url);
    try{
    var responseBode=response.body;
    var json=jsonDecode(responseBode);
    return ResponseRecipes.fromJson(json);
    }catch(e){
      throw e;
    }
}

  static Future<Map<String, dynamic>> getRecipeNutrition(int recipeId) async {
    Uri url = Uri.https('api.spoonacular.com', '/recipes/$recipeId/nutritionWidget.json', {
      'apiKey': 'aa1341df60d54b9dac3e343d9a90007d',
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }
}