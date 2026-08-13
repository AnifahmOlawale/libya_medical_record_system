/// Reusable form field validators for Libya Medical Record System.
///
/// USAGE:
/// ──────────────────────────────────────────────────
/// TextFormField(validator: FormValidators.email)
/// TextFormField(validator: FormValidators.password)
///
/// // Combine multiple checks on one field:
/// TextFormField(
///   validator: FormValidators.combine([
///     (v) => FormValidators.required(v, fieldName: 'Full name'),
///     FormValidators.minLength(3),
///   ]),
/// )
/// ──────────────────────────────────────────────────
abstract final class FormValidators {
  static final RegExp _emailPattern = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$',
  );

  /// Requires a non-empty value.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Requires a non-empty, correctly formatted email address.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailPattern.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Requires a non-empty password of at least [minLength] characters
  /// (defaults to 6).
  static String? password(String? value,) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';

    final errors = <String>[];

    // Check length
    if (value.length < 8) {
      errors.add('• At least 8 characters (${value.length}/8)');
    }

    // Check for uppercase
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('• At least one uppercase letter (A-Z)');
    }

    // Check for lowercase
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add('• At least one lowercase letter (a-z)');
    }

    // Check for digits
    if (!RegExp(r'\d').hasMatch(value)) {
      errors.add('• At least one number (0-9)');
    }

    // Check for special characters (optional but recommended)
    if (!RegExp(r'[!@#\$%\^&*()_+=\[\]{};:<>?/\\|~`-]').hasMatch(value)) {
      errors.add('• At least one special character (!@#\$%^&*)');
    }

    if (errors.isNotEmpty) {
      return 'Password requirements:\n${errors.join('\n')}';
    }

    return null;
  }

  //REQUIRED
  static String? requiredField(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
        return null;
  }

  //VALIDATE PHONE NUMBER
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    // Remove spaces and common punctuation but keep leading + if present
    final cleaned = value.trim().replaceAll(RegExp(r'[\s\-()]+'), '');
    // Use a correct regex: optional + followed by 7-15 digits
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Please enter a valid phone number (e.g. +2348012345678 or 08012345678)';
    }
    return null;
  }

  /// Requires the value to match [other] — e.g. confirm-password fields.
  /// Pass the other controller's current text as [other].
  static String? Function(String?) matches(
    String other, {
    String message = 'Values do not match',
  }) {
    return (value) => value == other ? null : message;
  }

  /// Enforces a minimum length. Combine with [required] if the field
  /// must also be non-empty.
  static String? Function(String?) minLength(int length) {
    return (value) {
      if (value != null && value.length < length) {
        return 'Must be at least $length characters';
      }
      return null;
    };
  }

  /// Runs multiple validators in order and returns the first error
  /// found, or null if all pass.
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
