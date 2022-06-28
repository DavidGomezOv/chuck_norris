import 'package:chuck_norris/core/ApiResponse.dart';
import 'package:chuck_norris/domain/use_case.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {

  final UseCase _useCase;

  Bloc(this._useCase);

  final _jokeListSubject = BehaviorSubject<ApiResponse>();
  Stream<ApiResponse> get jokesStream => _jokeListSubject.stream;

  Future<ApiResponse> getJokes() {
    return _useCase.getJokes().then((value) {
      _jokeListSubject.add(value);
      return value;
    }).catchError((error) {
      _jokeListSubject.add(ApiResponse(null, errorMsg: error.toString()));
    });
  }
}