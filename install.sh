#!/bin/bash
set -euo pipefail

# Claude Skills Toolkit Installer (Mac/Linux)

SKILLS_DIR="$HOME/.claude/skills"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/skills"

show_help() {
  echo "Claude Skills Toolkit Installer"
  echo ""
  echo "Usage: ./install.sh [OPTIONS] [SKILL_NAMES...]"
  echo ""
  echo "Options:"
  echo "  --all, -a       Install all skills (default if no skills specified)"
  echo "  --list, -l      List available skills"
  echo "  --force, -f     Overwrite existing skills without prompting"
  echo "  --help, -h      Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./install.sh                    # Install all skills (interactive)"
  echo "  ./install.sh --all --force      # Install all skills (overwrite existing)"
  echo "  ./install.sh fresh-eyes bug-hunt # Install specific skills"
  echo "  ./install.sh -f peer-review     # Install specific skill (overwrite if exists)"
  echo ""
  echo "Available skills:"
  list_skills
}

list_skills() {
  for skill_dir in "$SOURCE_DIR"/*; do
    if [ -d "$skill_dir" ]; then
      skill_name=$(basename "$skill_dir")
      echo "  - $skill_name"
    fi
  done
}

install_skill() {
  local skill_name="$1"
  local force="${2:-false}"
  local skill_dir="$SOURCE_DIR/$skill_name"
  local target_dir="$SKILLS_DIR/$skill_name"

  if [ ! -d "$skill_dir" ]; then
    echo "Error: Skill '$skill_name' not found"
    return 1
  fi

  if [ -d "$target_dir" ]; then
    if [ "$force" = "true" ]; then
      rm -rf "$target_dir"
      cp -r "$skill_dir" "$target_dir"
      OVERWRITTEN+=("$skill_name")
    else
      echo -n "Skill '$skill_name' already exists. Overwrite? [y/N] "
      read -r response
      if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "$target_dir"
        cp -r "$skill_dir" "$target_dir"
        OVERWRITTEN+=("$skill_name")
      else
        SKIPPED+=("$skill_name")
      fi
    fi
  else
    cp -r "$skill_dir" "$target_dir"
    INSTALLED+=("$skill_name")
  fi
}

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Track installation results
INSTALLED=()
SKIPPED=()
OVERWRITTEN=()

# Parse arguments
FORCE=false
INSTALL_ALL=false
SKILLS_TO_INSTALL=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --all|-a)
      INSTALL_ALL=true
      shift
      ;;
    --force|-f)
      FORCE=true
      shift
      ;;
    --list|-l)
      echo "Available skills:"
      list_skills
      exit 0
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    -*)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
    *)
      SKILLS_TO_INSTALL+=("$1")
      shift
      ;;
  esac
done

# If no skills specified and not --all, default to all
if [ ${#SKILLS_TO_INSTALL[@]} -eq 0 ]; then
  INSTALL_ALL=true
fi

echo "Claude Skills Toolkit Installer"
echo "================================"
echo ""

if [ "$INSTALL_ALL" = "true" ]; then
  echo "Installing all skills..."
  echo ""
  for skill_dir in "$SOURCE_DIR"/*; do
    if [ -d "$skill_dir" ]; then
      skill_name=$(basename "$skill_dir")
      install_skill "$skill_name" "$FORCE"
    fi
  done
else
  echo "Installing selected skills..."
  echo ""
  for skill_name in "${SKILLS_TO_INSTALL[@]}"; do
    install_skill "$skill_name" "$FORCE"
  done
fi

# Print summary
echo ""
echo "Installation Summary"
echo "===================="

if [ ${#INSTALLED[@]} -gt 0 ]; then
  echo "Installed (${#INSTALLED[@]}):"
  for skill in "${INSTALLED[@]}"; do
    echo "  + $skill"
  done
fi

if [ ${#OVERWRITTEN[@]} -gt 0 ]; then
  echo "Overwritten (${#OVERWRITTEN[@]}):"
  for skill in "${OVERWRITTEN[@]}"; do
    echo "  ~ $skill"
  done
fi

if [ ${#SKIPPED[@]} -gt 0 ]; then
  echo "Skipped (${#SKIPPED[@]}):"
  for skill in "${SKIPPED[@]}"; do
    echo "  - $skill"
  done
fi

TOTAL=$((${#INSTALLED[@]} + ${#OVERWRITTEN[@]}))
if [ $TOTAL -gt 0 ]; then
  echo ""
  echo "Skills installed to: $SKILLS_DIR"
  echo ""
  echo "Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)"
  echo "Restart Claude Code to load the new skills."
else
  echo ""
  echo "No skills were installed."
fi
