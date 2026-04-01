import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';

// Events
abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchByLocation extends WeatherEvent {}

class FetchByCity extends WeatherEvent {
  final String city;
  FetchByCity(this.city);

  @override
  List<Object?> get props => [city];
}

// States
abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherLoaded extends WeatherState {
  final WeatherData weather;
  WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}
class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchByLocation>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherRepository.getWeatherByLocation();
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });

    on<FetchByCity>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherRepository.getWeatherByCity(event.city);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
