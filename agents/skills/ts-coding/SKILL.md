---
name: ts-coding
description: Apply preferred TypeScript coding patterns and style. Use whenever writing or reviewing TypeScript code — factory functions, Zod schemas, error hierarchies, immutability, dependency injection via parameters, and options-object signatures. Trigger on any TypeScript implementation task, code review, or when the user asks how to structure TypeScript logic.
---

# TypeScript Coding Patterns

Preferred patterns for writing clean, type-safe, maintainable TypeScript.

## Factory Functions Over Classes

For service-style modules and dependency-wired business logic, prefer `createX()` functions that close over dependencies and return a plain object implementing a typed interface. This avoids `this`-binding issues, simplifies testing, and keeps the API surface explicit.

```typescript
export interface UserService {
  getUser(id: string): Promise<User>;
  createUser(input: CreateUserInput): Promise<User>;
  dispose(): Promise<void>;
}

export function createUserService({ repo, logger }: UserServiceDeps): UserService {
  async function getUser(id: string) { ... }
  async function createUser(input: CreateUserInput) { ... }
  async function dispose() { logger.info('UserService disposed'); }
  return { getUser, createUser, dispose };
}

export type UserServiceDeps = { repo: UsersRepository; logger: Logger };
```

- Export the return type as `export type UserService = ReturnType<typeof createUserService>` or define an explicit interface (prefer the interface for testability).
- Add a `dispose()` method to factories for resources deallocation (connections, timers).
- Use classes judiciously — only when framework contracts, `instanceof` checks, or true inheritance semantics are needed.

## Schemas with Zod, Types Derived

Define data shapes as Zod schemas; derive TypeScript types from them. Never duplicate type definitions.

```typescript
import { z } from 'zod';

export const userSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string().min(1).max(100),
});
export type User = z.infer<typeof userSchema>;

export const createUserInputSchema = userSchema.pick({ email: true, name: true });

export type CreateUserInput = z.infer<typeof createUserInputSchema>;

export const createUserResponseSchema = z.object({
  result: userSchema,
});

export type CreateUserResponse = z.output<typeof createUserResponseSchema>;
```

Use `schema.parse()` at trust boundaries — untrusted external inputs like HTTP bodies, env vars, and third-party API responses. Internally, trust typed values; don't re-validate what the type system already guarantees.

> Always use **context7** to check the latest Zod API when implementing schema features.

## Options Object Parameters

In general for functions with multiple parameters, prefer an options object, especially when a function has several parameters, multiple optional ones, or several same-typed primitives that are easy to accidentally swap.

```typescript
// ✅ Clear intent, easy to extend
function sendEmail({ to, subject, body, cc }: SendEmailOptions) { ... }

// ❌ Positional args prone to swap bugs
function sendEmail(to: string, subject: string, body: string, cc?: string) { ... }
```

also consider default values and destructuring for optional params:

```typescript
function someFunction({ required, optional = 'default' }: SomeFunctionOptions = {}) { ... }
```

## Dependency Injection via Parameters

Inject dependencies as a typed object parameter rather than importing shared singletons inside business logic. This decouples modules and makes them trivially testable in isolation.

```typescript
// ✅ All deps visible in the signature — easy to mock in tests
export function createOrderService({ repo, emailService, logger }: OrderServiceDeps) {
  ...
}
```

The composition root (e.g., `container.ts`) is the only place that creates and wires concrete implementations. See the `ts-backend-setup` skill for DI container wiring.

## Immutability

- Use `const` over `let`; never `var`.
- Prefer `readonly` on object/array properties where mutation is not intended.
- Use non-mutating array methods (`map`, `filter`, `reduce`) over `push`/`splice`.
- Use `as const` for literal unions and config objects.

```typescript
const STATUS = { ACTIVE: 'active', INACTIVE: 'inactive' } as const;
type Status = (typeof STATUS)[keyof typeof STATUS];
```

## Typed Error Hierarchy

Define a base error class and domain-specific subclasses. Include a machine-readable numerical `code` and support `cause` for chaining. `code` can be used for mapping to transport-level responses (HTTP status, gRPC code, etc.).

```typescript
type AppErrorOptions = ErrorOptions;

export class AppError extends Error {
  constructor(
    message: string,
    public readonly code: number,
    options?: AppErrorOptions
  ) {
    super(message, options);
    this.name = new.target.name;
    Error.captureStackTrace?.(this, this.constructor);
  }
}

export class NotFoundError extends AppError {
  constructor(message = 'Not found', options?: AppErrorOptions) {
    super(message, status.NOT_FOUND, options);
  }
}
```

Catch errors centrally (e.g., a framework error hook) and map `AppError` subclasses to transport-level responses (HTTP status, gRPC code, etc.).

## Type Imports

Use `import type` for type-only imports to keep runtime bundles lean and clarify intent:

```typescript
import type { FastifyInstance } from 'fastify';
import { createUserService, type UserService } from '@/modules/users/users-service.js';
```

## Discriminated Unions for State

Model states with discriminated unions rather than optional fields. Use a `never` check to catch unhandled cases at compile time:

```typescript
type Result<T> =
  | { status: 'ok'; data: T }
  | { status: 'error'; error: AppError };

function assertNever(x: never): never {
  throw new Error(`Unhandled case: ${String(x)}`);
}

switch (result.status) {
  case 'ok': return result.data;
  case 'error': throw result.error;
  default: return assertNever(result);
}
```

## Prefer `unknown` Over `any`

At catch blocks and external boundaries, use `unknown` rather than `any`. This forces explicit narrowing before use:

```typescript
try {
  ...
} catch (e: unknown) {
  if (e instanceof AppError) throw e;
  throw new AppError('Unexpected error', 'INTERNAL', { cause: e });
}
```

## Key Rules

| Rule | Rationale |
|------|-----------|
| Prefer factory functions for services | Avoids `this` bugs, easy to mock |
| Options object for multi-param fns | Prevents swap bugs, easy to extend |
| Zod at external trust boundaries | Validate untrusted input, trust internals |
| Inject all deps via parameter | Testable without coupling to globals |
| `readonly` + `as const` | Prevents accidental mutation |
| Typed errors + `assertNever` | Exhaustive handling, consistent responses |
