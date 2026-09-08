#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Starting Sapiens: The Great Crossing in Godot 4..."
godot --path "$SCRIPT_DIR"
