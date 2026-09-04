---
name: agentic-ai-skills-registry
description: Master skill registry and frontmatter specs for AI coding agents operating across any codebase or domain.
version: 1.0.0
tags: [agentic-ai, skills, workflows, clean-architecture, flutter, monorepo]
---

# Skills & Guidelines for AI Coding Agents

---
name: agentic-flutter-delivery-workflow
description: Standard operating procedure for end-to-end task routing, implementation dependency order, and continuous validation.
version: 1.0.0
tags: [workflow, routing, dependency-order, validation]
---

## Skill: Agentic Flutter Delivery Workflow

### Route the Task
1. Identify the smallest concrete anchor: a failing test, file, symbol, or requested user-visible behavior.
2. Read the owning package barrel (`lib/<package>.dart`), its `pubspec.yaml`, and nearest test file.
3. Formulate one local hypothesis and one cheap check (e.g. running a focused test or analyzer) to validate/disprove it.
4. Trace cross-layer requests strictly along canonical flow:
   `UI -> Feature Signals/Controller -> Domain Use Case -> Domain Contract -> Infrastructure Adapter -> DTO/Row Mapper -> Domain Result -> Feature State -> UI`
5. Select the smallest package and layer that owns the change.

### Implement in Dependency Order
1. Domain contract and entity in `packages/domain` (or `<feature>_domain`).
2. Infrastructure adapter and DTO mapper in `packages/infrastructure` (or `<feature>_data`).
3. Feature orchestration and signal state in presentation layer.
4. Focused rendering widgets.
5. Register concrete dependencies in composition root (`apps/main_app`).
6. Update package barrel files only for intentional public API.

---
name: solid-clean-architecture
description: Enforces inward dependency flow, SOLID principles, and strict boundary shielding.
version: 1.0.0
tags: [architecture, solid, clean-architecture, boundaries]
---

## Skill: SOLID & Clean Architecture

### Dependency Direction
`apps/main_app` -> `packages/features` -> `packages/domain`
`apps/main_app` -> `packages/infrastructure` -> `packages/domain`

- `packages/features` depends on `packages/core_ui` and `packages/domain`.
- `packages/domain` is pure Dart with zero vendor or framework imports.

### SOLID Rules
1. **Single Responsibility**: Separate presentation, orchestration, domain policy, and infrastructure IO into dedicated layers.
2. **Open/Closed**: Extend capabilities by introducing new adapters behind domain interfaces instead of mutating callers.
3. **Liskov Substitution**: Adapters must strictly preserve error, nullability, and lifecycle contracts promised by domain interfaces.
4. **Interface Segregation**: Prefer small capability interfaces (`IAuthService`, `IUserRepository`).
5. **Dependency Inversion**: High-level code depends on domain abstractions; implementations are registered at composition root.

---
name: coding-standards-dry-public-apis
description: Coding standards, package shape rules, DRY principles, and naming conventions.
version: 1.0.0
tags: [coding-standards, naming, dry, public-api]
---

## Skill: Coding Standards, DRY & Public APIs

### Package Shape
- Implementation lives under `lib/src/`.
- Public API exposed through a single barrel file at `lib/<package_name>.dart`.
- Re-export only domain contracts, entities, states, and events; hide DTOs, generated files, and vendor internals.

### Naming & Design
- Interfaces begin with `I` (e.g., `IAuthService`).
- Implementations end with underlying technology name (e.g., `InMemoryAuthService`, `FirebaseAuthService`).
- Use explicit, descriptive variable names.

---
name: dependency-governance-lego-ownership
description: Single dependency ownership, shared wrapper rules, and dependency graph governance.
version: 1.0.0
tags: [dependencies, governance, lego-ownership, monorepo]
---

## Skill: Dependency Governance & LEGO Ownership

### Ownership Map
- UI & Design System: `packages/core_ui`
- Network (Dio): `packages/infrastructure/network` (or `packages/infrastructure`)
- Persistence (Drift): `packages/infrastructure/persistence` (or `packages/infrastructure`)
- Auth / Firebase: `packages/infrastructure/identity` (or `packages/infrastructure`)
- Composition Root & DI: `apps/main_app` using `kaisel`
- Feature State: `bloc_signals_flutter` in feature presentation packages

### Enforcement Rules
- No feature package may import infrastructure or vendor SDKs.
- No duplicate third-party vendor dependencies across packages without explicit documentation.

---
name: flutter-testing-quality-gates
description: Boundary testing discipline, quality gates, and definition of done for AI agents.
version: 1.0.0
tags: [testing, quality-gates, definition-of-done, unit-tests]
---

## Skill: Flutter Testing & Quality Gates

### Test by Boundary
- **Domain**: Pure unit tests for logic and entities without Flutter framework dependencies.
- **Infrastructure**: Adapter tests verifying DTO mapping, error translation, and IO behavior with fakes.
- **Features**: Signal state transitions and widget rendering tests with mocked domain contracts.
- **Composition Root**: Startup smoke tests verifying dependency injection graph resolution.

---
name: monorepo-data-flow-feature-boundaries
description: Canonical request paths, feature boundary isolation, and app shell routing responsibilities.
version: 1.0.0
tags: [data-flow, feature-boundaries, app-shell, routing]
---

## Skill: Modular Monorepo Data Flow & Feature Boundaries

### Feature Isolation
- Features must not import presentation or data packages of other features.
- Cross-feature transitions must route through app shell callbacks or shared domain contracts.
- App shell (`apps/main_app`) owns startup, flavor initialization, DI wiring, and top-level routing.

---
name: tech-stack-integration
description: Approved tech stack guidelines for state management, persistence, networking, and DI.
version: 1.0.0
tags: [tech-stack, signals, drift, dio, kaisel]
---

## Skill: Tech Stack Integration

### Stack Rules
- **State Management**: `bloc_signals_flutter` for UI state.
- **Dependency Injection**: `kaisel` at composition root (`apps/main_app`).
- **Database**: `drift` contained inside `packages/infrastructure`.
- **Networking**: `dio` contained inside `packages/infrastructure`.
