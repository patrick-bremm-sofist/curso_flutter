import 'package:test/test.dart';

import 'package:curso_flutter/presentation/protocols/protocols.dart';

import 'package:curso_flutter/validation/validators/validators.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

  test('Should return error if value is equal', () {
    expect(sut.validate('any_value'), null);
  });
}