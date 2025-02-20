extension StringDataValidation on String? {

  bool hasData() {
    return this != null && this?.trim().isNotEmpty == true;
  }
}