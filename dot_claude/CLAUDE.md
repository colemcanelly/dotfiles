# Tool Usage Guidelines

## Code Search and Navigation Rules

> These rules govern **finding and navigating code**, not reading code that
has already been located.

Before performing code search, symbol lookup, definition lookup, reference
lookup, or code navigation, you MUST first load the LSP tools:

`ToolSearch("select:LSP")`

Do not use Bash, `rg`, `ast-grep`, `fd`, `find`, or `grep` to find or
navigate code when the LSP can perform the operation.

### Tier 1 — LSP/MCP

Use the LSP/MCP tools for:

- Finding symbols
- Finding definitions
- Finding references/usages
- Determining callers/callees
- Inspecting symbol information
- Navigating between related code

Available operations:

- `workspaceSymbol`
- `findReferences`
- `goToDefinition`
- `hover`
- `incomingCalls`
- `outgoingCalls`

### Tier 2 — ast-grep

If LSP cannot find the target, explicitly state that LSP was unable to find
it, then use `ast-grep` as the fallback. Prefer structural AST patterns.

### Tier 3 — ripgrep

Use `rg` only if both LSP and `ast-grep` fail, or when one of the
pre-approved scenarios below applies.

Even for an approved scenario, ALWAYS ask the user for explicit permission
before executing `rg`.

### Strict Grep Ban

Never use the built-in `Grep` tool or the Bash `grep` command.

## Source Reading

Once LSP has identified the relevant file and location, you MAY use Bash to
read a narrowly scoped region of that file.

Prefer:

```bash
sed -n 'START,ENDp' file
```

Never use:

```bash
cat file | sed -n 'START,ENDp'
```

Do not read an entire source file merely to locate something that LSP should
have found.

Think of the workflow as:

1. **Find it** → LSP
2. **Navigate to it** → LSP
3. **Read a located implementation** → `sed` / Read, using the smallest useful region
4. **LSP cannot find it** → ast-grep
5. **ast-grep cannot find it** → `rg` with permission

Do not reverse this order.

## Acceptable Scenarios for Ripgrep (rg)

You may request permission to use `rg` for non-structural, non-symbol
searches where LSP and AST tools are ineffective:

* **Literal String Searches** — UI copy, localized strings, error messages,
  or raw console log phrases.
* **Configuration & Environment Audits** — specific values, flags, or keys in
  `.env`, Dockerfile, YAML, JSON, TOML, etc.
* **Comment & Documentation Searches** — raw text in comments, JSDoc, or
  Markdown.
* **Regex-based Global Audits** — raw regex match counts that do not align
  with language syntax symbols.
* **Project Logs** — raw application logs or build output.

## Exploration

@docs/exploration.md

## Available 3rd Party Tools

@docs/preferred-cli-tools.md
