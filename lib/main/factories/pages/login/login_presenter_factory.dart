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

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrsentAccount()
  );
}