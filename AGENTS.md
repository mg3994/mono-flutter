# Skills & Guidelines for AI Coding Agents

## Core Operating Philosophy

This workspace operates as a modular, brick-based monorepo ("Baseplate"). AI coding agents working in this repository must operate with extreme discipline, strictly obeying clean architecture boundaries, SOLID principles, and continuous quality gates. Regardless of the feature or project scope, agents must execute tasks end-to-end using the standardized execution playbook below.

---

## AI Agent End-to-End Execution Playbook

When assigned any task—whether creating a new feature, refactoring an existing package, or fixing a bug—the AI agent must follow this 7-phase execution protocol:

### Phase 1: Task Routing & Scope Anchor
1. Identify the smallest concrete anchor: a failing test, file, symbol, or requested user-visible behavior.
2. Read the owning package barrel (`lib/<package>.dart`), its `pubspec.yaml`, and existing test files.
3. Formulate one local hypothesis and one cheap check (e.g. running a focused test or analyzer command) to validate or disprove it.
4. Trace cross-layer requests strictly along the canonical flow:
   `UI -> Feature Signals/Controller -> Domain Use Case -> Domain Contract -> Infrastructure Adapter -> DTO/Row Mapper -> Domain Result -> Feature State -> UI`
5. Select the smallest owning package and layer. Do not widen changes unnecessarily into adjacent packages.

### Phase 2: Domain Layer (Pure Business Logic)
1. Add or update pure Dart contracts (`interfaces`), entities, value objects, and failures in `packages/domain` (or `<feature>_domain`).
2. Ensure domain code has zero dependencies on Flutter, Dio, Drift, Firebase, or external vendor SDKs.
3. Write domain unit tests covering pure policy, validation rules, and success/failure results using standard `test`.

### Phase 3: Infrastructure Layer (Adapters & IO)
1. Implement concrete adapters in `packages/infrastructure` (or `<feature>_data`) behind domain interfaces.
2. Map external DTOs, API responses, database rows, or SDK payloads explicitly to pure domain entities inside the adapter boundary.
3. Catch all infrastructure errors (network exceptions, database failures, SDK errors) and translate them into stable domain failure types.
4. Keep vendor types (Dio exceptions, Drift rows, Firebase user credentials) hidden inside infrastructure. Never leak vendor types to domain or UI.
5. Write infrastructure tests using deterministic fakes or test doubles covering happy paths, retries, and failure translations.

### Phase 4: Feature Presentation & Orchestration
1. Build presentation state management using `bloc_signals_flutter` in feature packages.
2. Keep state objects immutable and handle loading, empty, success, and error states explicitly.
3. Keep Flutter widgets focused strictly on rendering UI and dispatching user events. Widgets must not invoke data sources, repositories, or network clients directly.
4. Route cross-feature interactions through app shell callbacks or shared domain contracts. Features must never import another feature's data or presentation package.
5. Write widget and signal tests covering UI rendering and state transitions with mocked domain contracts.

### Phase 5: Composition Root Assembly (`apps/main_app`)
1. Register concrete infrastructure implementations with domain contracts at the composition root using `kaisel` DI.
2. Wire app shell routing and flavor initialization in `apps/main_app`.
3. Add a smoke test in `apps/main_app/test/` to verify DI graph resolution and startup state.

### Phase 6: Workspace Validation & Verification
1. Run `dart format .` across all modified Dart files.
2. Run `dart analyze` to guarantee zero static analysis issues.
3. Run `flutter test packages/domain packages/infrastructure packages/core_ui apps/main_app` (or affected feature packages) to confirm all tests pass.
4. Ensure no forbidden cross-package imports exist and no duplicate third-party dependencies were introduced.

### Phase 7: Completion Gate & Pre-commit Check
Before declaring completion:
- Confirm domain remains pure Dart without Flutter or vendor imports.
- Confirm features have no direct infrastructure or vendor SDK imports.
- Confirm concrete dependencies are registered only in `apps/main_app`.
- Confirm barrel files re-export only intentional public APIs.
- Confirm all new/modified capabilities have corresponding tests that pass.

---

## Skill: Agentic Flutter Delivery Workflow

### Route the Task
1. Identify the smallest concrete anchor: a failing test, file, symbol, or user-visible behavior.
2. Read the owning package barrel, its `pubspec.yaml`, and the nearest test or call site.
3. State one local hypothesis about the behavior and one cheap check that could disprove it.
4. Choose the smallest package and layer that owns the change.
5. Trace cross-layer issues via `UI -> controller -> use case -> contract -> adapter -> mapper -> state -> UI`.

### Implement in Dependency Order
1. Domain contract and entity.
2. Infrastructure adapter and mapper.
3. Feature orchestration and signal state.
4. Presentation widgets.
5. Composition root DI registration (`apps/main_app`).
6. Package barrel re-exports.

### Validate Continuously
- Format changed Dart files (`dart format .`).
- Analyze the workspace (`dart analyze`).
- Run focused tests and workspace package tests (`flutter test`).
- Ensure clean workspace resolution (`flutter pub get`).

---

## Skill: SOLID & Clean Architecture

### Dependency Direction
`apps/main_app` -> `packages/features` -> `packages/domain`
`apps/main_app` -> `packages/infrastructure` -> `packages/domain`

- `packages/features` may depend on `packages/core_ui` and `packages/domain`.
- `packages/domain` is pure Dart.

### SOLID Rules
1. **Single Responsibility**: Separate presentation, orchestration, domain policy, and infrastructure IO.
2. **Open/Closed**: Extend capabilities by adding new adapters behind existing domain interfaces.
3. **Liskov Substitution**: Ensure adapters strictly conform to interface contracts without unexpected side effects.
4. **Interface Segregation**: Keep capability interfaces focused and small (`IAuthService`, `IUserRepository`).
5. **Dependency Inversion**: High-level modules depend on abstractions; concrete classes are injected at the composition root.

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
- No feature may import infrastructure or vendor SDKs.
- No duplicate third-party dependencies across packages without explicit documentation.
- Barrel files re-export capabilities and domain entities, never vendor classes.
