
class Validation {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return "Name can't be less than 3 character";
    }
    return null;
  }
  static String? validateCompany(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company name is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Improved regex
    const pattern = r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static bool isValidBangladeshiPhone(String phone) {
    final pattern = RegExp(r'^(?:\+88)?01[3-9]\d{8}$');
    return pattern.hasMatch(phone);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone is required';
    }
    if (!isValidBangladeshiPhone(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

   static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // At least one uppercase, one lowercase, one number, one special char
    const pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, number, and special character';
    }
    return null;
  }
}
