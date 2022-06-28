
import 'package:chuck_norris/core/ApiResponse.dart';
import 'package:chuck_norris/domain/use_case.dart';

mixin ApiSource {

  Future<ApiResponse> getJokes();

}


class RepositoryImpl implements Repository {

  final ApiSource _apiSource;

  RepositoryImpl(this._apiSource);

  @override
  Future<ApiResponse> getJokes() => _apiSource.getJokes();

}