import '../../../main/factories/factories.dart';
import '../../decorators/decorators.dart';

import '../../../data/http/http.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
  decoratee: makeHttpAdapter(),
  fetchSecureCacheStorage: makeLocalStorageAdapter()
);