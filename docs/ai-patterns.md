# AI & LLM Patterns

## Prompt Formatting
- Prompts are file-based — never inline long prompt strings in code
- Store prompts as `.md` or `.txt` files, loaded at runtime
- Use clear role/instruction/input separation in prompts
- Version prompts alongside code — changes to prompts are changes to behavior

## Anthropic / Claude API
- Always use `claude-sonnet-4-6` as the default model unless a specific reason to change
- Use typed Pydantic schemas for all LLM input/output — never raw dicts
- Set explicit `max_tokens` — never rely on defaults
- Handle rate limits and API errors explicitly with retry logic

## Ollama / Local Models
- Use Ollama for local model inference
- Model name must come from config/environment — never hardcoded
- Local models are for dev/testing; production uses the Anthropic API unless specified

## Agent & Tool Patterns
- Tools must have clear, descriptive names and docstrings — the LLM reads them
- Keep individual tools small and single-purpose
- Validate tool inputs and outputs with Pydantic
- Log all LLM calls (model, token usage, latency) for observability
- Never expose raw LLM output to end users without validation or sanitization
