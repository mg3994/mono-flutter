---
name: flutter-testing-quality-gates
description: Boundary testing discipline across domain, infrastructure, features, and composition root.
version: 1.0.0
tags: [testing, quality-gates, definition-of-done, unit-tests, smoke-tests]
---

# Skill: Flutter Testing & Quality Gates

## Testing Discipline
- **Domain**: Pure unit tests for logic and entities without Flutter framework dependencies.
- **Infrastructure**: Adapter tests verifying DTO mapping, error translation, and IO behavior with fakes.
- **Features**: Signal state transitions and widget rendering tests with mocked domain contracts.
- **Composition Root**: Startup smoke tests verifying dependency injection graph resolution.
