#!/bin/bash
set -euo pipefail

# Claude Skills Toolkit Installer (Mac/Linux)

SKILLS_DIR="$HOME/.claude/skills"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/skills"

echo "Claude Skills Toolkit Installer"
echo "================================"
echo ""

# Create skills directory if it doesn't exist
if [ ! -d "$SKILLS_DIR" ]; then
  echo "Creating $SKILLS_DIR..."
  mkdir -p "$SKILLS_DIR"
fi

# Track installation results
INSTALLED=()
SKIPPED=()
OVERWRITTEN=()

# Install each skill
for skill_dir in "$SOURCE_DIR"/*; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    target_dir="$SKILLS_DIR/$skill_name"

    if [ -d "$target_dir" ]; then
      # Skill already exists - ask user
      echo -n "Skill '$skill_name' already exists. Overwrite? [y/N] "
      read -r response
      if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "$target_dir"
        cp -r "$skill_dir" "$target_dir"
        OVERWRITTEN+=("$skill_name")
      else
        SKIPPED+=("$skill_name")
      fi
    else
      # New installation
      cp -r "$skill_dir" "$target_dir"
      INSTALLED+=("$skill_name")
    fi
  fi
done

# Print summary
echo ""
echo "Installation Summary"
echo "===================="

if [ ${#INSTALLED[@]} -gt 0 ]; then
  echo "Installed (${#INSTALLED[@]}):"
  for skill in "${INSTALLED[@]}"; do
    echo "  ✓ $skill"
  done
fi

if [ ${#OVERWRITTEN[@]} -gt 0 ]; then
  echo "Overwritten (${#OVERWRITTEN[@]}):"
  for skill in "${OVERWRITTEN[@]}"; do
    echo "  ↻ $skill"
  done
fi

if [ ${#SKIPPED[@]} -gt 0 ]; then
  echo "Skipped (${#SKIPPED[@]}):"
  for skill in "${SKIPPED[@]}"; do
    echo "  - $skill"
  done
fi

echo ""
echo "Skills installed to: $SKILLS_DIR"
echo ""
echo "Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)"
echo "Restart Claude Code to load the new skills."
