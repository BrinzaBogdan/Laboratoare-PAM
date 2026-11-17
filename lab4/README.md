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

```
lib/
├── core/                       rețea, erori, temă, widget-uri comune
└── features/learning/
    ├── domain/                 entități, contract repository, use cases
    ├── data/                   modele JSON, data source, repository impl
    └── presentation/           cubit-uri, ecrane, widget-uri reutilizabile
```

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
