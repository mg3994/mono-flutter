---
name: dependency-governance-lego-ownership
description: Dependency governance, single ownership rules, vendor isolation, and workspace graph management.
version: 1.3.0
tags: [dependencies, governance, lego-ownership, vendor-isolation, monorepo]
---

# Skill: Dependency Governance & LEGO Ownership

Use this skill whenever adding, upgrading, or refactoring package dependencies in the workspace.

## 1. Single Dependency Ownership Map

Every third-party dependency has exactly one owner package in the monorepo:

- **Routing & Navigation**: `kaisel` owned by `apps/main_app` (or navigation layer).
- **Linter & Analyzer**: `kaisel_lint` dev dependency in workspace root / member `pubspec.yaml`.
- **UI & Design System**: `packages/core_ui` (`cupertino_icons`, `flutter_localizations`, `intl`).
- **HTTP Client**: `dio` in `packages/infrastructure`.
- **Local Persistence**: `drift`, `sqlite3`, `path_provider` in `packages/infrastructure`.
- **Cloud & Auth**: `firebase_core`, `firebase_auth` in `packages/infrastructure`.
- **State Management**: `bloc_signals_flutter` in feature presentation packages.
- **Composition Root**: `apps/main_app` wires DI constructor injection and `kaisel` routes.

## 2. Enforcement Rules

- Features must NEVER import vendor SDKs (`dio`, `drift`, `firebase_*`) or infrastructure packages directly.
- Barrel files re-export capabilities and domain types, never vendor classes.
