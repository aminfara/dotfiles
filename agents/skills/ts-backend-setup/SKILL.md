---
name: ts-backend-setup
description: Set up and structure a TypeScript backend project with best practices. Use when starting a new TypeScript backend service, configuring tsconfig, setting up ESLint, organizing modules, configuring environment validation, or wiring dependency injection. Trigger on project setup, backend scaffolding, tsconfig, ESLint config, module structure, or DI container questions.
---

# TypeScript Backend Project Setup

Opinionated guide for structuring and configuring a Node.js backend in TypeScript (ESM).

> This skill covers project structure, toolchain, and composition-root wiring. For code-shape patterns inside modules (factory functions, Zod schemas, error types), see the `ts-coding` skill.

## Project Structure

Organize by feature/domain, not by technical layer:

```
src/
  config.ts          # env validation + typed config
  container.ts       # DI wiring
  server.ts          # framework bootstrap
  errors.ts          # shared error base classes
  modules/
    users/
      users-models.ts     # Zod schemas + derived types
      users-service.ts    # business logic (factory fn)
      users-routes.ts     # HTTP handlers
      users-repository.ts # data access (factory fn)
      users-errors.ts     # domain-specific errors
  db/
    seeder.ts
```

Each module owns its models, service, routes, repository, and errors. Do not group all services or all repositories together.

## TypeScript Config

Extend `@tsconfig/strictest` for maximum type safety. Run with `tsx`, never compile to JS for dev/test.

```jsonc
// tsconfig.json
{
  "extends": ["@tsconfig/node-lts", "@tsconfig/strictest"],
  "compilerOptions": {
    "noEmit": true,
    "paths": { "@/*": ["./src/*"] }
  }
}
```

> Use **context7** to verify the latest `@tsconfig/node-lts` and `@tsconfig/strictest` options.

ESM rules:
- Set `"type": "module"` in `package.json`.
- Use `.js` extensions on all local relative imports (even when source is `.ts`): `import { foo } from './foo.js'`.
- Use `import type` for type-only imports.

## Environment Config

Read and validate all environment variables at startup using Zod. Fail fast if required vars are missing.

```typescript
// src/config.ts
import { z } from 'zod';

const configSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']),
  PORT: z.coerce.number().default(3000),
  DATABASE_URL: z.string().url(),
});

export type Config = z.output<typeof configSchema>;

export function loadConfig(): Config {
  return configSchema.parse(process.env);
}
```

Load `.env` before this runs. Use `tsx --env-file=.env` (Node 20+) or `dotenvx run` in npm scripts — not `dotenv` inside application code. Never read `process.env` outside of `config.ts`. Inject `Config` through DI.

## Dependency Injection

Use `awilix` to wire the composition root. It calls the factory functions defined by the `ts-coding` patterns, injecting deps automatically by matching registered names to factory parameter names.

```typescript
// src/container.ts
import { createContainer, asFunction } from 'awilix';

export function setupContainer() {
  const container = createContainer({ strict: true });
  container.register({
    config:       asFunction(loadConfig).singleton(),
    db:           asFunction(createDbClient).singleton().disposer(d => d.end()),
    usersRepo:    asFunction(createDynamoDbUsersRepository).singleton(),
    usersService: asFunction(createUserService).singleton(),
  });
  return container;
}
```

- Use `.singleton()` only when all of a factory's own dependencies are also singletons.
- Use `.disposer()` to cleanly shut down connections and timers.
- Inject `config` as a dependency — never import it directly in modules.

> Use **context7** to check the latest awilix API (scoped containers, lifetime management).

## Linting

Use ESLint with `typescript-eslint`. Key rules to enable:

```javascript
// eslint.config.js (flat config)
import tseslint from 'typescript-eslint';

export default tseslint.config(
  ...tseslint.configs.strictTypeChecked,
  {
    rules: {
      '@typescript-eslint/no-floating-promises': 'error',
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/consistent-type-imports': ['error', { prefer: 'type-imports' }],
      'no-console': 'warn',
    },
    languageOptions: {
      parserOptions: { projectService: true },
    },
  }
);
```

> Use **context7** for the latest `typescript-eslint` flat config API.

## npm Scripts

```json
{
  "scripts": {
    "dev":       "dotenvx run -f .env -- tsx watch src/main.ts",
    "typecheck": "tsc --noEmit",
    "build":     "esbuild src/main.ts --bundle --platform=node --outfile=dist/main.js",
    "lint":      "eslint src",
    "test":      "vitest run",
    "test:watch": "vitest"
  }
}
```

`tsx` is for dev/test only — no JS emit. For production, choose a build strategy based on your deployment target:
- **Serverless / single-file**: bundle with `esbuild` (fast, small output).
- **Standard Node service**: use `tsc` to emit JS, or keep `tsx` if startup time allows.

## Testing Setup (Vitest)

Use `vitest` with named projects to separate unit and integration suites. E2E tests that need live infrastructure belong in a third project:

```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    projects: [
      { test: { name: 'unit', include: ['tests/unit/**/*.test.ts'] } },
      { test: { name: 'integration', include: ['tests/integration/**/*.test.ts'] } },
      { test: { name: 'e2e', include: ['tests/e2e/**/*.test.ts'] } },
    ],
  },
});
```

Each project config is standalone — it does not inherit the root config unless you explicitly add `extends: true` to the project options.

> Use **context7** for the latest vitest config options including workspaces/projects API.

## Graceful Shutdown

Connect `SIGTERM`/`SIGINT` to the DI container's `dispose()`. This calls all registered `.disposer()` functions, draining connections before exit:

```typescript
// src/main.ts
const container = setupContainer();

async function shutdown() {
  await container.dispose();
  process.exit(0);
}

process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
```

## Key Principles

| Principle | Implementation |
|-----------|----------------|
| Fail fast on bad config | Zod parse at startup, before server starts |
| No globals in business logic | Inject all deps via DI container |
| Feature-first folder structure | `modules/<feature>/` owns everything |
| TypeScript for type-checking only | `tsx` at runtime, `tsc --noEmit` in CI |
| Clean shutdown | `.disposer()` + SIGTERM handler |
