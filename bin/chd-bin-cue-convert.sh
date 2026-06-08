#!/bin/bash
set -e

DIR="${1:-.}"
cd "$DIR"

# Process each .7z file recursively
find . -name "*.7z" -not -path "./.*" -print0 | while IFS= read -r -d '' archive; do
  base="$(basename "$archive" .7z)"
  dir="$(dirname "$archive")"
  echo "=== Processing: $archive ==="

  # Create temp directory for extraction
  tmpdir="$(mktemp -d ".tmp_extract_XXXXXXXX")"

  echo "  Extracting..."
  7za x "$archive" -o"$tmpdir" -y > /dev/null 2>&1

  # Find the .cue file
  cue_file=$(find "$tmpdir" -name "*.cue" -maxdepth 2 | head -1)
  if [ -z "$cue_file" ]; then
    echo "  WARNING: No .cue file found in $archive, skipping"
    rm -rf "$tmpdir"
    continue
  fi

  chd_file="$dir/${base}.chd"
  if [ -f "$chd_file" ]; then
    echo "  SKIP: $chd_file already exists"
    rm -rf "$tmpdir"
    continue
  fi

  echo "  Converting to CHD..."
  chdman createcd -i "$cue_file" -o "$chd_file" --force 2>&1 | sed 's/^/    /'

  # Clean up temp files
  rm -rf "$tmpdir"
  echo "  Done: $chd_file"
done

# Process any pre-extracted directories (subdirectories with .cue files)
find . -maxdepth 3 -type d -not -path "./.*" -not -name ".tmp_extract_*" -print0 | while IFS= read -r -d '' dir; do
  cue_file=$(find "$dir" -maxdepth 1 -name "*.cue" 2>/dev/null | head -1)
  if [ -n "$cue_file" ]; then
    chd_file="${dir}.chd"
    if [ -f "$chd_file" ]; then
      echo "=== SKIP: $chd_file already exists (from $dir/) ==="
    else
      echo "=== Processing extracted directory: $dir/ ==="
      chdman createcd -i "$cue_file" -o "$chd_file" --force 2>&1 | sed 's/^/    /'
      echo "  Done: $chd_file"
    fi
  fi
done

echo ""
echo "=== All conversions complete ==="
