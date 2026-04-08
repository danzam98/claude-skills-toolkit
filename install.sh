#!/bin/bash
set -euo pipefail

# Claude + Codex Skills Toolkit Installer (Mac/Linux)
#
# Installs skills to Claude Code (~/.claude/skills) and/or
# Codex CLI (~/.codex/skills). Both CLIs use the same SKILL.md
# directory format, so the same source files work in both.

CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
CODEX_SKILLS_DIR="$HOME/.codex/skills"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/skills"

show_help() {
  cat <<EOF
Claude + Codex Skills Toolkit Installer

Usage: ./install.sh [OPTIONS] [SKILL_NAMES...]

Options:
  --all, -a              Install all skills (default if no skills specified)
  --list, -l             List available skills
  --force, -f            Overwrite existing skills without prompting
  --target TARGET        Where to install: claude, codex, or both
                         (default: both)
  --help, -h             Show this help message

Examples:
  ./install.sh                                  Install all skills to Claude + Codex
  ./install.sh --all --force                    Install all, overwrite existing
  ./install.sh --target=claude fresh-eyes       Install only to Claude Code
  ./install.sh --target=codex bug-hunt          Install only to Codex CLI
  ./install.sh -f peer-review                   Install with overwrite

Available skills:
EOF
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

install_skill_to_target() {
  local skill_name="$1"
  local force="$2"
  local target_root="$3"
  local target_label="$4"
  local skill_dir="$SOURCE_DIR/$skill_name"
  local target_dir="$target_root/$skill_name"

  if [ ! -d "$skill_dir" ]; then
    echo "Error: Skill '$skill_name' not found"
    return 1
  fi

  if [ -d "$target_dir" ]; then
    if [ "$force" = "true" ]; then
      rm -rf "$target_dir"
      cp -r "$skill_dir" "$target_dir"
      OVERWRITTEN+=("$skill_name [$target_label]")
    else
      echo -n "Skill '$skill_name' already exists in $target_label. Overwrite? [y/N] "
      read -r response
      if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "$target_dir"
        cp -r "$skill_dir" "$target_dir"
        OVERWRITTEN+=("$skill_name [$target_label]")
      else
        SKIPPED+=("$skill_name [$target_label]")
      fi
    fi
  else
    cp -r "$skill_dir" "$target_dir"
    INSTALLED+=("$skill_name [$target_label]")
  fi
}

install_skill() {
  local skill_name="$1"
  local force="$2"
  for target in "${TARGETS[@]}"; do
    case "$target" in
      claude) install_skill_to_target "$skill_name" "$force" "$CLAUDE_SKILLS_DIR" "claude" ;;
      codex)  install_skill_to_target "$skill_name" "$force" "$CODEX_SKILLS_DIR"  "codex"  ;;
    esac
  done
}

# Track installation results
INSTALLED=()
SKIPPED=()
OVERWRITTEN=()

# Parse arguments
FORCE=false
INSTALL_ALL=false
SKILLS_TO_INSTALL=()
TARGET_CHOICE="both"

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
    --target=*)
      TARGET_CHOICE="${1#*=}"
      shift
      ;;
    --target)
      if [ $# -lt 2 ]; then
        echo "Error: --target requires an argument (claude, codex, or both)"
        exit 1
      fi
      TARGET_CHOICE="$2"
      shift 2
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

# Resolve target list
case "$TARGET_CHOICE" in
  claude) TARGETS=(claude) ;;
  codex)  TARGETS=(codex) ;;
  both)   TARGETS=(claude codex) ;;
  *)
    echo "Error: --target must be one of: claude, codex, both"
    exit 1
    ;;
esac

# Create needed target dirs
for target in "${TARGETS[@]}"; do
  case "$target" in
    claude) mkdir -p "$CLAUDE_SKILLS_DIR" ;;
    codex)  mkdir -p "$CODEX_SKILLS_DIR" ;;
  esac
done

# If no skills specified and not --all, default to all
if [ ${#SKILLS_TO_INSTALL[@]} -eq 0 ]; then
  INSTALL_ALL=true
fi

echo "Claude + Codex Skills Toolkit Installer"
echo "========================================"
echo "Targets: ${TARGETS[*]}"
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
  for target in "${TARGETS[@]}"; do
    case "$target" in
      claude) echo "Claude Code skills: $CLAUDE_SKILLS_DIR" ;;
      codex)  echo "Codex CLI skills:   $CODEX_SKILLS_DIR" ;;
    esac
  done
  echo ""
  echo "Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)"
  echo "Restart Claude Code or Codex CLI to load the new skills."
else
  echo ""
  echo "No skills were installed."
fi
