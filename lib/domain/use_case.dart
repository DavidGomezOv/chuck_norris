import 'package:chuck_norris/core/ApiResponse.dart';

mixin UseCase {

  Future<ApiResponse> getJokes();

}

mixin Repository {

  Future<ApiResponse> getJokes();

}

class UseCaseImpl implements UseCase {

  final Repository _repository;

  UseCaseImpl(this._repository);

  @override
  Future<ApiResponse> getJokes() => _repository.getJokes();
}