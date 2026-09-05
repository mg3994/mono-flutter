---
name: coding-standards-dry-public-apis
description: Coding standards, file structure conventions, DRY principles, naming guidelines, public API management, performance tear-offs, error handling resilience, internationalization, and accessibility standards.
version: 4.1.0
tags: [coding-standards, naming, dry, public-api, package-shape, accessibility, performance, tear-offs, error-resilience, i18n]
---

# Skill: Coding Standards, DRY & Public APIs

Apply these rules to every Dart package and app change in the workspace.

## 1. Package Shape & Structure

- Implementation lives inside `lib/src/`.
- Every package exports its intentional public API through a single top-level barrel file (`lib/<package_name>.dart`).
- Re-export contracts, entities, states, and events; NEVER export database rows, DTOs, generated code, or internal helpers.

## 2. Naming & Design

- Interfaces start with `I` (e.g. `IAuthService`).
- Concrete implementations end with the technology name (e.g. `InMemoryAuthService`, `FirebaseAuthService`).
- Variable names must be explicit and descriptive; avoid one-letter variables outside small local index loops.
- Respect lint rules enforced by `kaisel_lint`.
- Extract duplicated mapping or validation policy into a local helper or domain entity method rather than creating ad-hoc shared utility packages.

## 3. Widget Performance & Callback Tear-offs

Avoid unnecessary closure re-allocations during widget rebuilds. Pass stable tear-off method references instead of inline anonymous functions when arguments match:

```dart
// ❌ Re-allocated on every build:
whatever: () => _handleTap(),

// ✅ Stable reference, fully cached & allocation-free:
whatever: _handleTap,
```

## 4. Error Handling Resilience & Boundary Translation

Translate all low-level vendor errors (DioException, DriftException, FirebaseAuthException) into domain failure objects inside infrastructure adapters. Never let raw vendor exceptions leak into presentation or domain code.

## 5. Internationalization (i18n) Standards

User-facing presentation strings must be internationalized via `flutter_localizations` and `intl` declared in `packages/core_ui`. Never hardcode user-visible text strings directly inside presentation widgets.

## 6. Universal Accessibility (A11y) Standards

1. **Screen Readers & Semantics**: Wrap interactive custom controls in `Semantics` widgets with meaningful `label`, `hint`, and `button` / `enabled` state properties. Merge child semantics using `MergeSemantics` where visual components form a single action.
2. **Touch Targets**: Ensure interactive touch targets meet the minimum 48x48 dp size (`kMinInteractiveDimension`).
3. **Color Contrast & Dynamic Scaling**: Conform to WCAG AA color contrast ratios (minimum 4.5:1 for standard text). Support dynamic text scaling without layout truncation.
4. **Keyboard & Assistive Navigation**: Ensure all interactive widgets support focus traversal and keyboard navigation.
