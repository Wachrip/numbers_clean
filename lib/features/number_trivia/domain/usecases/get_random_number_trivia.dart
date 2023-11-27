import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_clean/core/error/failure.dart';
import 'package:trivia_clean/core/usecases/usecase.dart';
import 'package:trivia_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, Params> {
  NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class Params extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
