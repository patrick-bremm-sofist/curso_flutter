
import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveCurrentAccount makeLocalSaveCurrsentAccount() {
  return LocalSaveCurrentAccount(
    saveSecureCacheStorage: makeSecureStorageAdapter()
  );
}