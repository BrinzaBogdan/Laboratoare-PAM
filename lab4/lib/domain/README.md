# DOMAIN — stratul de business (centrul aplicației)

**Regula de aur:** acest strat nu depinde de nimic din afara lui.
Nu importă `data/`, `presentation/`, `core/` sau `package:flutter/`.
Nu știe nimic despre HTTP, JSON sau ecrane.

| Subfolder | Ce conține | De ce e aici |
|---|---|---|
| `entities/` | `LearningFeed`, `CourseDetails`, obiecte ale lecțiilor | obiecte pure, fără `fromJson`, fără widget-uri |
| `repositories/` | `LearningRepository` (abstract) | contractul: *ce* date trebuie obținute, nu *cum* |
| `usecases/` | `GetLearningFeed`, `GetCourseDetails` | o acțiune per clasă, apelată de prezentare |

**De ce e important la demo:** arată că logica aplicației rămâne aceeași dacă
înlocuiești API-ul cu o bază de date sau cu date locale. Nu se schimbă nimic aici.
