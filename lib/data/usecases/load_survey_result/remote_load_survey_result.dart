import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../models/models.dart';
import '../../http/http.dart';

class RemoteLoadSurveyResult implements LoadSurveyResult {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSurveyResult({@required this.url, @required this.httpClient});

  Future<SurveyResultEntity> loadBySurvey({String surveyId}) async {
    try {
      final json = await httpClient.request(url: url, method: 'get');
    return RemoteSurveyResultModel.fromJson(json).toEntity();
    } on HttpError catch(error) {
      throw error == HttpError.forbidden 
        ? DomainError.accessDenied 
        : DomainError.unexpected;
    }
  }
}