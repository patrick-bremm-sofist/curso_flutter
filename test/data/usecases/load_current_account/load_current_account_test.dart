import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:curso_flutter/domain/helpers/helpers.dart';
import 'package:curso_flutter/domain/entities/entities.dart';

import 'package:curso_flutter/data/cache/cache.dart';
import 'package:curso_flutter/data/usecases/usecases.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

void main() {
  LocalLoadCurrentAccount sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  String token;

  PostExpectation mockFetchSecureCall() => 
    when(fetchSecureCacheStorage.fetchSecure(any));

  void mockFecthSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }

  void mockFecthSecureError() {
    mockFetchSecureCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFecthSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws', () async {
    mockFecthSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}