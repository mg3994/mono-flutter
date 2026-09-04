---
name: monorepo-data-flow-feature-boundaries
description: Monorepo canonical data flow, vertical feature package models, feature boundary isolation, and routing.
version: 3.0.0
tags: [data-flow, feature-boundaries, app-shell, routing, cross-feature, kaisel]
---

# Skill: Modular Monorepo Data Flow & Feature Boundaries

Use this skill when designing features, routing cross-feature communication, or tracing request flows.

## 1. Canonical Runtime Data Flow

`User Action -> Feature Signals (bloc_signals_flutter) -> Domain Use Case -> Domain Contract -> Infrastructure Adapter (Dio/Drift/Firebase) -> DTO Mapper -> Domain Result -> UI State -> Widget`

Assembly path:
`apps/main_app -> Concrete Infrastructure Adapter -> Domain Contract -> Use Case -> Feature Controller -> Widget`

## 2. Feature Boundaries & Routing via Kaisel

- Features must NOT import presentation or data packages from other features.
- Cross-feature communication and navigation route through app shell callbacks (`apps/main_app`) using `kaisel` for routing.
- App shell owns routing setup (`kaisel`), startup, flavor selection, and DI registration.
