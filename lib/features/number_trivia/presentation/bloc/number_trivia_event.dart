part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {}

class GetTriviaConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaConcreteNumber(this.numberString);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetTriviaRandomNumber extends NumberTriviaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
