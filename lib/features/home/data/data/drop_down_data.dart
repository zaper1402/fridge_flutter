class DropDownData{
  final String id;
  final String name;
  
  DropDownData({required this.id, required this.name});

  factory DropDownData.fromJson(Map<String, dynamic> json) {
    return DropDownData(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}