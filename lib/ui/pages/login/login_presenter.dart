abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorSteam;

  void validateEmail(String email);
  void validatePassword(String password);
}
