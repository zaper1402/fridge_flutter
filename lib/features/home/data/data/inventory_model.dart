import 'dart:convert';

class HomeInventory{
  final String? userName;
  final List<Inventory>? inventory;

  HomeInventory({this.userName, this.inventory});

  factory HomeInventory.fromJson(Map<String, dynamic> json) {
    return HomeInventory(
      userName: json['username'],
      inventory: (json['inventory'] as List?)?.map((e) => Inventory.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'inventory': inventory?.map((e) => e.toJson()).toList(),
    };
  }

}

class Inventory {
  final String? id;
  final String? name;
  String? image;
  final List<ProductItem>? products;

  Inventory({this.id, this.name, this.products, this.image});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    print("inventory name ${json['name']}");
    return Inventory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      products: (json['products'] as List?)?.map((e) => ProductItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductItem {
  final int? id;
  final Product? product;
  final List<Entry>? entries;
  final int? userId;

  ProductItem({this.id, this.product, this.entries, this.userId});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      entries: (json['entries'] as List?)?.map((e) => Entry.fromJson(e)).toList(),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'entries': entries?.map((e) => e.toJson()).toList(),
      'user_id': userId,
    };
  }
}

class Product {
  final int? id;
  final String? name;
  final String? brand;
  final String? category;
  final int? standardExpiryDays;
  final List<String>? allergyTags;
  final String? quantityType;
  final num? totalQuantity;

  Product({
    this.id,
    this.name,
    this.brand,
    this.category,
    this.standardExpiryDays,
    this.allergyTags,
    this.quantityType,
    this.totalQuantity
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      category: json['category'],
      standardExpiryDays: json['standard_expiry_days'],
      allergyTags: (json['allergy_tags'] as List?)?.map((e) => e.toString()).toList(),
      quantityType: json['quantity_type'],
      totalQuantity: json['total_qt']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'standard_expiry_days': standardExpiryDays,
      'allergy_tags': allergyTags,
      'quantity_type': quantityType,
      'total_qt' : totalQuantity
    };
  }
}

class Entry {
  final int? id;
   double? quantity;
  final DateTime? expiryDate;
  final String? creationDate;
  final int? userInventory;
   String? quantityType;

  Entry({this.id, this.quantity, this.expiryDate, this.creationDate, this.userInventory, this.quantityType});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      expiryDate: DateTime.parse(json['expiry_date']),
      creationDate: json['creation_date'],
      userInventory: json['user_inventory'],
      quantityType: json['quantity_type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'expiry_date': expiryDate,
      'creation_date': creationDate,
      'user_inventory': userInventory,
      'quantity_type' : quantityType
    };
  }
}

List<Inventory> parseInventoryList(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Inventory.fromJson(json)).toList();
}
