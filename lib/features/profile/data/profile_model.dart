class ProfileModel {
  final String? name;
  final String? email;
  final DateTime? dateOfBirth;
  final String? phoneNumber;

  ProfileModel({
    this.name,
    this.email,
    this.dateOfBirth,
    this.phoneNumber,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'phone_number': phoneNumber,
    };
  }
}