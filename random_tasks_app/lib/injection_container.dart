import 'package:get_it/get_it.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/get_activity/data/data_source/remote_datasource.dart';
import 'package:test_app/features/get_activity/data/repositroy/activity_repository.dart';
import 'package:test_app/features/get_activity/presentation/bloc/activity_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
//bloc
  sl.registerFactory(() => ActivityBloc(activityRepository: sl()));
//repositories
  sl.registerLazySingleton(
      () => ActivityRepository(netInfo: sl(), dataSource: sl()));

//datasources
  sl.registerLazySingleton(() => RemoteDataSource(client: sl()));

//external
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NetworkInfo());
}
