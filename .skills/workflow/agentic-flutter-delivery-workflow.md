---
name: agentic-flutter-delivery-workflow
description: Complete end-to-end delivery protocol for AI coding agents operating in a Flutter Monorepo using Pub Workspaces.
version: 3.3.0
tags: [workflow, delivery, task-routing, dependency-order, continuous-validation, completion-gates]
---

# Skill: Agentic Flutter Delivery Workflow

Use this skill as the default operating procedure for an AI coding agent in this monorepo.

## 1. Task Routing Protocol

1. **Identify the Anchor**: Find the smallest concrete anchor—a failing test, symbol, file, or requested user behavior.
2. **Context Inspection**: Read the barrel file (`lib/<package>.dart`), `pubspec.yaml`, and nearest test suite of the owning package.
3. **Formulate Hypothesis**: State one local hypothesis and one cheap check (e.g. running `flutter test` on a single file or `dart analyze`) to validate or disprove it.
4. **Trace Request Path**: For cross-layer changes, trace the request path:
   `UI -> Feature Controller/Signals -> Domain Use Case -> Domain Contract -> Infrastructure Adapter -> DTO Mapper -> Domain Result -> UI State -> Widget`
5. **Layer Isolation**: Select the narrowest owning package. Do not modify adjacent packages unless strictly required by contract changes.

## 2. Implementation in Dependency Order

1. **Domain Contract & Entities**: Define or update pure Dart interfaces and value objects in `packages/domain` (or `<feature>_domain`).
2. **Infrastructure Adapters**: Implement IO adapters, Drift persistence, Dio network clients, and DTO mappers in `packages/infrastructure` (or `<feature>_data`).
3. **Feature Orchestration**: Add signal state management using `bloc_signals_flutter` in feature presentation packages.
4. **UI Widgets**: Create thin, rendering-focused Flutter widgets.
5. **Composition Root**: Wire concrete adapters in `apps/main_app` composition root via DI and setup routes using `kaisel`.
6. **Public API Barrel**: Re-export intentional public types in package barrels (`lib/<package>.dart`).

## 3. Continuous Validation & Completion Gate

- **Format**: Run `dart format .` after every edit.
- **Analyze**: Run `dart analyze` to ensure zero warnings or errors under `kaisel_lint`.
- **Test**: Execute focused tests first, then package-wide test suites (`flutter test`).
- **Forbidden Imports Check**: Ensure `domain` has no Flutter/vendor imports, and `features` have no `infrastructure` imports.
