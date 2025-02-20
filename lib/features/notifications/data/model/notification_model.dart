class NotificationModel {
  final DateTime? expiryDate;
  final String? productName;

  NotificationModel({
    this.expiryDate,
    this.productName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'])
          : null,
      productName: json['user_inventory__product__name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expiry_date': expiryDate?.toIso8601String(),
      'user_inventory__product__name': productName,
    };
  }
}
