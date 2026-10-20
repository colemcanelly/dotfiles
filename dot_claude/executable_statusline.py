#!/usr/bin/env python3
import sys, json

try:
    data = json.loads(sys.stdin.read())

    model = data["model"]["display_name"]
    cost = data["cost"]["total_cost_usd"]
    context_pct = data["context_window"]["used_percentage"]

    # Use arrow up and down for input and output tokens, respectively
    input_tokens = data["context_window"]["total_input_tokens"]
    output_tokens = data["context_window"]["total_output_tokens"]
    total_tokens = input_tokens + output_tokens

    input_tokens_k = input_tokens / 1000
    output_tokens_k = output_tokens / 1000
    total_tokens_k = total_tokens / 1000

    context_str = f"{context_pct}% \033[2m(↑{input_tokens_k:.1f}k ↓{output_tokens_k:.1f}k)\033[0m"


    print(f"{model} | {context_str} | ${cost:.2f}")
except Exception:
    print(f"Claude Code Session Active")
