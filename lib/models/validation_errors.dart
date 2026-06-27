enum ValidationsField {
  username,
  password,
}

class ValidationErrors {
  final ValidationsField field;
  final String message;

  const ValidationErrors ({
    required this.field,
    required this.message,
});

  Map<String, String> toJson() {
    return {
      'field': field.name,
      'message': message,
    };
  }
}