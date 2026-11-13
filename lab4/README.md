# SportShop — Catalog de echipament sportiv

Aplicație Flutter care consumă un serviciu Web REST (DummyJSON) și este
organizată după principiile Clean Architecture.

## Funcționalități

- listarea produselor din categoria `sports-accessories`
- paginare automată la scroll
- căutare cu debounce
- sortare efectuată pe server (preț, rating, nume)
- ecran de detalii cu galerie de imagini, specificații și recenzii
- listă de favorite
- stări explicite de încărcare, eroare și listă goală
- pull-to-refresh

## Arhitectură

```
lib/
├── core/                       rețea, erori, temă, widget-uri comune
└── features/catalog/
    ├── domain/                 entități, contract repository, use cases
    ├── data/                   modele JSON, data source, repository impl
    └── presentation/           cubit-uri, ecrane, widget-uri reutilizabile
```

### Fluxul datelor

```
UI (CatalogPage)
  → CatalogCubit
    → GetProducts / SearchProducts (domain)
      → ProductRepository (abstract)
        → ProductRepositoryImpl (data)
          → ProductRemoteDataSource
            → ApiClient (HTTP)
              → DummyJSON
```

Răspunsul JSON este deserializat în `ProductModel`, convertit în entitatea
`Product` și trimis înapoi prin cubit către interfață. Erorile tehnice sunt
transformate în `Failure` înainte de a ajunge în stratul de prezentare.

## Serviciul Web

- `GET /products/category/sports-accessories?limit=&skip=&sortBy=&order=`
- `GET /products/search?q=&limit=`
- `GET /products/{id}`

## Rulare

```bash
flutter pub get
flutter run
```

## Testare

```bash
flutter test
```

Testele acoperă deserializarea JSON, logica din `CatalogCubit` și componenta
reutilizabilă `ProductCard`.
