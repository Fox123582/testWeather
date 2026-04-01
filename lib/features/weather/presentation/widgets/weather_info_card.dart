import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../domain/entities/weather.dart';

class WeatherInfoCard extends StatelessWidget {
  final WeatherData weather;

  const WeatherInfoCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Icon(
          WeatherUtils.getSchemaIcon(weather.weatherCode),
          size: 100,
          color: AppColors.secondary,
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.currentTemp.round()}°',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),
        Text(
          WeatherUtils.getSchemaDescription(weather.weatherCode),
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDetailTile(Icons.arrow_upward, '${weather.maxTemp.round()}°'),
            const SizedBox(width: 20),
            _buildDetailTile(Icons.arrow_downward, '${weather.minTemp.round()}°'),
            const SizedBox(width: 20),
            _buildDetailTile(Icons.water_drop, '${weather.humidity.round()}%'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailTile(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
