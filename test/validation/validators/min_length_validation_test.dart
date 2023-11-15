import 'package:test/test.dart';

import 'package:curso_flutter/presentation/protocols/protocols.dart';

import 'package:curso_flutter/validation/protocols/field_validation.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({this.field, this.size});

  ValidationError validate(String value) {
    return ValidationError.invalidField;
  }
}

void main() {
  test('Should return error if value is empty', () {
    final sut = MinLengthValidation(field: 'any_field', size: 5);
    final error = sut.validate('');
    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final sut = MinLengthValidation(field: 'any_field', size: 5);
    final error = sut.validate(null);
    expect(error, ValidationError.invalidField);
  });
}