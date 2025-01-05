// ignore_for_file: avoid_print

class Validator {
  static String? validateRequired(String value, {String? string}) {
    String err = string ?? "Field";
    if (value.isEmpty) {
      return '$err field is required';
    } else {
      return "";
    }
  }

  static String? validateConfirmRequired(String value, String string) {
    if (value.isEmpty) {
      return "Please Re-Enter New Password";
    } else if (value != string) {
      return "Password must be same as above";
    } else {
      return "";
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!(regex.hasMatch(value))) {
      return "Invalid Email";
    } else {
      return "";
    }
  }

  static String? validatePassword(String value) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'(?=.*?[0-9])';

    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return "";
    }
  }

  static String? validateConfirmPassword(String value, String password) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'(?=.*?[0-9])';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "Please Re-Enter New Password";
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else if (value != password) {
      return "Password must be same as above";
    } else {
      return "";
    }
  }

  static String? validateName(String value, String string) {
    String pattern = '[a-zA-Z]';

    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return '$string is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid $string';
    } else {
      return "";
    }
  }

  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Mobile number is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }
}
