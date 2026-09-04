---
name: dependency-governance-lego-ownership
description: Dependency governance, single ownership rules, vendor isolation, and workspace graph management.
version: 2.5.0
tags: [dependencies, governance, lego-ownership, vendor-isolation, monorepo]
---

# Skill: Dependency Governance & LEGO Ownership

Use this skill whenever adding, upgrading, or refactoring package dependencies in the workspace.

## 1. Single Dependency Ownership

Every third-party dependency has exactly one owner package in the monorepo:

- Routing & Navigation: `kaisel` owned by `apps/main_app` (or navigation layer).
- Linter: `kaisel_lint` dev dependency in workspace root / member `pubspec.yaml`.
- UI & Material/Cupertino: `packages/core_ui` (`cupertino_icons`, `flutter_localizations`, `intl`).
- HTTP Client (Dio): `packages/infrastructure/network` (or `packages/infrastructure`).
- Database (Drift): `packages/infrastructure/persistence` (or `packages/infrastructure`).
- Firebase / Auth: `packages/infrastructure/identity` (or `packages/infrastructure`).
- State Management: `bloc_signals_flutter` in feature presentation packages.
- Composition Root: `apps/main_app` wires constructor DI and `kaisel` routes.

## 2. Enforcement Rules

- Features must NEVER import vendor SDKs (`dio`, `drift`, `firebase_*`) or infrastructure packages directly.
- Barrel files re-export capabilities and domain types, never vendor classes.
- All workspace members use aligned dependency constraints declared in workspace resolution.
