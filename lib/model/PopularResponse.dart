/// results : [{"id":945221,"title":"Watching What I Eat: Peanut Butter Banana Oat Breakfast Cookies with Carob / Chocolate Chips","image":"https://img.spoonacular.com/recipes/945221-312x231.jpg","imageType":"jpg"},{"id":715449,"title":"How to Make OREO Turkeys for Thanksgiving","image":"https://img.spoonacular.com/recipes/715449-312x231.jpg","imageType":"jpg"},{"id":776505,"title":"Sausage & Pepperoni Stromboli","image":"https://img.spoonacular.com/recipes/776505-312x231.jpg","imageType":"jpg"},{"id":716410,"title":"Cannoli Ice Cream w. Pistachios & Dark Chocolate","image":"https://img.spoonacular.com/recipes/716410-312x231.jpg","imageType":"jpg"},{"id":715467,"title":"Turkey Pot Pie","image":"https://img.spoonacular.com/recipes/715467-312x231.jpg","imageType":"jpg"},{"id":715419,"title":"Slow Cooker Spicy Hot Wings","image":"https://img.spoonacular.com/recipes/715419-312x231.jpg","imageType":"jpg"},{"id":997285,"title":"Shrimp and Asparagus Foil Packs with Garlic Lemon Butter Sauce","image":"https://img.spoonacular.com/recipes/997285-312x231.jpg","imageType":"jpg"},{"id":775585,"title":"Crockpot \"Refried\" Beans","image":"https://img.spoonacular.com/recipes/775585-312x231.jpg","imageType":"jpg"},{"id":716423,"title":"Grilled Zucchini with Goat Cheese and Balsamic-Honey Syrup","image":"https://img.spoonacular.com/recipes/716423-312x231.jpg","imageType":"jpg"},{"id":715421,"title":"Cheesy Chicken Enchilada Quinoa Casserole","image":"https://img.spoonacular.com/recipes/715421-312x231.jpg","imageType":"jpg"},{"id":715437,"title":"Homemade King Ranch Chicken Casserole","image":"https://img.spoonacular.com/recipes/715437-312x231.jpg","imageType":"jpg"},{"id":715394,"title":"Chicken Enchilada Casserole","image":"https://img.spoonacular.com/recipes/715394-312x231.jpg","imageType":"jpg"},{"id":715544,"title":"Brown Butter Twice Baked Sweet Potatoes","image":"https://img.spoonacular.com/recipes/715544-312x231.jpg","imageType":"jpg"},{"id":715562,"title":"Loaded Baked Potato Soup","image":"https://img.spoonacular.com/recipes/715562-312x231.jpg","imageType":"jpg"},{"id":715521,"title":"Turkey Avocado BLT Salad","image":"https://img.spoonacular.com/recipes/715521-312x231.jpg","imageType":"jpg"},{"id":716426,"title":"Cauliflower, Brown Rice, and Vegetable Fried Rice","image":"https://img.spoonacular.com/recipes/716426-312x231.jpg","imageType":"jpg"},{"id":715541,"title":"Pink Lemonade Crinkle Cookies","image":"https://img.spoonacular.com/recipes/715541-312x231.jpg","imageType":"jpg"},{"id":715391,"title":"Slow Cooker Chicken Taco Soup","image":"https://img.spoonacular.com/recipes/715391-312x231.jpg","imageType":"jpg"},{"id":715545,"title":"How to Make the Best Chicken Jambalaya","image":"https://img.spoonacular.com/recipes/715545-312x231.jpg","imageType":"jpg"},{"id":715569,"title":"Strawberry Cheesecake Chocolate Crepes","image":"https://img.spoonacular.com/recipes/715569-312x231.jpg","imageType":"jpg"}]
/// offset : 0
/// number : 20
/// totalResults : 5224

class PopularResponse {
  PopularResponse({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
    this.code,
    this.message});

  PopularResponse.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    offset = json['offset'];
    number = json['number'];
    totalResults = json['totalResults'];
    code = json['code'];
    message = json['message'];
  }
  List<Results>? results;
  num? offset;
  num? number;
  num? totalResults;
  int? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['number'] = number;
    map['totalResults'] = totalResults;
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

/// id : 945221
/// title : "Watching What I Eat: Peanut Butter Banana Oat Breakfast Cookies with Carob / Chocolate Chips"
/// image : "https://img.spoonacular.com/recipes/945221-312x231.jpg"
/// imageType : "jpg"

class Results {
  Results({
    this.id,
    this.title,
    this.image,
    this.imageType,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
  }
  num? id;
  String? title;
  String? image;
  String? imageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['imageType'] = imageType;
    return map;
  }

}