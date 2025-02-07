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
String? validatePincode(String? value) {
  if (value == null || value.isEmpty) {
    return "Pincode cannot be empty";
  }
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return "Enter a valid 6-digit pincode";
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number cannot be empty";
  }
  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
    return "Enter a valid 10-digit phone number";
  }
  return null;
}
