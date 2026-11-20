# PRESENTATION — stratul de interfață (UI)

**Regula de aur:** depinde de `domain/` (apelează use case-urile).
Nu importă `data/` — nu știe cum se face cererea HTTP sau cum arată JSON-ul.

| Subfolder | Ce conține | De ce e aici |
|---|---|---|
| `cubit/` | `FeedCubit`, `CourseDetailsCubit` + stările lor | ține starea și traduce evenimentele UI în apeluri de use case |
| `pages/` | `FeedPage`, `CourseDetailsPage` | ecranele aplicației |
| `widgets/` | `GreetingHeader`, `LearnedTodayCard`, `LessonTile`, … | componente reutilizabile, independente de ecran |

**Fluxul:** `UI → Cubit → UseCase → Repository → API → ... → Cubit → UI`

Cubit-ul emite stări explicite, iar pagina afișează:
`LoadingView` (încărcare), `ErrorView` (eroare + reîncercare),
`EmptyView` (conținut lipsă) sau conținutul propriu-zis.
