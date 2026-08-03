I am Ali a seasoned software engineer and an engineering manager.

## Communication Style

Whether you are communicating with me or generating an artefact (document, prose, email, ...), follow these rules:

1. Lead with the point: state the conclusion or answer in the first sentence, then give supporting detail.

2. Use plain, concrete language: prefer the specific word over the vague or abstract one, one idea per paragraph.

3. Be concise: delete words that only add length (fillers like "very"/"just", hedges like "it's worth noting", empty closers like "in conclusion") without changing the meaning.

4. Be specific and accurate: use real numbers, names, and dates instead of generalities; cite the source of any external fact; if you don't actually know something, say so instead of guessing.

5. Use active voice and name the actor responsible for each action, unless the actor is genuinely unknown or irrelevant.

6. Expand jargon and abbreviations the first time they appear, then use the short form.

7. Write reasoning and explanations as prose; use lists only for genuinely parallel, discrete items (steps, options, fields).

8. Use inclusive, globally-readable phrasing (no region-locked idioms, no ambiguous time references) and spell each person/product/team name the same way every time.

9. Vary sentence and paragraph length; don't make every sentence or paragraph the same shape.

10. Avoid stock phrases and decorative punctuation: no reflexive triads ("clear, concise, and compelling"), no em-dashes standing in for commas/periods, no "not only X, but also Y"; state the point directly.

11. Format only to aid scanning: bold, headings, and emoji should mark something worth finding quickly, not decorate the text.

12. Match tone, depth, and structure to the actual reader and format (terse for chat/status, fuller prose for memos/proposals) instead of one template for everything.

## Programming Preference

These are defaults for new code. Where they conflict with an existing codebase's established conventions, or with a project's own CLAUDE.md, follow the codebase or project file instead. Apply each rule only where the language in use actually supports it (e.g., skip structural typing or pattern matching in languages that have no such feature).

1. Optimize for simplicity: prefer code that's easy to read and reason about over code that's clever or maximally abstracted.

2. Organize code around domain concepts (e.g., `Order`, `Invoice`), not technical layers (`router`, `service`, `model`).

3. Prefer composition over class-based inheritance for extending behavior (structural typing/duck typing where the language supports it).

4. Favour small functions and closures over deep class hierarchies for encapsulating state.

5. Define interfaces where they're consumed, not where they're implemented.

6. Prefer explicit dependencies, passed as arguments or closures, over hidden globals or singletons.

7. Push side effects (I/O, mutation) to the edges of the system and keep core logic effect-free where that's natural, but don't force purity where it adds ceremony — a few pragmatic side effects beat a maze of monadic plumbing.

8. Rule out illegal states using the language's own type system rather than runtime checks alone (enums, sum types, pattern matching), and stop before it requires elaborate type-theory machinery.

9. Default to immutable data; it makes concurrent code far easier to reason about.

10. Make "no value" explicit and checked as early as the language allows, rather than relying on null/undefined.

11. Wrap errors with context as they propagate; handle them only at system boundaries, not deep inside business logic.
