import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final double currentTemp;
  final int weatherCode;
  final double minTemp;
  final double maxTemp;
  final double humidity;
  final String cityName;
  final List<DailyForecast> forecast;

  const WeatherData({
    required this.currentTemp,
    required this.weatherCode,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.cityName,
    required this.forecast,
  });

  @override
  List<Object?> get props => [
        currentTemp,
        weatherCode,
        minTemp,
        maxTemp,
        humidity,
        cityName,
        forecast,
      ];
}

class DailyForecast extends Equatable {
  final DateTime date;
  final int weatherCode;
  final double temperature;
  final double humidity;

  const DailyForecast({
    required this.date,
    required this.weatherCode,
    required this.temperature,
    required this.humidity,
  });

  @override
  List<Object?> get props => [date, weatherCode, temperature, humidity];
}
