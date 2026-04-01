import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/weather_bloc.dart';

class CitySearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CitySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _controller,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: "Input City",
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.cardBackground,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<WeatherBloc>().add(FetchByCity(value));
            _controller.clear();
          }
        },
      ),
    );
  }
}
