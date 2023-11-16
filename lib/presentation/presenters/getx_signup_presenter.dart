import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  var _emailError = Rx<UIError>(); // Observer Get
  var _nameError = Rx<UIError>(); // Observer Get
  var _passwordError = Rx<UIError>(); // Observer Get
  var _mainError = Rx<UIError>(); // Observer
  var _passwordConfirmationError = Rx<UIError>(); // Observer Get
  var _isFormValid = false.obs; // Observer bool without default value
  var _isLoading = false.obs; // Observer bool without default value
  var _navigateToStream = RxString(); // Observer

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get mainErrorStream => _mainError.stream;
  Stream<UIError> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<String> get navigateToStream => _navigateToStream.stream;

  GetxSignUpPresenter({
    @required this.validation,
    @required this.addAccount,
    @required this.saveCurrentAccount
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation,
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
    && _nameError.value == null
    && _passwordError.value == null
    && _passwordConfirmationError.value == null
    && _name != null
    && _email != null
    && _password != null
    && _passwordConfirmation != null;
  }

  Future<void> signUp() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final account = await addAccount.add(AddAccountParams(
        name: _name, 
        email: _email, 
        password: _password, 
        passwordConfirmation: _passwordConfirmation
      ));
      await saveCurrentAccount.save(account);
      _navigateToStream.value = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse: _mainError.value = UIError.emailInUse; break;
        default: _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  void goToLogin() {
    _navigateToStream.value = '/login';
  }
}