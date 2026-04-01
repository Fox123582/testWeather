import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/di/injection.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'core/constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<WeatherBloc>()..add(FetchByLocation()),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.outfitTextTheme(
            ThemeData.dark().textTheme,
          ),
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
