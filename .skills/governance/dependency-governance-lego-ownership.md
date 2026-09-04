---
name: dependency-governance-lego-ownership
description: Dependency governance, single ownership rules, vendor isolation, and workspace graph management.
version: 1.2.0
tags: [dependencies, governance, lego-ownership, vendor-isolation, monorepo]
---

# Skill: Dependency Governance & LEGO Ownership

Use this skill whenever adding, upgrading, or refactoring package dependencies in the workspace.

## 1. Single Dependency Ownership

Every third-party dependency has exactly one owner package in the monorepo:

- UI & Material/Cupertino: `packages/core_ui`
- HTTP Client (Dio): `packages/infrastructure/network` (or `packages/infrastructure`)
- Database (Drift): `packages/infrastructure/persistence` (or `packages/infrastructure`)
- Firebase / Auth: `packages/infrastructure/identity` (or `packages/infrastructure`)
- State Management: `bloc_signals_flutter` in feature presentation packages
- DI & Composition Root: `apps/main_app` using `kaisel`

## 2. Enforcement Rules

- Features must NEVER import vendor SDKs or infrastructure packages directly.
- Barrel files re-export capabilities and domain types, never vendor classes.
- All workspace members use aligned dependency constraints declared in workspace resolution.
