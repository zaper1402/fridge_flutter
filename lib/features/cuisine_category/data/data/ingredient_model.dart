class IngredientModel {
  final int? id;
  final String? name;
   num? quantity;
   String? unit;
   bool readyOnlyUnit;

  IngredientModel({
    this.id,
    this.name,
    this.quantity,
    this.unit,
    this.readyOnlyUnit = false
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['product_id'] as int?,
      quantity: json['quantity'],
      name: json['product_name'] as String?,
      unit: json['quantity_type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'quantity' : quantity,
      'product_name': name,
      'quantity_type' : unit
    };
  }
}