import 'package:test/test.dart';

import 'package:curso_flutter/presentation/protocols/protocols.dart';
import 'package:curso_flutter/validation/validators/required_field_validation.dart';

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
