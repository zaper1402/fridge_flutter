class CuisineModel {
  final int? id;
  final String? name;
  String? imageUrl;

  CuisineModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}