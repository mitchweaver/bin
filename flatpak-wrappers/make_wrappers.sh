#!/bin/sh

BIN_DIR=~/.local/flatpak-wrappers
mkdir -p "$BIN_DIR"

# ====================================

while read -r line ; do

# skip comment / blank lines
[ "$line" ] || continue
case "$line" in
    '#'*|' '*)
        continue
esac

# shellcheck disable=2086
set -- $line

flatpak_name=$1
app_name=$2

echo "Creating: $BIN_DIR/$app_name"

cat > "$BIN_DIR/$app_name" <<EOF
#!/bin/sh
exec flatpak run -- "$flatpak_name"
EOF

chmod +x "$BIN_DIR/$app_name"

done < ./apps.txt

# ======================================

printf "\nDone. Don't forget to add %s to your \$PATH\n" "$BIN_DIR"

