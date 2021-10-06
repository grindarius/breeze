String? measurableDoneValidator(String? input) {
  if (input == null || input.isEmpty) {
    return 'This field cannot be blank';
  }

  try {
    int _numberSign = int.parse(input).sign;

    if (_numberSign == -1 || _numberSign == 0) {
      return 'Mark as done value cannot be less than 0';
    }
  } on Exception catch (_) {
    return 'This field only accepts number';
  }

  return null;
}
