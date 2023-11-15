import 'package:test/test.dart';

import 'package:curso_flutter/presentation/protocols/protocols.dart';

import 'package:curso_flutter/validation/validators/validators.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return error if values are not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value'};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return error if value is equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'any_value'};
    expect(sut.validate(formData), null);
  });
}