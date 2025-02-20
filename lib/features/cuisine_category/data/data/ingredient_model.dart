class IngredientModel {
  final int? id;
  final String? name;
   int? quantity;
   String? unit;

  IngredientModel({
    this.id,
    this.name,
    this.quantity,
    this.unit
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['product_id'] as int?,
      quantity: json['qt'] as int?,
      name: json['product_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'qt' : quantity,
      'product_name': name,
    };
  }
}