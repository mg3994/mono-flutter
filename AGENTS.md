# Skills & Guidelines

## Skill: Agentic Flutter Delivery Workflow

Use this skill as the default operating procedure for an AI coding agent in this monorepo.

### Route the Task

1. Identify the smallest concrete anchor: a failing test, file, symbol, or user-visible behavior.
2. Read the owning package barrel, its `pubspec.yaml`, and the nearest test or call site.
3. State one local hypothesis about the behavior and one cheap check that could disprove it.
4. Choose the smallest package and layer that owns the change. Do not widen the change because a nearby abstraction is convenient.
5. For a cross-layer issue, trace the request as `UI -> controller -> use case -> contract -> adapter -> mapper -> state -> UI` and stop at the first layer that makes the decision.

### Implement in Dependency Order

1. Add or adjust a domain contract and entity when the capability is new.
2. Implement and map the infrastructure adapter behind that contract.
3. Add feature orchestration and signal state.
4. Keep widgets focused on rendering and user events.
5. Register concrete dependencies in `apps/main_app`.
6. Update the package barrel and documentation only for intentional public API.

Features must not import another feature's presentation or data package. Route navigation through the app shell or introduce a small shared contract only when the interaction is genuinely cross-feature.

For a bug, start at the failing behavior and trace inward to the first layer that decides it. Avoid changing consumers to compensate for a broken adapter contract.

### Validate Continuously

After the first edit, run the narrowest available check immediately: the focused test, analyzer target, or package command. Then validate the broader workspace before completion:

- format changed Dart files;
- analyze the affected package and workspace;
- run focused tests, then the relevant package test suite;
- run `dart pub get` or the repository's workspace resolution command;
- inspect dependency declarations for duplicate vendor ownership;
- verify no forbidden imports cross package boundaries.

When a check fails, repair the same slice and rerun that check before starting another edit slice. Do not silence analyzer or lint failures without understanding the rule.

### Completion Gate

Before reporting success, confirm:

- domain has no Flutter or vendor imports;
- features have no infrastructure or vendor imports;
- concrete dependencies are wired only at the composition root;
- DTOs, rows, generated classes, and vendor exceptions stop at infrastructure;
- public barrels hide implementation details;
- no new duplicate third-party dependency was introduced;
- focused tests cover success, failure, loading, and boundary mapping where applicable.

Report changed packages, checks run, and any unresolved pre-existing failures. Never claim a test passed if it was not run.

---

## Skill: SOLID & Clean Architecture

Use this skill whenever an agent creates or changes a Flutter feature, package, service, or infrastructure adapter.

### Dependency Direction

The dependency graph points inward:

`apps/main_app` -> `packages/features` -> `packages/domain`

`apps/main_app` -> `packages/infrastructure` -> `packages/domain`

`packages/features` may depend on `packages/core_ui` and `packages/domain`. It must not depend on infrastructure, concrete services, another feature, or a vendor SDK. The composition root in `apps/main_app` is the only place that wires concrete implementations to interfaces.

`packages/domain` is pure Dart. It contains entities, value objects, failures, and small interfaces. It must not import Flutter, a database library, a network client, Firebase, or generated infrastructure code.

### SOLID Rules

1. **Single Responsibility**: Keep presentation, application orchestration, domain policy, and infrastructure IO in separate files and packages.
2. **Open/Closed**: Add a new adapter behind an existing domain contract instead of changing consumers for each vendor.
3. **Liskov Substitution**: Every implementation must preserve the error, nullability, ordering, and lifecycle behavior promised by its interface.
4. **Interface Segregation**: Prefer small capability interfaces such as `IAuthService` or `IUserRepository`; do not expose a vendor-shaped mega-interface.
5. **Dependency Inversion**: High-level code depends on domain contracts. Concrete implementations depend on those contracts and are registered only at the composition root.

### Boundary Shielding

- Map API DTOs, database rows, Firebase models, and generated classes to domain entities inside infrastructure.
- Never expose `Dio`, Drift tables/rows, Firebase types, generated serializers, or vendor exceptions to UI or domain code.
- Translate infrastructure failures into stable domain failures at the adapter boundary.
- Keep DTOs and mappers private unless another infrastructure adapter genuinely needs them.

### LEGO Acceptance Test

