---
name: solid-clean-architecture
description: Enforces inward dependency direction, SOLID design principles, boundary shielding, and swappable LEGO bricks.
version: 1.0.0
tags: [architecture, solid, clean-architecture, boundaries, lego-bricks]
---

# Skill: SOLID & Clean Architecture

## Dependency Direction
`apps/main_app` -> `packages/features` -> `packages/domain`
`apps/main_app` -> `packages/infrastructure` -> `packages/domain`

- `packages/features` depends on `packages/core_ui` and `packages/domain`.
- `packages/domain` is pure Dart with zero vendor or framework imports.

## SOLID Rules
1. **Single Responsibility**: Keep presentation, orchestration, domain policy, and IO in separate packages and files.
2. **Open/Closed**: Add new adapters behind existing domain interfaces without modifying calling code.
3. **Liskov Substitution**: Implementation adapters must preserve error, nullability, and lifecycle contracts promised by domain interfaces.
4. **Interface Segregation**: Prefer small, focused capability interfaces (`IAuthService`, `IUserRepository`) over monolithic interfaces.
5. **Dependency Inversion**: High-level feature code depends solely on domain contracts; concrete adapters are bound at the composition root.
