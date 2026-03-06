# Commit All Changes

Now, based on your knowledge of the project, commit all changed files now in a series of logically connected groupings with super detailed commit messages for each and then push.

Take your time to do it right. Don't edit the code at all. Don't commit obviously ephemeral files. Use ultrathink.

## Process

1. Review all changes:
   ```bash
   git status
   git diff
   ```

2. Group changes logically by:
   - Feature/component
   - Type (feat, fix, chore, docs, test)
   - Related functionality

3. For each group:
   ```bash
   git add <specific-files>
   git commit -m "$(cat <<'EOF'
   <type>(<scope>): <short description>

   <detailed body explaining:>
   - What was changed
   - Why it was changed
   - Any important implementation details

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

4. Verify before push:
   ```bash
   bun run typecheck
   bun run lint
   bun run build
   ```

5. Push if all checks pass:
   ```bash
   git push
   ```

## Files to NEVER Commit

- .env, .env.local (secrets)
- node_modules/
- .next/, out/ (build artifacts)
- *.log files
- .DS_Store
- Temporary/backup files
