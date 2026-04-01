import 'package:get_it/get_it.dart';
import '../../features/weather/data/datasources/weather_remote_data_source.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';
import '../network/dio_client.dart';
import '../services/location_service.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // Data sources
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(dioClient: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: getIt(),
      locationService: getIt(),
    ),
  );

  // Blocs
  getIt.registerFactory(() => WeatherBloc(weatherRepository: getIt()));
}
