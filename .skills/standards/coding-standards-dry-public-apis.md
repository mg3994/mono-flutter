---
name: coding-standards-dry-public-apis
description: Package shape, file organization, DRY rules, naming conventions, and public barrel exports.
version: 1.0.0
tags: [coding-standards, naming, dry, public-api, package-shape]
---

# Skill: Coding Standards, DRY & Public APIs

## Package Shape & Naming
- Internal logic lives under `lib/src/`.
- Public API exposed through a single barrel file at `lib/<package_name>.dart`.
- Re-export only domain contracts, entities, states, and events; hide DTOs, generated files, and vendor internals.
- Interfaces begin with `I` (e.g., `IAuthService`). Implementations end with underlying technology name (e.g., `InMemoryAuthService`, `FirebaseAuthService`).
- Use explicit, descriptive variable names and avoid one-letter variables outside small local loops.
