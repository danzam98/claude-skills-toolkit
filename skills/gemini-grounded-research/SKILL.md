# Gemini Grounded Research

Research using Gemini with Google Search grounding for real-time web information. Returns comprehensive answers with citations.

## What This Does

Calls Google's Gemini API with search grounding enabled to answer research questions using current web data. Perfect for:
- Current events and recent developments
- Product feature comparisons
- Technology research with citations
- Fact-checking with sources
- Market research

## How to Use

```
/gemini-grounded-research "Your research question here"
```

## Examples

```
/gemini-grounded-research "What are Slack's collaborative to-do list and reminder features in 2026?"
/gemini-grounded-research "Compare Stripe vs PayPal payment APIs"
/gemini-grounded-research "What new features did Anthropic Claude launch in 2026?"
```

## How It Works

1. Takes research query as argument
2. Calls Gemini 2.0 Flash via Generative Language API
3. Enables Google Search grounding via `google_search` tool
4. Returns comprehensive answer with web citations

## Prerequisites

- `curl` command-line tool
- `jq` JSON processor
- `GEMINI_API_KEY` environment variable set

To get an API key:
1. Go to https://aistudio.google.com/app/apikey
2. Create a new API key
3. Add to your shell profile: `export GEMINI_API_KEY="your-key-here"`

## Implementation

```bash
#!/bin/bash
set -euo pipefail

QUERY="$*"

if [ -z "$QUERY" ]; then
  echo "Usage: gemini-grounded-research \"your question\""
  exit 1
fi

if [ -z "${GEMINI_API_KEY:-}" ]; then
  echo "Error: GEMINI_API_KEY environment variable not set"
  exit 1
fi

# Call Gemini API with Google Search grounding
RESPONSE=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent" \
  -H "x-goog-api-key: $GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "contents": [{
    "parts": [{
      "text": "$QUERY"
    }]
  }],
  "tools": [{
    "google_search": {}
  }]
}
EOF
)

# Extract the response text
echo "$RESPONSE" | jq -r '.candidates[0].content.parts[] | select(.text != null) | .text' || {
  echo "Error parsing Gemini response:"
  echo "$RESPONSE" | jq .
  exit 1
}
```
