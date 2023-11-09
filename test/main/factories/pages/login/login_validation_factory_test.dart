import 'package:test/test.dart';

import 'package:curso_flutter/validation/validators/validators.dart';
import 'package:curso_flutter/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);
  });
}