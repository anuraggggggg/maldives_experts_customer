import '../constants/app_strings.dart';

abstract final class Validators {
  static String? required(String? value) =>
      value == null || value.trim().isEmpty ? AppStrings.requiredField : null;

  static String? email(String? value) {
    if (required(value) case final error?) return error;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!)
        ? null
        : AppStrings.invalidEmail;
  }
}
