import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/city_search_bar.dart';
import '../widgets/forecast_list.dart';
import '../widgets/weather_info_card.dart';

class WeatherMainPage extends StatelessWidget {
  const WeatherMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              CitySearchBar(),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      );
                    } else if (state is WeatherLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<WeatherBloc>().add(FetchByLocation());
                        },
                        color: AppColors.primary,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  WeatherInfoCard(weather: state.weather),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                            SliverFillRemaining(
                              hasScrollBody: true,
                              child: ForecastList(forecast: state.weather.forecast),
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<WeatherBloc>().add(FetchByLocation());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: Text('Please select a city', style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
