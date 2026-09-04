---
name: solid-clean-architecture
description: Clean Architecture principles, inward dependency direction rules, SOLID design, and LEGO brick swappability.
version: 1.5.0
tags: [clean-architecture, solid, dependency-direction, lego-bricks, boundary-shielding]
---

# Skill: SOLID & Clean Architecture

Use this skill whenever an agent creates or refactors a Flutter package, service, or feature.

## 1. Dependency Direction

The dependency graph points strictly inward:

`apps/main_app` -> `packages/features` -> `packages/domain`
`apps/main_app` -> `packages/infrastructure` -> `packages/domain`

- `packages/features` depends on `packages/core_ui` and `packages/domain`.
- `packages/domain` is pure Dart (no Flutter, Dio, Drift, or Firebase imports).
- The composition root in `apps/main_app` is the only place where concrete infrastructure is bound to domain contracts and where `kaisel` configures app routing.

## 2. SOLID Rules for Agents

1. **Single Responsibility**: Separate presentation, orchestration, domain logic, and IO into distinct files and packages.
2. **Open/Closed**: Add new capability adapters behind existing domain interfaces rather than mutating callers.
3. **Liskov Substitution**: Adapters must strictly fulfill error, nullability, and lifecycle expectations promised by domain interfaces.
4. **Interface Segregation**: Prefer small, focused capability interfaces (`IAuthService`, `IUserRepository`).
5. **Dependency Inversion**: High-level feature code depends on abstractions; concrete classes are injected at runtime.

## 3. Boundary Shielding & LEGO Acceptance Test

- **Boundary Shielding**: DTOs, Drift rows, Dio exceptions, and Firebase types must stop at the infrastructure boundary. Map them to domain entities and domain failure objects before returning to domain or presentation.
- **LEGO Acceptance Test**: A package brick is swappable when replacing its adapter requires edits ONLY in that brick plus composition-root DI registration and `kaisel` route registration in `apps/main_app`.
