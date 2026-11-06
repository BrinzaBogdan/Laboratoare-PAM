// Laborator 3 - Varianta 3 (Brînză Bogdan)
// State management: flutter_bloc (Cubit). Date: assets/data/fitness.json (async).
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/workout_cubit.dart';
import 'core/app_colors.dart';
import 'data/fitness_repository.dart';
import 'screens/home_screen.dart';

void main() => runApp(const GymApp());

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mid City Gym Training',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (_) => WorkoutCubit(FitnessRepository())..load(),
        child: const HomeScreen(),
      ),
    );
  }
}