A brick is swappable when its consumers import only the contract or package barrel, its concrete vendor dependency is isolated to the brick, and replacing the adapter requires changes only in that brick plus composition-root registration. If a feature needs a vendor import, the boundary is in the wrong place.

---

## Skill: Coding Standards, DRY & Public APIs

Apply these rules to every Dart package and app change.

### Package Shape

- Every package has `lib/src/` for implementation and one top-level barrel such as `lib/auth_feature.dart`.
- Export only intentional public contracts, entities, states, events, and use cases. Do not export database classes, DTOs, generated files, or internal helpers.
- Keep package names and imports aligned with the workspace member name. Use package imports across package boundaries, not relative paths.

### Naming and Design

- Interfaces start with `I`; technology-backed implementations end with the technology name, for example `FirebaseAuthService`.
- Use descriptive names. Avoid one-letter variables except conventional indexes in tiny local loops.
- Remove duplicated policy and mapping logic by extracting a domain abstraction or a local helper at the owning boundary. Do not create a shared utility package merely to avoid two unrelated lines of code.
- Preserve existing public APIs unless the task explicitly requires a breaking change.

### Tooling and Configuration

- Respect the root `analysis_options.yaml` and run the repository's formatter, analyzer, and tests before completion.
- Use `kaisel_lint` rules for dependency injection and register dependencies in the composition root.
- Use `--flavor` for environment-specific configuration. Never commit API keys or environment secrets, and never hardcode them in `packages/`.
- Generated code belongs beside the package that owns its generator and must not become part of another package's public API.

---

## Skill: Dependency Governance & LEGO Ownership

Use this skill whenever an agent adds, upgrades, or moves a package dependency.

### One Dependency, One Owner

Every third-party dependency has one owning package in the workspace. The owner wraps the dependency behind a stable public API and is the only package allowed to import the vendor directly.

Recommended ownership map:

- `flutter`, `cupertino`, and presentation-only Flutter libraries: `packages/core_ui` or the relevant feature when the dependency is strictly screen-local.
- `dio`: `packages/infrastructure/network`.
- Drift runtime, tables, migrations, and generated persistence code: `packages/infrastructure/persistence`.
- Firebase SDKs: `packages/infrastructure/identity` or another dedicated infrastructure brick; Firebase initialization remains in `apps/main_app`.
- `bloc_signals_flutter`: feature presentation packages.
- `kaisel`: the composition root and approved orchestration package, not domain contracts.
- Code generators and generator builders: dev dependencies of the package that owns the generated output.

This list is a default. If a dependency needs a different owner, record the reason in the package documentation and keep its transitive vendor API hidden.

### Shared Wrappers

Create a shared wrapper only when the capability is feature-agnostic and used by at least two consumers, such as logging, analytics, secure storage, or a network client. Keep the wrapper's interface separate from its vendor adapter when consumers need a stable contract. A shared package must never import a feature or app shell.

Do not move feature-specific business rules into `core` or `services` just because multiple features currently call them. Shared code belongs at the lowest layer that owns the policy; repeated policy is a signal to define a domain contract, not automatically to create a utility package.

### Before Adding a Dependency

1. Search every workspace `pubspec.yaml` for the dependency and identify its current owner.
2. Ask whether the owning package can expose the needed capability. Prefer that API over a second direct dependency.
3. Check that the proposed edge preserves the clean architecture graph and does not create a cycle.
4. Add the dependency only to the smallest owning package. Keep versions aligned for dependencies intentionally shared by multiple workspace packages.
5. Run dependency resolution, formatting, analysis, and focused tests.

### Enforcement Rules

- A feature must not import an infrastructure vendor even if the vendor is transitive.
- Do not use `dependency_overrides` to hide a version conflict or bypass ownership.
- Do not create a common package whose only purpose is re-exporting unrelated vendors.
- Public barrels expose capabilities and domain types, never vendor types.
- An upgrade is complete only when all workspace packages still resolve and the owner remains the sole direct importer.

### Review Questions

- Who owns this dependency?
- Which public interface hides it?
- Can the owner be replaced without changing consumers?
- Is the dependency declared in more than one `pubspec.yaml`, and if so, is that intentional and documented?
- Does the package remain independently testable with a fake implementation?

---

## Skill: Flutter Testing & Quality Gates

