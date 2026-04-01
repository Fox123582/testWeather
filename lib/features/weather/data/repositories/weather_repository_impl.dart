import 'package:geocoding/geocoding.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final LocationService locationService;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.locationService,
  });

  @override
  Future<WeatherData> getWeatherByLocation() async {
    final position = await locationService.getCurrentLocation();
    
    // Reverse geocoding to get city name
    String cityName = 'Unknown Location';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? placemarks.first.name ?? 'Unknown';
      }
    } catch (_) {}

    final data = await remoteDataSource.getWeatherData(
      position.latitude,
      position.longitude,
    );

    return _mapToEntity(data, cityName);
  }

  @override
  Future<WeatherData> getWeatherByCity(String city) async {
    final geo = await remoteDataSource.getCityCoordinates(city);
    final results = geo['results'] as List?;
    if (results == null || results.isEmpty) {
      throw Exception('City not found');
    }

    final result = results.first;
    final lat = result['latitude'] as double;
    final lon = result['longitude'] as double;
    final cityName = result['name'] as String;

    final data = await remoteDataSource.getWeatherData(lat, lon);
    return _mapToEntity(data, cityName);
  }

  WeatherData _mapToEntity(Map<String, dynamic> data, String cityName) {
    final current = data['current_weather'];
    final daily = data['daily'];

    final forecastTimes = daily['time'] as List;
    final forecastCodes = daily['weathercode'] as List;
    final forecastMaxes = daily['temperature_2m_max'] as List;
    final forecastMinMin = daily['temperature_2m_min'] as List;
    final forecastHumidity = daily['relative_humidity_2m_max'] as List;

    final List<DailyForecast> forecast = [];
    for (int i = 0; i < forecastTimes.length; i++) {
      forecast.add(DailyForecast(
        date: DateTime.parse(forecastTimes[i]),
        weatherCode: forecastCodes[i].toInt(),
        temperature: (forecastMaxes[i].toDouble() + forecastMinMin[i].toDouble()) / 2,
        humidity: forecastHumidity[i].toDouble(),
      ));
    }

    return WeatherData(
      currentTemp: current['temperature'].toDouble(),
      weatherCode: current['weathercode'].toInt(),
      minTemp: daily['temperature_2m_min'][0].toDouble(),
      maxTemp: daily['temperature_2m_max'][0].toDouble(),
      humidity: daily['relative_humidity_2m_max'][0].toDouble(),
      cityName: cityName,
      forecast: forecast,
    );
  }
}
