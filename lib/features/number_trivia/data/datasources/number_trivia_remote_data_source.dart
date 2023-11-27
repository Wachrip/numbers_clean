import 'package:trivia_clean/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the https://numbersapi.com/{number} endpoint.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the https://numbersapi.com/random endpoint.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
