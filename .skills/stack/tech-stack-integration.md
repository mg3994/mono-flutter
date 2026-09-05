---
name: tech-stack-integration
description: Comprehensive breakdown of workspace third-party package roles, ownership boundaries, and usage guidelines.
version: 3.3.0
tags: [tech-stack, routing, kaisel, signals, drift, dio, firebase, linter, offline-first]
---

# Skill: Tech Stack Integration

Use the repository-approved stack consistently according to pub.dev package capabilities and workspace single-ownership rules.

## 1. Package Roles & Single Ownership Map

### Routing & Navigation
- **`kaisel`**: Declarative routing and navigation framework. Owned by `apps/main_app` (or navigation layer). Features emit navigation callbacks or callbacks to the shell, and `kaisel` handles app routes.
- **`kaisel_lint`**: Dev dependency linter enforcing routing, code organization, and workspace lint rules.

### Presentation & State Management
- **`bloc_signals_flutter`**: Reactive state management with Signals for UI presentation layers. Features expose state signals and user action methods to widgets.
- **`flutter_localizations`**, **`intl`**, **`cupertino_icons`**: Localization and presentation asset dependencies owned by `packages/core_ui` or presentation packages.

### Networking & Remote Data
- **`dio`**: Centralized HTTP client owned by `packages/infrastructure` (or `packages/infrastructure/network`). Features access remote data only via domain interfaces implemented by Dio adapters.

### Local Database & Persistence (Offline-First)
- **`drift`**, **`sqlite3`**, **`path_provider`**, **`path`**: Local relational database persistence and file system storage owned exclusively by `packages/infrastructure` (or `packages/infrastructure/persistence`). Drift acts as the local source-of-truth for offline-first caching strategies.
- **`drift_dev`**, **`build_runner`**: Dev dependencies for compiling Drift database tables and code generation.

### Identity & Firebase Integration
- **`firebase_core`**, **`firebase_auth`**: Cloud authentication and backend identity SDKs contained inside `packages/infrastructure` (or `packages/infrastructure/identity`).
- Initialization and Firebase options live strictly in `apps/main_app`. Features consume identity capabilities through domain interfaces like `IAuthService`.

## 2. Integration Rules

1. **Vendor Isolation**: No feature presentation package may directly import `dio`, `drift`, `sqlite3`, or `firebase_*`.
2. **Composition Root Wiring**: `apps/main_app` wires concrete adapters (e.g. `FirebaseAuthService`, `DriftUserRepository`) to pure domain contracts using standard Dart constructor injection.
3. **No Duplicate Owners**: Each vendor dependency is declared only in its designated owning package `pubspec.yaml`.
