import '../helpers.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse
}

extension DomainErrorExtension on UIError {
  String get description {
    switch(this) {
      case UIError.requiredField: return R.strings.msgRequiredField;
      case UIError.invalidField: return R.strings.msgInvalidField;
      case UIError.invalidCredentials: return R.strings.msgInvalidCredentials;
      case UIError.emailInUse: return R.strings.msgEmailInUse;
      default: return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}