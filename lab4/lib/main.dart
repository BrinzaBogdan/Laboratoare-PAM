import 'package:flutter/material.dart';

import 'app.dart';
import 'core/network/api_client.dart';
import 'features/catalog/data/datasources/product_remote_data_source.dart';
import 'features/catalog/data/repositories/product_repository_impl.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = ProductRemoteDataSourceImpl(apiClient);
  final repository = ProductRepositoryImpl(remoteDataSource);

  runApp(App(repository: repository));
}
