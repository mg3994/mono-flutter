---
name: coding-standards-dry-public-apis
description: Coding standards, file structure conventions, DRY principles, naming guidelines, and public API management.
version: 1.4.0
tags: [coding-standards, naming, dry, public-api, package-shape]
---

# Skill: Coding Standards, DRY & Public APIs

Apply these rules to every Dart package and app change in the workspace.

## 1. Package Shape & Structure

- Implementation lives inside `lib/src/`.
- Every package exports its intentional public API through a single top-level barrel file (`lib/<package_name>.dart`).
- Re-export contracts, entities, states, and events; NEVER export database rows, DTOs, generated code, or internal helpers.

## 2. Naming & Design

- Interfaces start with `I` (e.g. `IAuthService`).
- Concrete implementations end with the technology name (e.g. `InMemoryAuthService`, `FirebaseAuthService`).
- Variable names must be explicit and descriptive; avoid one-letter variables outside small local index loops.
- Respect lint rules enforced by `kaisel_lint`.
- Extract duplicated mapping or validation policy into a local helper or domain entity method rather than creating ad-hoc shared utility packages.
