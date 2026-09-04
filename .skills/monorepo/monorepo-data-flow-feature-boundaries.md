---
name: monorepo-data-flow-feature-boundaries
description: Canonical request paths, feature boundary isolation, cross-feature communication, and app shell responsibilities.
version: 1.0.0
tags: [data-flow, feature-boundaries, app-shell, routing, cross-feature]
---

# Skill: Modular Monorepo Data Flow & Feature Boundaries

## Feature Isolation
- Features must not import presentation or data packages of other features.
- Cross-feature transitions must route through app shell callbacks or shared domain contracts.
- App shell (`apps/main_app`) owns startup, flavor initialization, DI wiring, and top-level routing.
