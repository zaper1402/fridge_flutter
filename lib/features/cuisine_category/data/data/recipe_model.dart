class RecipeModel {
  final int? id;
  final String? name;
  final String? subtitle;
  final String? recipeTime;
  bool? isFav;
  final String? recipeChoice;
  final String? mealTypeChoice;
  final String? categoryName;
  final int? category;
  final String? imageUrl;

  RecipeModel({
    this.id,
    this.name,
    this.subtitle,
    this.recipeTime,
    this.isFav,
    this.recipeChoice,
    this.mealTypeChoice,
    this.categoryName,
    this.category,
    this.imageUrl,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      subtitle: json['subtitle'] as String?,
      recipeTime: json['recipe_time'] as String?,
      isFav: json['is_fav'] as bool?,
      recipeChoice: json['recipe_choice'] as String?,
      mealTypeChoice: json['meal_type_choice'] as String?,
      categoryName: json['category_name'] as String?,
      category: json['category'] as int?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'recipe_time': recipeTime,
      'is_fav': isFav,
      'recipe_choice': recipeChoice,
      'meal_type_choice': mealTypeChoice,
      'category_name': categoryName,
      'category': category,
      'image_url': imageUrl,
    };
  }
}