Use this skill when adding behavior, fixing a defect, or changing a package boundary.

### Test by Boundary

- **Domain**: test pure entities, value objects, use-case policy, and failure behavior without Flutter or platform plugins.
- **Infrastructure**: test DTO/row mapping, success paths, translated failures, retries, transactions, and adapter behavior with fakes or local test doubles.
- **Features**: test signal state transitions and user-facing methods with mocked domain interfaces. Cover loading, success, empty, and failure states.
- **Core UI**: test reusable widgets for semantics, interaction, required states, and responsive constraints. Do not couple tests to incidental implementation details.
- **Composition root**: add a smoke test proving the real registrations resolve and the app starts for each supported flavor configuration.

### Quality Gates

A change is ready only when:

1. The smallest relevant test reproduces the intended behavior.
2. The focused test passes after the implementation change.
3. The affected package analyzes cleanly with the repository lint configuration.
4. Workspace dependency resolution succeeds.
5. Public API and forbidden-import checks pass.
6. The test suite does not require network access, real credentials, or a production database.

### Failure Discipline

Test observable contracts, not private implementation details. Keep platform and vendor behavior behind interfaces so tests can use deterministic fakes. When a test fails, classify it as a product regression, an invalid test assumption, or a pre-existing environment failure before changing code. Do not weaken assertions to make a failure disappear.

### Definition of Done

Every new interface has a fake or mockable test seam. Every adapter maps boundary data explicitly. Every stateful feature has tests for its state transitions. Every bug fix adds a regression test at the narrowest layer that can catch the bug.

---

## Skill: Modular Monorepo Data Flow & Feature Boundaries

Use this skill when designing a feature, tracing a bug across layers, or connecting two features.

### Canonical Runtime Flow

The normal request path is:

`User action -> feature controller/signals -> domain use case -> domain contract -> infrastructure adapter -> DTO/row mapper -> domain result -> feature state -> UI`

The reverse path is assembly only:

`apps/main_app -> concrete infrastructure adapter -> domain contract -> use case -> feature controller -> widget`

Each arrow is a package boundary or constructor dependency that should be visible in code. Widgets do not call data sources, repositories, HTTP clients, databases, or vendor SDKs.

### Feature Package Model

The repository may keep one shared `packages/domain` package, or split a large feature into vertical packages:

```text
packages/features/<feature>/
  <feature>_domain/
  <feature>_data/
  <feature>_presentation/
```

Use the smallest model that preserves boundaries. A feature-specific domain package is appropriate when its contracts and entities can evolve independently. Do not create three packages for a tiny feature solely to imitate a template. In either model, domain remains pure Dart, data implements contracts, and presentation consumes domain APIs.

### Cross-Feature Communication

Features must not import another feature's presentation or data package.

Use these strategies in order:

1. Let the app shell own navigation. A feature emits an intent or callback such as `onLoginSuccess`; the shell maps it to a route.
2. Put a genuinely shared capability in a small domain contract package, then provide it through DI. Keep the contract business-neutral and feature-agnostic.
3. Use a typed application event only when asynchronous coordination is required. Define ownership, delivery semantics, lifecycle, and error behavior before introducing an event bus.

Do not use global mutable state or direct widget references to make features communicate.

### Data Boundary Rules

- Remote JSON becomes a DTO in the data brick, then a domain entity through an explicit mapper.
- Drift rows become domain entities inside the persistence brick.
- Cache policy, retries, pagination, transactions, and HTTP status handling stay in data or infrastructure.
- Domain results expose stable entities and typed failures, never response maps, rows, or vendor exceptions.
- Presentation maps domain results to immutable UI state and handles loading, empty, success, and failure states explicitly.

### App Shell Responsibilities

The app shell owns flavor selection, platform initialization, DI registration, routing, and top-level error reporting. It may depend on all selected bricks, but bricks must not depend on the shell. Keep registration in one composition root per app shell; do not create a second service locator inside a feature.

### Architecture Review Checklist

- Can the full request path be traced through the sequence above?
- Does every concrete adapter implement a domain contract?
- Are all cross-feature transitions handled by the shell or a documented shared contract?
- Are DTOs, rows, generated classes, and vendor errors stopped before presentation?
- Can a fake adapter drive the feature without network, disk, Firebase, or platform credentials?

