class EntryData {
  final int entryId;
  final double quantity;

  EntryData({required this.entryId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'entry_id': entryId,
      'quantity': quantity,
    };
  }
}
