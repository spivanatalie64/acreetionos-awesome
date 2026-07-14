#!/bin/bash
set -e
WORK=$(mktemp -d)
ISO_NAME="AcreetionOS-Awesome-$(date +%Y%m%d)-x86_64.iso"
SCRIPT="/tmp/buildawesome.sh"
OUTDIR="/tmp/ac-awesome-output"
mkdir -p "$OUTDIR"

echo "=== Building $ISO_NAME ==="

cat > "$SCRIPT" << 'INNER'
#!/bin/bash
set -e
pacman -Sy --noconfirm archiso git

git clone https://github.com/acreetionos-code/acreetionos.git /source
cd /source

sed -i 's/iso_name=.*/iso_name="AcreetionOS-Awesome"/' profiledef.sh
sed -i 's/iso_label=.*/iso_label="AC-AWESOME"/' profiledef.sh

cat > packages.x86_64 << 'PKGS'
base
base-devel
linux
linux-firmware
grub
efibootmgr
networkmanager
network-manager-applet
awesome
picom
rofi
dunst
kitty
thunar
firefox
pipewire
pipewire-pulse
wireplumber
polkit-kde-agent
feh
flameshot
pavucontrol
playerctl
brightnessctl
numlockx
papirus-icon-theme
ttf-jetbrains-mono-nerd
ttf-roboto
noto-fonts
noto-fonts-emoji
nano
sudo
git
wget
curl
PKGS

cat > pacman.conf << 'PACMAN'
[options]
Architecture = x86_64
SigLevel = Never

[core]
Server = https://mirror.archlinux32.org/x86_64/$repo
Include = /etc/pacman.d/mirrorlist

[extra]
Server = https://mirror.archlinux32.org/x86_64/$repo
Include = /etc/pacman.d/mirrorlist

[community]
Server = https://mirror.archlinux32.org/x86_64/$repo
Include = /etc/pacman.d/mirrorlist
PACMAN

find /work -path "*/__pycache__/*" -delete 2>/dev/null || true
mkdir -p /work/x86_64/airootfs 2>/dev/null || true
mkarchiso -v -w /work -o /output .
INNER

chmod +x "$SCRIPT"
docker run --privileged --rm -v "$SCRIPT:$SCRIPT" -v "$OUTDIR:/output" archlinux:latest bash "$SCRIPT" 2>&1

ISO=$(find "$OUTDIR" -name "*.iso" 2>/dev/null | head -1)
if [ -n "$ISO" ]; then
  cp "$ISO" "./$ISO_NAME"
  echo "ISO produced: $ISO_NAME"
else
  echo "No ISO found in $OUTDIR"
  ls -la "$OUTDIR" 2>/dev/null || true
fi
echo "=== Complete ==="
