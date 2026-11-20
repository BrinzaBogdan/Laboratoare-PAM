# Learning App — feed și cursuri din API

Aplicație Flutter care consumă un serviciu Web REST și este organizată după
principiile Clean Architecture. Datele afișate (salut, progres, cursuri,
bannere, lecții) vin exclusiv din API, nu din asset-uri locale.

## Funcționalități

- feed principal cu antet, avatar și notificare cu indicator de mesaje noi
- card „Learned today” cu progresul zilei
- lista cursurilor din plan, cu progres pe fiecare curs
- banner „What do you want to learn today?” și banner „Meetup”
- ecran „Course Overview” cu hero, durată, număr de lecții și rating
- tab-uri Lessons / Description, cu stare goală pentru descrierea lipsă
- lecții finalizate, lecții blocate și acțiune de înscriere
- stări explicite de încărcare, eroare și conținut lipsă
- pull-to-refresh pe feed
- iconițe SVG livrate de API (Iconify), afișate prin `flutter_svg`

## Arhitectură

Straturile sunt direct sub `lib/` — se văd imediat când deschizi folderul:

```
lib/
├── main.dart                   → composition root (aici se leagă straturile)
├── app.dart                    → MaterialApp + BlocProviders
│
├── domain/   ← README.md       → STRATUL DE BUSINESS (nu depinde de nimic)
│   ├── entities/               → obiecte pure, fără JSON / Flutter
│   ├── repositories/           → contractul abstract LearningRepository
│   └── usecases/               → GetLearningFeed, GetCourseDetails
│
├── data/     ← README.md       → STRATUL DE DATE (depinde doar de domain)
│   ├── models/                 → fromJson / toJson (serializare)
│   ├── datasources/            → singurul loc cu cereri HTTP
│   └── repositories/           → LearningRepositoryImpl (eroare → Failure)
│
├── presentation/ ← README.md   → STRATUL UI (depinde doar de domain)
│   ├── cubit/                  → stare + evenimente
│   ├── pages/                  → ecranele aplicației
│   └── widgets/                → componente reutilizabile
│
└── core/     ← README.md       → infrastructură partajată
    ├── network/                → ApiClient (HTTP)
    ├── error/                  → Failure
    ├── constants/              → URL-urile API-ului
    ├── theme/                  → tema vizuală
    └── widgets/                → widget-uri comune
```

> Regula dependențelor: `presentation → domain ← data`.
> `domain` nu importă niciodată `data` sau `presentation` — verifici cu un singur
> `grep`: `grep -rn "data/\|presentation/" lib/domain` (nu returnează nimic).

### Ghid de demonstrație (în această ordine)

Deschide fișierele în editor, unul câte unul, și arată fluxul complet:

1. `lib/main.dart` — aici se construiesc obiectele și se injectează dependențele
2. `lib/domain/entities/learning_feed.dart` — entitate pură, fără JSON
3. `lib/domain/repositories/learning_repository.dart` — doar contractul (`abstract`)
4. `lib/domain/usecases/get_learning_feed.dart` — o acțiune = o clasă
5. `lib/data/models/learning_feed_model.dart` — `fromJson` (serializare)
6. `lib/data/datasources/learning_remote_data_source.dart` — cererea HTTP reală
7. `lib/data/repositories/learning_repository_impl.dart` — model → entitate, eroare → `Failure`
8. `lib/presentation/cubit/feed_cubit.dart` — primește datele, emite stare
9. `lib/presentation/pages/feed_page.dart` — `LoadingView` / `ErrorView` / conținut

Arată apoi `lib/domain/README.md`, `lib/data/README.md` și
`lib/presentation/README.md` — fiecare strat are propriul README cu regula lui.

### Fluxul datelor

```
UI (FeedPage / CourseDetailsPage)
  → FeedCubit / CourseDetailsCubit
    → GetLearningFeed / GetCourseDetails (domain)
      → LearningRepository (abstract)
        → LearningRepositoryImpl (data)
          → LearningRemoteDataSource
            → ApiClient (HTTP)
              → serviciul Web REST
```

Răspunsul JSON este deserializat în `LearningFeedModel` / `CourseDetailsModel`,
expus ca entități `LearningFeed` / `CourseDetails` și trimis înapoi prin cubit
către interfață. Erorile tehnice (socket, timeout, JSON invalid, cod HTTP) sunt
transformate în `Failure` înainte de a ajunge în stratul de prezentare, iar
ecranele afișează `LoadingView`, `ErrorView` sau `EmptyView`.

## Serviciul Web

- `GET /lab2026/v4/feed` — feed-ul de learning
- `GET /lab2026/v4/feed/details` — detaliile cursului

Host: `test-api-jlbn.onrender.com` (HTTPS).

## Rulare

```bash
flutter pub get
flutter run
```

## Testare

```bash
flutter test
```

Testele acoperă deserializarea și serializarea JSON, logica din
`FeedCubit` / `CourseDetailsCubit` și componenta reutilizabilă `LessonTile`.
