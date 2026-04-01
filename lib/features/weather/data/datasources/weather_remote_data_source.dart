import 'package:test_weather/core/network/dio_client.dart';

abstract class WeatherRemoteDataSource {
  Future<Map<String, dynamic>> getWeatherData(double lat, double lon);
  Future<Map<String, dynamic>> getCityCoordinates(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioClient dioClient;

  WeatherRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, dynamic>> getWeatherData(double lat, double lon) async {
    final response = await dioClient.dio.get(
      'forecast',
      queryParameters: {
        'latitude': lat,
        'longitude': lon,
        'current_weather': true,
        'daily': 'weathercode,temperature_2m_max,temperature_2m_min,relative_humidity_2m_max',
        'timezone': 'auto',
        'forecast_days': 14,
      },
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getCityCoordinates(String city) async {
    final response = await dioClient.dio.get(
      'https://geocoding-api.open-meteo.com/v1/search',
      queryParameters: {
        'name': city,
        'count': 1,
        'language': 'en',
        'format': 'json',
      },
    );
    return response.data;
  }
}
