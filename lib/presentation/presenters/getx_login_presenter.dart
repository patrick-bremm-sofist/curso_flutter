import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;
  var _emailError = Rx<UIError>(); // Observer Get
  var _passwordError = Rx<UIError>(); // Observer
  var _mainError = Rx<UIError>(); // Observer
  var _navigateToStream = RxString(); // Observer
  var _isFormValid = false.obs; // Observer bool without default value
  var _isLoading = false.obs; // Observer bool without default value

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get mainErrorStream => _mainError.stream;
  Stream<String> get navigateToStream => _navigateToStream.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({
    @required this.validation, 
    @required this.authentication,
    @required this.saveCurrentAccount
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField: return UIError.invalidField;
      case ValidationError.requiredField: return UIError.requiredField;
      default: return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null
    && _passwordError.value == null
    && _email != null
    && _password != null;
  }

  Future<void> auth() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final account = await authentication.auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(account);
      _navigateToStream.value = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials: _mainError.value = UIError.invalidCredentials; break;
        default: _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  void goToSignUp() {
    _navigateToStream.value = '/signup';
  }

  void dispose() {}
}