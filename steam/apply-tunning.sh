#!/usr/bin/env bash
# Applies steam/tunning.md item 5 (gaming.conf, dxvk.conf, ananicy-cpp, ADIOS scheduler). Run as root.
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Must be run as root, e.g.: sudo $0" >&2
    exit 1
fi

TARGET_USER="${SUDO_USER:-}"
if [[ -z "$TARGET_USER" || "$TARGET_USER" == "root" ]]; then
    echo "Run this with sudo as your normal user (SUDO_USER is not set)." >&2
    exit 1
fi
TARGET_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
if [[ -z "$TARGET_HOME" ]]; then
    echo "Could not resolve home directory for user '$TARGET_USER'." >&2
    exit 1
fi

KERNEL_VERSION=$(uname -r)
echo "Detected kernel: $KERNEL_VERSION"

# --- 4. gaming.conf ---
GAMING_CONF_DIR="$TARGET_HOME/.config/environment.d"
GAMING_CONF="$GAMING_CONF_DIR/gaming.conf"
install -d -o "$TARGET_USER" -g "$TARGET_USER" "$GAMING_CONF_DIR"
cat > "$GAMING_CONF" <<'EOF'
__GL_SHADER_DISK_CACHE_SIZE=12000000000
__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
DXVK_CONFIG_FILE=${HOME}/.config/dxvk/dxvk.conf
DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION=RENDER_PRESET_K
PROTON_DLSS_INDICATOR=1
PROTON_DLSS_UPGRADE=1
#PROTON_LOG=1
EOF
chown "$TARGET_USER:$TARGET_USER" "$GAMING_CONF"
echo "Wrote $GAMING_CONF (owner: $TARGET_USER)"

# --- 5. dxvk.conf ---
DXVK_CONF_DIR="$TARGET_HOME/.config/dxvk"
DXVK_CONF="$DXVK_CONF_DIR/dxvk.conf"
install -d -o "$TARGET_USER" -g "$TARGET_USER" "$DXVK_CONF_DIR"
cat > "$DXVK_CONF" <<'EOF'
dxvk.maxFrameRate = 160
EOF
chown "$TARGET_USER:$TARGET_USER" "$DXVK_CONF"
echo "Wrote $DXVK_CONF (owner: $TARGET_USER)"

# --- 7. disable ananicy-cpp ---
if systemctl list-unit-files 'ananicy-cpp.service' --no-legend 2>/dev/null | grep -q .; then
    systemctl disable --now ananicy-cpp
    echo "Disabled ananicy-cpp"
else
    echo "ananicy-cpp not installed, skipping"
fi

# --- 8. ADIOS I/O scheduler for NVMe (availability depends on kernel, e.g. linux-cachyos) ---
adios_available=false
for sched_file in /sys/block/nvme*n1/queue/scheduler; do
    [[ -e "$sched_file" ]] || continue
    if grep -qw adios "$sched_file"; then
        adios_available=true
        break
    fi
done

if $adios_available; then
    RULE_FILE="/etc/udev/rules.d/60-ioschedulers.rules"
    cat > "$RULE_FILE" <<'EOF'
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="adios"
EOF
    udevadm control --reload-rules
    udevadm trigger
    echo "Applied ADIOS scheduler rule ($RULE_FILE)"
else
    echo "ADIOS scheduler not available on kernel $KERNEL_VERSION (needs a CachyOS kernel), skipping."
fi

echo "Done."
