import 'package:flutter/material.dart';

class WeatherUtils {
  static IconData getSchemaIcon(int code) {
    if (code == 0) return Icons.wb_sunny_rounded;
    if (code >= 1 && code <= 3) return Icons.wb_cloudy_rounded;
    if (code == 45 || code == 48) return Icons.foggy;
    if (code >= 51 && code <= 55) return Icons.umbrella_rounded;
    if (code >= 61 && code <= 65) return Icons.beach_access_rounded;
    if (code >= 71 && code <= 75) return Icons.ac_unit_rounded;
    if (code >= 80 && code <= 82) return Icons.thunderstorm_rounded;
    if (code >= 95 && code <= 99) return Icons.thunderstorm_rounded;
    return Icons.cloud_queue_rounded;
  }

  static String getSchemaDescription(int code) {
    if (code == 0) return 'Clear sky';
    if (code >= 1 && code <= 3) return 'Partly cloudy';
    if (code == 45 || code == 48) return 'Fog';
    if (code >= 51 && code <= 55) return 'Drizzle';
    if (code >= 61 && code <= 65) return 'Rain';
    if (code >= 71 && code <= 75) return 'Snow fall';
    if (code >= 80 && code <= 82) return 'Rain showers';
    return 'Overcast';
  }
}
