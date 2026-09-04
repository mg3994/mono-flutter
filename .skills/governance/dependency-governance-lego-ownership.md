---
name: dependency-governance-lego-ownership
description: Single dependency ownership, vendor isolation, shared wrappers, and graph governance.
version: 1.0.0
tags: [dependencies, governance, lego-ownership, monorepo, vendor-isolation]
---

# Skill: Dependency Governance & LEGO Ownership

## Ownership Map & Enforcement Rules
- UI & Design System: `packages/core_ui`
- Network (Dio): `packages/infrastructure/network` (or `packages/infrastructure`)
- Persistence (Drift): `packages/infrastructure/persistence` (or `packages/infrastructure`)
- Auth / Firebase: `packages/infrastructure/identity` (or `packages/infrastructure`)
- Composition Root & DI: `apps/main_app` using `kaisel`
- Feature State: `bloc_signals_flutter` in feature presentation packages
- No feature package may import infrastructure or vendor SDKs directly.
