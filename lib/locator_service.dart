import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_rick_and_morty/core/platform/network_info.dart';
import 'package:the_rick_and_morty/feature/data/datasources/person_local_data_source.dart';
import 'package:the_rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:the_rick_and_morty/feature/data/repositories/person_repository_impl.dart';
import 'package:the_rick_and_morty/feature/domain/repositories/person_repository.dart';
import 'package:the_rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:the_rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/search_bloc.dart/search.bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(personRepositoty: sl()));
  sl.registerLazySingleton(() => SearchPerson(personRepositoty: sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      remoteDataSorce: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl(client: http.Client()));

  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