---

## Skill: Monorepo Structure & Pub Workspaces

### Context

You are operating in a Flutter Monorepo using Dart Pub Workspaces.
The workspace is the "Baseplate" for LEGO-like development.

### Directory Map

- `/apps/main_app`: The entry point. Handles Flavors, Firebase Initialization, and Dependency Injection wiring.
- `/packages/domain`: Pure Dart. Contains abstract Interfaces (Contracts) and Entities. NO Flutter dependencies.
- `/packages/infrastructure`: Concrete implementations (e.g., `persistence` with Drift, `identity` with Firebase).
- `/packages/services`: Utility-based packages (e.g., `location`, `analytics`).
- `/packages/core_ui`: The Design System. Wraps Material/Cupertino into shared widgets.
- `/packages/features`: Vertical business slices (e.g., `auth_feature`).

For larger features, a vertical slice may contain `<feature>_domain`, `<feature>_data`, and `<feature>_presentation` packages. Use that split only when the boundaries provide independent ownership or reuse; otherwise keep the feature package internally layered.

Shared packages should be intentionally small and tiered:

- `packages/core`: stable cross-application contracts, result/failure types, and design-system APIs.
- `packages/services`: feature-agnostic capabilities such as logging, location, or analytics.
- `packages/infrastructure`: vendor-backed adapters and their private implementation details.

### Workspace Rules

1. The root `pubspec.yaml` declares workspace members and is the source of truth for workspace tooling.
2. Every workspace package has exactly one owning layer and a clear public barrel.
3. Features MUST NOT depend on other features. Shared behavior belongs in `domain`, `core_ui`, or an explicitly owned service package.
4. Features depend only on `domain` and `core_ui` plus Dart/Flutter SDK libraries approved for presentation. They do not depend on infrastructure or vendor SDKs.
5. `apps/main_app` owns startup, flavor selection, Firebase initialization, and dependency injection wiring.
6. All packages use the same version of a shared dependency. A package must not add a dependency already owned by another package merely for convenience; consume the owning package's API instead.
7. Dev-only tools such as `build_runner`, `drift_dev`, and code generators stay in the package that generates the code. Runtime packages must not depend on dev tools.
8. Keep dependency edges acyclic. Before adding a package edge, check the graph and explain why the edge belongs to that layer.
9. Declare every member in the root `workspace:` list and use `resolution: workspace` in each member `pubspec.yaml`.
10. Use package imports for workspace packages. Do not use relative paths across package boundaries or legacy path dependencies between workspace members.
11. Keep `.dart_tool/`, `.pub/`, and build outputs out of version control. Run workspace resolution from the root.

### Package Checklist

Before declaring a package complete, verify its `pubspec.yaml`, barrel exports, dependency direction, analyzer result, and focused tests. A package is not a LEGO brick if another package imports its internals or if its vendor dependency leaks through the barrel.

---

## Skill: Tech Stack Integration

Use the repository-approved stack consistently. Do not introduce a competing state-management, DI, networking, or persistence approach without an explicit architecture decision.

### State Management (Signals & Kaisel)

- Use `bloc_signals_flutter` for UI-bound state.
- Use `kaisel` for dependency injection and orchestration.
- Features should expose a `State` (Signals) and `Methods/Events`; keep widgets thin and side effects in orchestration code.
- Do not make signals, Flutter widgets, or feature state types part of `domain`.

### Database (Drift)

- Keep `drift_dev` and `build_runner` inside `packages/infrastructure/persistence`.
- Export only the repository implementation or domain-facing adapter, not the database class, tables, rows, or generated code.
- Keep migrations, transactions, queries, and row-to-entity mapping inside the persistence brick.

### Networking (Dio)

- Centralize `dio` in `packages/infrastructure/network`; do not add `dio` to features or domain.
- Implement interceptors for logging and auth headers globally, with secrets redacted in logs.
- Convert response DTOs and Dio errors before returning from infrastructure.

### Firebase & Flavors

- Firebase options and initialization live ONLY in `apps/main_app`.
- Features use the `IAuthService` interface from `domain`, implemented by `infrastructure/identity` using Firebase.
- Firebase options and initialization live only in `apps/main_app`; packages receive capabilities through interfaces and DI.
