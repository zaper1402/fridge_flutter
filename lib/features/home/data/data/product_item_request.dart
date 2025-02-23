import 'package:intl/intl.dart';

class ProductItemRequest {
  final int id;
  final String brand;
  final double quantity;
  final String quantityType;
  final int userId;
  // final String category;
  // final String? allergy;
  final DateTime? expiry;
  final String? subname;

  // Constructor
  ProductItemRequest({
    required this.id,
    required this.brand,
    required this.quantity,
    required this.quantityType,
    required this.userId,
    // required this.category,
    // this.allergy,
    this.expiry,
    this.subname
  });

  // Factory method to create a Product from a JSON map
  factory ProductItemRequest.fromJson(Map<String, dynamic> json) {
    return ProductItemRequest(
        id: json['id'],
        brand: json['brand'],
        quantity: json['quantity'],
        quantityType: json['quantity_type'],
        userId: json['user_id'],
        // category: json['category'],
        // allergy: json['allergy_tags'],
        expiry: json['expiry'],
        subname : json['subname']);
  }

  // Method to convert Product object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand.isEmpty ? "" : brand,
      'quantity': quantity,
      'quantity_type': quantityType,
      // "category": category,
      "expiry": expiry != null ? DateFormat("yyy-MM-dd").format(expiry ?? DateTime.now()) : null,
      // "allergy_tags": [allergy],
      "user_id": userId,
      "subname" : subname
    }..removeWhere((key, value) => value == null);
  }
}
