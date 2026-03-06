# Random Code Exploration and Bug Hunt

I want you to sort of randomly explore the code files in this project, choosing code files to deeply investigate and understand and trace their functionality and execution flows through the related code files which they import or which they are imported by.

Once you understand the purpose of the code in the larger context of the workflows, I want you to do a super careful, methodical, and critical check with "fresh eyes" to find any obvious bugs, problems, errors, issues, silly mistakes, etc. and then systematically and meticulously and intelligently correct them.

Be sure to comply with ALL rules in AGENTS.md and ensure that any code you write or revise conforms to the best practice guides referenced in the AGENTS.md file. Use ultrathink.

## Exploration Strategy

1. Pick a random starting point:
   ```bash
   find src -name "*.tsx" -o -name "*.ts" | shuf | head -5
   ```
2. For each file:
   - Read it completely
   - Trace imports upstream
   - Trace exports downstream
   - Understand the full data/control flow
3. Look for:
   - Dead code
   - Unreachable branches
   - Incorrect assumptions
   - Missing validations
   - Hardcoded values that should be config
   - TODO/FIXME comments that were never addressed
