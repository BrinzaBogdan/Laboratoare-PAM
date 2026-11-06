import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/fitness_models.dart';

/// Sursa datelor. Citeste fisierul JSON din assets, asincron.
class FitnessRepository {
  static const _assetPath = 'assets/data/fitness.json';

  Future<FitnessData> loadData() async {
    // Simuleaza o intarziere de retea, ca sa se vada starea Loading.
    await Future.delayed(const Duration(milliseconds: 800));

    final raw = await rootBundle.loadString(_assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return FitnessData.fromJson(json);
  }
}
