import 'dart:convert';

import 'package:trivia_clean/core/error/exceptions.dart';
import 'package:trivia_clean/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the https://numbersapi.com/{number} endpoint.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the https://numbersapi.com/random endpoint.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const url = 'http://numbersapi.com/';
const RANDOM = 'random';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      _getTriviaFromUrl(number.toString());

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      _getTriviaFromUrl(RANDOM);

  Future<NumberTriviaModel> _getTriviaFromUrl(String param) async {
    final response = await client.get('$url/$param' as Uri,
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
