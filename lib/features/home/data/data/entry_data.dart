class EntryData {
  final int entryId;
  final double quantity;
  final String? quantityType;

  EntryData({required this.entryId, required this.quantity, required this.quantityType});

  Map<String, dynamic> toJson() {
    return {
      'entry_id': entryId,
      'quantity': quantity,
      'quantity_type' : quantityType
    };
  }
}
