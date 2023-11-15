import 'package:test/test.dart';

import 'package:curso_flutter/presentation/protocols/protocols.dart';
import 'package:curso_flutter/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': 'patrick.bremm@sofist.co'}), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate({'any_field': 'patrick.bremm'}), ValidationError.invalidField);
  });
}