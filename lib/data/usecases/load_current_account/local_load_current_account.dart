import 'package:meta/meta.dart';

import 'package:curso_flutter/domain/entities/entities.dart';
import 'package:curso_flutter/domain/helpers/helpers.dart';
import 'package:curso_flutter/domain/usecases/usecases.dart';

import 'package:curso_flutter/data/cache/cache.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token);  
    } catch (error) {
      throw DomainError.unexpected;
    }    
  }
}