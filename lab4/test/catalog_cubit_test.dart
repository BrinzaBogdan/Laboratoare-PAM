import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/core/error/failures.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/entities/product.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/entities/product_page.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/entities/product_sort.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/repositories/product_repository.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/usecases/get_products.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/usecases/search_products.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/presentation/cubit/catalog_state.dart';

Product _product(int id) {
  return Product(
    id: id,
    title: 'Produs $id',
    description: 'Descriere pentru produsul $id.',
    category: 'sports-accessories',
    price: 10 + id.toDouble(),
    discountPercentage: 0,
    rating: 4.5,
    stock: 5,
    tags: const [],
    images: const [],
    reviews: const [],
    thumbnail: '',
    sku: 'SKU-$id',
    warrantyInformation: '1 year',
    shippingInformation: 'Ships in 2 days',
    returnPolicy: '30 days',
    availabilityStatus: 'In Stock',
    minimumOrderQuantity: 1,
  );
}

class _FakeRepository implements ProductRepository {
  _FakeRepository({List<Product>? products, this.failure})
      : _products = products ?? List.generate(8, (index) => _product(index + 1));

  final List<Product> _products;
  final Failure? failure;

  int productCalls = 0;
  int searchCalls = 0;
  int lastSkip = 0;
  String? lastQuery;
  ProductSort? lastSort;

  @override
  Future<ProductPage> getProducts({
    required int limit,
    required int skip,
    required ProductSort sort,
  }) async {
    productCalls++;
    lastSkip = skip;
    lastSort = sort;
    if (failure != null) throw failure!;

    final items = _products.skip(skip).take(limit).toList();
    return ProductPage(
      items: items,
      total: _products.length,
      skip: skip,
      limit: limit,
    );
  }

  @override
  Future<ProductPage> searchProducts({
    required String query,
    required int limit,
  }) async {
    searchCalls++;
    lastQuery = query;
    if (failure != null) throw failure!;

    final items = _products
        .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ProductPage(items: items, total: items.length, skip: 0, limit: limit);
  }

  @override
  Future<Product> getProductById(int id) async {
    if (failure != null) throw failure!;
    return _products.firstWhere((product) => product.id == id);
  }
}

void main() {
  late _FakeRepository repository;
  late CatalogCubit cubit;

  setUp(() {
    repository = _FakeRepository();
    cubit = CatalogCubit(
      getProducts: GetProducts(repository),
      searchProducts: SearchProducts(repository),
    );
  });

  tearDown(() => cubit.close());

  test('încarcă prima pagină și expune starea de succes', () async {
    await cubit.load();

    expect(cubit.state.status, CatalogStatus.success);
    expect(cubit.state.products, hasLength(CatalogCubit.pageSize));
    expect(cubit.state.total, 8);
    expect(cubit.state.hasMore, isTrue);
    expect(repository.lastSkip, 0);
  });

  test('adaugă următoarea pagină la loadMore', () async {
    await cubit.load();
    await cubit.loadMore();

    expect(cubit.state.products, hasLength(8));
    expect(cubit.state.hasMore, isFalse);
    expect(repository.lastSkip, CatalogCubit.pageSize);
  });

  test('transformă eroarea de rețea în stare de failure', () async {
    final failingRepository = _FakeRepository(
      failure: const NetworkFailure('Fără conexiune la internet.'),
    );
    final failingCubit = CatalogCubit(
      getProducts: GetProducts(failingRepository),
      searchProducts: SearchProducts(failingRepository),
    );

    await failingCubit.load();

    expect(failingCubit.state.status, CatalogStatus.failure);
    expect(
      failingCubit.state.errorMessage,
      'Fără conexiune la internet.',
    );

    await failingCubit.close();
  });

  test('trimite opțiunea de sortare către repository', () async {
    await cubit.changeSort(ProductSort.priceDesc);

    expect(cubit.state.sort, ProductSort.priceDesc);
    expect(repository.lastSort, ProductSort.priceDesc);
  });

  test('caută cu debounce și transmite termenul către API', () async {
    cubit.onQueryChanged('produs 3');
    expect(cubit.state.query, 'produs 3');

    await Future<void>.delayed(const Duration(milliseconds: 600));

    expect(repository.searchCalls, 1);
    expect(repository.lastQuery, 'produs 3');
    expect(cubit.state.status, CatalogStatus.success);
    expect(cubit.state.products, hasLength(1));
  });

  test('adaugă și elimină un produs din favorite', () async {
    await cubit.load();
    final product = cubit.state.products.first;

    cubit.toggleFavorite(product);
    expect(cubit.state.isFavorite(product.id), isTrue);
    expect(cubit.state.favoriteCount, 1);

    cubit.toggleFavorite(product);
    expect(cubit.state.isFavorite(product.id), isFalse);
    expect(cubit.state.favoriteCount, 0);
  });
}
