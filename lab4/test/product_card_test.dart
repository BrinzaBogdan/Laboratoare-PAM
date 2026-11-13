import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/domain/entities/product.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/presentation/widgets/product_card.dart';

void main() {
  const product = Product(
    id: 137,
    title: 'American Football',
    description: 'A classic ball used in American football games.',
    category: 'sports-accessories',
    price: 19.99,
    discountPercentage: 0,
    rating: 4.91,
    stock: 53,
    tags: ['sports equipment'],
    images: [],
    reviews: [],
    thumbnail: 'https://cdn.dummyjson.com/thumb.png',
    sku: 'SPO-BRD-AME-137',
    warrantyInformation: '6 months warranty',
    shippingInformation: 'Ships in 1 month',
    returnPolicy: '7 days return policy',
    availabilityStatus: 'In Stock',
    minimumOrderQuantity: 1,
  );

  testWidgets('afișează datele produsului și reacționează la acțiuni',
      (tester) async {
    var favoriteTaps = 0;
    var cardTaps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              height: 320,
              child: ProductCard(
                product: product,
                isFavorite: false,
                onTap: () => cardTaps++,
                onToggleFavorite: () => favoriteTaps++,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('American Football'), findsOneWidget);
    expect(find.text('\$19.99'), findsOneWidget);
    expect(find.text('4.9'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    expect(favoriteTaps, 1);

    await tester.tap(find.text('American Football'));
    expect(cardTaps, 1);
  });
}
