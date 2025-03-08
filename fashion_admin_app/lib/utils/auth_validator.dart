class MyValidator {
  static String? displayNameValidator(String?displayName){
    if (displayName==null|| displayName.trim().isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length<3||displayName.length>20) {
      return 'Display name must be between 3 and 20 characters';
    }
    return null;
  }

  static String?emailValidator(String?value){
    if (value!.isEmpty) {
      return 'Please enter an email';
    }if (!RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$').hasMatch(value)) {
      return 'Please enter a valid mail';
    }
    return null;
  }
  static String?PasswordValidator(String?value){
    if (value!.isEmpty) {
      return 'Please enter a password';
    }if (value.length<6) {
      return 'Password must be at 6 characters long';
    }
    return null;
  }
  static String?repeatPasswordValidator({String?value,String? password}){
    if (value!=password) {
      return 'Passwords do not match';
    }
    return null;
  }
}