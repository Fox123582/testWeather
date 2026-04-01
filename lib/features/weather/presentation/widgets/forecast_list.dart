import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/weather_utils.dart';
import '../../domain/entities/weather.dart';

class ForecastList extends StatelessWidget {
  final List<DailyForecast> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(15),
        itemCount: forecast.length,
        separatorBuilder: (context, index) => const Divider(
          color: AppColors.textSecondary,
          thickness: 0.2,
        ),
        itemBuilder: (context, index) {
          final dayForecast = forecast[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    DateFormat('EEE').format(dayForecast.date),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  WeatherUtils.getSchemaIcon(dayForecast.weatherCode),
                  color: AppColors.secondary,
                  size: 24,
                ),
                Text(
                  '${dayForecast.temperature.round()}°',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.water_drop, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${dayForecast.humidity.round()}%',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
