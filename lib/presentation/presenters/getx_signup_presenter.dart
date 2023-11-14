import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
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
  var _passwordConfirmationError = Rx<UIError>(); // Observer Get
  var _isFormValid = false.obs; // Observer bool without default value

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSignUpPresenter({
    @required this.validation,
    @required this.addAccount,
    @required this.saveCurrentAccount
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  UIError _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
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
    final account = await addAccount.add(AddAccountParams(
      name: _name, 
      email: _email, 
      password: _password, 
      passwordConfirmation: _passwordConfirmation
    ));
    await saveCurrentAccount.save(account);
  }
}