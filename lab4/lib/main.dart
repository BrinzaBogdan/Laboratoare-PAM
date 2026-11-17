import 'package:flutter/material.dart';

import 'app.dart';
import 'core/network/api_client.dart';
import 'features/learning/data/datasources/learning_remote_data_source.dart';
import 'features/learning/data/repositories/learning_repository_impl.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = LearningRemoteDataSourceImpl(apiClient);
  final repository = LearningRepositoryImpl(remoteDataSource);

  runApp(App(repository: repository));
}
