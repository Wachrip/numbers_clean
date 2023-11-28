import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_clean/core/network/network_info.dart';
import 'package:trivia_clean/core/util/input_converter.dart';
import 'package:trivia_clean/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_clean/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_clean/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:trivia_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:trivia_clean/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia

  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetTriviaConcreteNumber(sl()));
  sl.registerLazySingleton(() => GetTriviaRandomNumber());

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDatasource: sl(), networkInfo: sl()));

  // Remote Data source
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  //Local Data source
  sl.registerLazySingleton<NumberTriviaLocalDatasource>(
      () => NumberTriviaLocalDatasourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
