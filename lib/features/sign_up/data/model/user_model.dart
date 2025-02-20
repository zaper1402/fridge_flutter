class UserModel {
  String email;
  String name;
  String phoneNumber;
  String dob;
  String password;

  UserModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.dob,
    required this.password,
  });

  // Factory constructor to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      dob: json['dob'],
      password: json['password'],
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'dob': DateTime.now().toString(),
      'password': password,
    };
  }
}
