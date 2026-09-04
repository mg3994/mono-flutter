---
name: agentic-flutter-delivery-workflow
description: Standard operating procedure for end-to-end task routing, implementation dependency order, continuous validation, and completion gates.
version: 1.0.0
tags: [workflow, routing, dependency-order, validation, completion-gate]
---

# Skill: Agentic Flutter Delivery Workflow

## Task Routing Protocol
1. Identify the smallest concrete anchor: a failing test, file, symbol, or requested user-visible behavior.
2. Read the owning package barrel (`lib/<package>.dart`), its `pubspec.yaml`, and nearest test file.
3. Formulate one local hypothesis and one cheap check (e.g. running a focused test or analyzer) to validate/disprove it.
4. Trace cross-layer requests strictly along canonical flow:
   `UI -> Feature Signals/Controller -> Domain Use Case -> Domain Contract -> Infrastructure Adapter -> DTO/Row Mapper -> Domain Result -> Feature State -> UI`
5. Select the smallest package and layer that owns the change. Do not widen changes into adjacent packages unless required.

## Implementation Dependency Order
1. **Domain Contract & Entity**: Define or update pure Dart interfaces and value objects in `packages/domain` (or `<feature>_domain`).
2. **Infrastructure Adapter & DTO Mapper**: Implement network/storage adapters in `packages/infrastructure` (or `<feature>_data`), converting raw DTOs into domain types.
3. **Feature Orchestration & Signal State**: Implement presentation controllers using `bloc_signals_flutter` in feature presentation packages.
4. **Presentation Widgets**: Build focused Flutter widgets that subscribe to signals and emit events.
5. **Composition Root DI Registration**: Wire concrete implementations in `apps/main_app` using `kaisel` dependency injection.
6. **Package Barrel & Public API**: Export only intentional contracts and entities from package barrels (`lib/<package_name>.dart`).

## Continuous Validation & Completion Gate
- Format changed files: `dart format .`
- Analyze affected packages: `dart analyze`
- Execute tests: `flutter test packages/domain packages/infrastructure packages/core_ui apps/main_app`
- Verify boundary shielding: No vendor SDKs in `domain`, no infrastructure imports in `features`.
