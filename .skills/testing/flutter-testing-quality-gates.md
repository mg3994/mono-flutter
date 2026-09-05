---
name: flutter-testing-quality-gates
description: Boundary testing discipline, testing strategies, quality gates, and definition of done for AI agents.
version: 4.0.0
tags: [testing, quality-gates, definition-of-done, unit-tests, widget-tests, smoke-tests]
---

# Skill: Flutter Testing & Quality Gates

Use this skill when implementing features, fixing bugs, or verifying package changes.

## 1. Boundary Testing Rules

- **Domain**: Pure unit tests for logic, validation, and failure types without Flutter framework or plugin imports.
- **Infrastructure**: Adapter unit tests checking DTO/row mapping, happy paths, and error translation using fakes.
- **Features**: State transition and widget rendering tests with mocked domain contracts and `bloc_signals_flutter`.
- **Composition Root**: Startup smoke tests verifying dependency injection graph resolution and `kaisel` app initialization.

## 2. Definition of Done Checklist

- Focused tests pass for success, failure, and edge cases.
- `dart format .` passes with zero formatting diffs.
- `dart analyze` reports zero warnings or errors under `kaisel_lint`.
- All workspace package tests pass cleanly (`flutter test`).
- No forbidden cross-package imports introduced.
