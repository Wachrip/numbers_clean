import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trivia_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_clean/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../../core/util/input_converter.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - must be positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetTriviaConcreteNumber getConcreteNumberTrivia;
  final GetTriviaRandomNumber getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {
      // TODO: implement event handler
      if (event is GetTriviaConcreteNumber) {
        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        inputEither.fold((failure) {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        }, (integer) {
          emit(Loading());
          final trivia = getConcreteNumberTrivia.numberString;
          // getConcreteNumberTrivia(Params(number: integer));
          /// CHECK
          emit(Loaded(trivia: NumberTrivia(text: trivia, number: integer)));
        });
      } else if (event is GetTriviaRandomNumber) {
        emit(Loading());
        final trivia = getRandomNumberTrivia;
        // getConcreteNumberTrivia(Params(number: integer));
        /// CHECK RANDOM
        emit(Loaded(trivia: NumberTrivia(text: 'Random', number: 1)));
      }
    });
  }
}
