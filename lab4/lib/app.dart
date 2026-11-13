import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/catalog/domain/repositories/product_repository.dart';
import 'features/catalog/domain/usecases/get_product_detail.dart';
import 'features/catalog/domain/usecases/get_products.dart';
import 'features/catalog/domain/usecases/search_products.dart';
import 'features/catalog/presentation/cubit/catalog_cubit.dart';
import 'features/catalog/presentation/pages/catalog_page.dart';

/// Rădăcina aplicației.
///
/// Aici se face injecția de dependențe: repository-ul vine din `main`, iar
/// cazurile de utilizare sunt construite o singură dată și oferite cubitului.
class App extends StatelessWidget {
  const App({super.key, required this.repository});

  final ProductRepository repository;

  @override
  Widget build(BuildContext context) {
    final getProducts = GetProducts(repository);
    final searchProducts = SearchProducts(repository);
    final getProductDetail = GetProductDetail(repository);

    return BlocProvider(
      create: (_) => CatalogCubit(
        getProducts: getProducts,
        searchProducts: searchProducts,
      )..load(),
      child: MaterialApp(
        title: 'SportShop',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: CatalogPage(getProductDetail: getProductDetail),
      ),
    );
  }
}
