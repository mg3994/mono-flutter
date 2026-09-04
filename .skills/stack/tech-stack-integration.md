---
name: tech-stack-integration
description: Approved tech stack guidelines for state management, persistence, networking, and dependency injection.
version: 1.2.0
tags: [tech-stack, signals, drift, dio, kaisel, firebase]
---

# Skill: Tech Stack Integration

Use the repository-approved stack consistently. Do not introduce alternative state management, DI, networking, or persistence libraries.

## 1. Approved Tech Stack

- **State Management**: `bloc_signals_flutter` for UI state.
- **Dependency Injection**: `kaisel` at composition root (`apps/main_app`).
- **Database / Local Persistence**: `drift` contained inside `packages/infrastructure`.
- **Networking**: `dio` contained inside `packages/infrastructure`.
- **Firebase / Auth**: Firebase SDKs contained inside `packages/infrastructure`, initialized in `apps/main_app`.
