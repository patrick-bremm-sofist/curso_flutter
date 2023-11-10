import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/entities/entities.dart';

import '../../cache/cache.dart';

class LocalCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save (AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);  
    } catch (error) {
      throw DomainError.unexpected;
    }    
  }
}