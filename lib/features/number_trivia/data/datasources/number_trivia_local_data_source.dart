import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which gotten the last time user has internet connection
  ///
  /// Throws [ChaceException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheLastNumberTrivia(NumberTriviaModel triviaToCache);
}
