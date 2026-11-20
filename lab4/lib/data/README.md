# DATA — stratul de date (adapters)

**Regula de aur:** depinde doar de `domain/` (implementează contractul de acolo).
Nu importă `presentation/`.

| Subfolder | Ce conține | De ce e aici |
|---|---|---|
| `models/` | `LearningFeedModel`, `CourseDetailsModel` | `fromJson` / `toJson` — serializarea JSON |
| `datasources/` | `LearningRemoteDataSource` | singurul loc care apelează `ApiClient` (HTTP) |
| `repositories/` | `LearningRepositoryImpl` | implementează interfața din `domain/` |

**Fluxul conversiei:**
```
JSON (de la API)  →  Model (fromJson)  →  Entity (domain)  →  UseCase  →  UI
```

Eroarea tehnică (socket, timeout, HTTP, JSON invalid) este prinsă aici și
transformată într-un obiect `Failure`, deci nu ajunge crudă în interfață.
