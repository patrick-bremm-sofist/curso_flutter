import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

import '../../factories.dart';

// Change type error String for UIError
// LoginPresenter makeStreamLoginPresenter() {
//   return StreamLoginPresenter(
//     authentication: makeRemoteAuthentication(),
//     validation: makeLoginValidation()
//   );
// }

SignUpPresenter makeGetxSignUpPresenter() {
  return GetxSignUpPresenter(
    validation: makeSignUpValidation(),
    addAccount: makeRemoteAddAccount(),
    saveCurrentAccount: makeLocalSaveCurrsentAccount()
  );
}