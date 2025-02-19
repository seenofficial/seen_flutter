class FormValidator {
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName == null ? 'قم بادخال $fieldName' : 'هذا الحقل مطلوب';
    }
    return null;
  }

  static String? validateNumber(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName == null ? 'قم بادخال $fieldName' : 'هذا الحقل مطلوب';
    }

    if (double.tryParse(value) == null) {
      return fieldName != null ? 'يرجى إدخال رقم صحيح في $fieldName' : 'يرجى إدخال رقم صحيح';
    }

    return null;
  }

  static String? validatePositiveNumber(String? value, {String? fieldName}) {
    final numberError = validateNumber(value, fieldName: fieldName);
    if (numberError != null) {
      return numberError;
    }

    if (double.parse(value!) <= 0) {
      return fieldName != null ? 'يجب أن يكون $fieldName أكبر من صفر' : 'يجب أن يكون الرقم أكبر من صفر';
    }

    return null;
  }

  static String? validateWithinRange(String? value, {double? min, double? max, String? fieldName}) {
    final numberError = validateNumber(value, fieldName: fieldName);
    if (numberError != null) {
      return numberError;
    }

    double numValue = double.parse(value!);

    if (min != null && numValue < min) {
      return fieldName != null ? 'يجب أن يكون $fieldName أكبر من $min' : 'يجب أن يكون الرقم أكبر من $min';
    }

    if (max != null && numValue > max) {
      return fieldName != null ? 'يجب أن يكون $fieldName أقل من $max' : 'يجب أن يكون الرقم أقل من $max';
    }

    return null;
  }
}
