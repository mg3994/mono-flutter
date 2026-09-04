---
name: tech-stack-integration
description: Approved tech stack guidelines for state management, persistence, networking, and DI.
version: 1.0.0
tags: [tech-stack, signals, drift, dio, kaisel, firebase]
---

# Skill: Tech Stack Integration

## Approved Stack Configuration
- **State Management**: `bloc_signals_flutter` for UI state.
- **Dependency Injection**: `kaisel` at composition root (`apps/main_app`).
- **Database**: `drift` contained inside `packages/infrastructure`.
- **Networking**: `dio` contained inside `packages/infrastructure`.
