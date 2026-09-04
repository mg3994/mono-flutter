---
name: agentic-ai-skills-registry
description: Master skill registry and frontmatter specs for AI coding agents operating across any codebase or domain.
version: 1.7.0
tags: [agentic-ai, skills, workflows, clean-architecture, flutter, monorepo, kaisel, accessibility, a11y]
---

# Skills & Guidelines for AI Coding Agents

This workspace maintains its agent skills in structured `.skills/` modules with YAML frontmatter:

- [.skills/workflow/agentic-flutter-delivery-workflow.md](.skills/workflow/agentic-flutter-delivery-workflow.md)
- [.skills/architecture/solid-clean-architecture.md](.skills/architecture/solid-clean-architecture.md)
- [.skills/standards/coding-standards-dry-public-apis.md](.skills/standards/coding-standards-dry-public-apis.md)
- [.skills/governance/dependency-governance-lego-ownership.md](.skills/governance/dependency-governance-lego-ownership.md)
- [.skills/testing/flutter-testing-quality-gates.md](.skills/testing/flutter-testing-quality-gates.md)
- [.skills/monorepo/monorepo-data-flow-feature-boundaries.md](.skills/monorepo/monorepo-data-flow-feature-boundaries.md)
- [.skills/stack/tech-stack-integration.md](.skills/stack/tech-stack-integration.md)

Key Tech Stack & Accessibility Directives:
- **Routing & Navigation**: `kaisel` (app shell / navigation layer)
- **Linter**: `kaisel_lint`
- **State Management**: `bloc_signals_flutter` (feature presentation)
- **HTTP Client**: `dio` (`packages/infrastructure`)
- **Database**: `drift` & `sqlite3` (`packages/infrastructure`)
- **Identity & Auth**: `firebase_auth` & `firebase_core` (`packages/infrastructure`)
- **Accessibility (A11y)**: All UI widgets in `packages/core_ui` and features must support Screen Readers (`Semantics`), minimum 48x48 touch targets, WCAG AA contrast, dynamic font scaling, and semantic labels.

AI agents operating in this repository must obey all skill definitions in `.skills/` and accessibility rules.
