import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<WeatherData> getWeatherByLocation();
  Future<WeatherData> getWeatherByCity(String city);
}
