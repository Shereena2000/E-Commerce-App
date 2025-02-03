String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  }
  if (int.tryParse(value) == null) {
    return "Enter a valid number";
  }
  return null;
}