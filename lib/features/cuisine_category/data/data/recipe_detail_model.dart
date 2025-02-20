class RecipeDetailModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? subtitle;
  final String? recipeTime;
   bool? isFav;
  final String? recipeChoice;
  final String? mealTypeChoice;
  final String? categoryName;
  final int? category;
  final String? details;
  final List<Ingredient>? ingredients;
  final List<String>? steps;

  RecipeDetailModel({
    this.id,
    this.name,
    this.imageUrl,
    this.subtitle,
    this.recipeTime,
    this.isFav,
    this.recipeChoice,
    this.mealTypeChoice,
    this.categoryName,
    this.category,
    this.details,
    this.ingredients,
    this.steps,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      subtitle: json['subtitle'] as String?,
      recipeTime: json['recipe_time'] as String?,
      isFav: json['is_fav'] as bool?,
      recipeChoice: json['recipe_choice'] as String?,
      mealTypeChoice: json['meal_type_choice'] as String?,
      categoryName: json['category_name'] as String?,
      category: json['category'] as int?,
      details: json['details'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'recipe_time': recipeTime,
      "image_url" : imageUrl,
      'is_fav': isFav,
      'recipe_choice': recipeChoice,
      'meal_type_choice': mealTypeChoice,
      'category_name': categoryName,
      'category': category,
      'details': details,
      'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      'steps': steps,
    };
  }
}

class Ingredient {
  final int? id;
  final String? name;
  final String? quantity;

  Ingredient({
    this.id,
    this.name,
    this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as int?,
      name: json['name'] as String?,
      quantity: json['quantity'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
