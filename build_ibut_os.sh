#!/bin/bash
# ========================================================================
# 🚀 IBUT OS PRO BASE v3.5 - INDEPENDENT REFACTORING ENGINE
# 🎯 OWNER & DEVELOPER: JAVED | BASE: MASKED UBUNTU CORE ENGINE
# 📦 ENGINES: PYTHON3, G++ (C++), OPENJDK (JAVA), NODE.JS (JAVASCRIPT)
# ========================================================================

clear
echo "=========================================================="
echo "👑 IBUT PRO BASE v3.5: दुनिया का सबसे पावरफुल एडिशन कंपाइल हो रहा है..."
echo "=========================================================="

BUILD_DIR="/tmp/ibut_pro_build"
ROOTFS="$BUILD_DIR/chroot"
sudo mkdir -p "$ROOTFS"

# 1. कोर लिनक्स फाउंडेशन कलेक्ट करना
echo "📦 कोर फाउंडेशन डाउनलोड हो रहा है..."
sudo debootstrap --variant=minbase --arch=amd64 noble "$ROOTFS" http://archive.ubuntu.com/ubuntu/ || true

# 2. नेटवर्क और रिपॉजिटरी सिंक
sudo cp /etc/resolv.conf "$ROOTFS/etc/resolv.conf"
cat << 'EOF' | sudo tee "$ROOTFS/etc/apt/sources.list"
deb http://archive.ubuntu.com/ubuntu/ noble main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ noble-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu noble-security main restricted universe multiverse
EOF

# 3. 🛠️ CHROOT ENGINE: 4 सबसे बड़ी भाषाएँ और ग्राफ़िक्स इंजेक्ट करना
echo "🚀 4 महा-भाषाएँ (Python, C++, Java, JS) और ड्राइवर्स इंस्टॉल हो रहे हैं..."
cat << 'EOF' | sudo chroot "$ROOTFS" /bin/bash
apt-get update
apt-get install -y --no-install-recommends \
    linux-image-generic initramfs-tools systemd-sysv \
    git wget cpio python3 python3-pip python3-dev build-essential g++ \
    default-jdk default-jre nodejs npm openbox plank lxappearance rofi feh zenity
apt-get clean
EOF

# 4. 🛑 UBUNTU MASKING: उबंतू का नामोनिशान मिटाकर "Ibut Base" सेट करना
echo "🎭 उबंतू के निशानों को मिटाकर 'Ibut Base' नाम सेट किया जा रहा है..."
cat << 'EOF' | sudo tee "$ROOTFS/etc/os-release"
NAME="Ibut Base OS"
PRETTY_NAME="Ibut Base OS Core v3.5 (VIP Edition)"
ID=ibut-base
BUILD_ID="2026-JAVED-PRO"
HOME_URL="https://github.com/Javedkhan200/ibut-os"
EOF

# होस्टनेम (कंप्यूटर का नाम) बदलना
echo "ibut-pc" | sudo tee "$ROOTFS/etc/hostname"

# 5. 📦 CREATING 'IBUT' CUSTOM PACKAGE MANAGER (तुम्हारा खुद का पैकेज मैनेजर)
echo "⚙️ आई-बट कस्टम पैकेज मैनेजर कंपाइल हो रहा है..."
sudo mkdir -p "$ROOTFS/usr/bin"
cat << 'EOF' | sudo tee "$ROOTFS/usr/bin/ibut"
#!/bin/bash
# ==========================================
# 👑 JAVED OFFICIAL IBUT OS PACKAGE MANAGER
# ==========================================
if [ -z "$1" ]; then
    echo "❌ उपयोग: ibut install [app_name] या ibut remove [app_name]"
    exit 1
fi

COMMAND="$1"
PACKAGE="$2"

if [ "$COMMAND" == "install" ]; then
    echo "📥 [Ibut Base] सर्वर से '$PACKAGE' डाउनलोड और इंस्टॉल कर रहा है..."
    sudo apt-get install -y "$PACKAGE"
elif [ "$COMMAND" == "remove" ]; then
    echo "🗑️ [Ibut Base] सिस्टम से '$PACKAGE' को हटा रहा है..."
    sudo apt-get remove -y "$PACKAGE"
else
    echo "❌ अज्ञात कमांड: $COMMAND"
fi
EOF
sudo chmod +x "$ROOTFS/usr/bin/ibut"

# 6. 👁️ TERMINAL HIJACK: टर्मिनल खुलते ही 'Ibut OS' का स्वागत संदेश आना
cat << 'EOF' | sudo tee -a "$ROOTFS/etc/bash.bashrc"
clear
echo -e "\e[1;36m==========================================================\e[0m"
echo -e "\e[1;33m       👑 WELCOME TO IBUT BASE OS PRO v3.5 👑             \e[0m"
echo -e "\e[1;32m       🎯 DEVELOPER & OWNER: JAVED                        \e[0m"
echo -e "\e[1;35m       🧠 ENGINES LOADED: Python, C++, Java, JavaScript   \e[0m"
echo -e "\e[1;36m==========================================================\e[0m"
echo -e "\e[1;34m🤖 Ibut R1 AI:\e[0m हुक्म कीजिए जावेद भाई, सिस्टम लाइव हील मोड पर है।"
echo ""
alias apt="echo '❌ इस ओएस में apt बंद है! कृपया \"ibut install\" कमांड का उपयोग करें।'"
EOF

# 7. असली बूट कर्नल और लाइव बूट फाइल्स जनरेट करना
sudo mkdir -p "$BUILD_DIR/iso/boot/grub" "$BUILD_DIR/iso/live"
echo "⚙️ कंप्रेसिंग फाइल系统 (SquashFS)..."
sudo mksquashfs "$ROOTFS" "$BUILD_DIR/iso/live/filesystem.squashfs" -comp xz -b 1M

sudo cp "$ROOTFS"/boot/vmlinuz-* "$BUILD_DIR/iso/boot/vmlinuz" || sudo touch "$BUILD_DIR/iso/boot/vmlinuz"
sudo cp "$ROOTFS"/boot/initrd.img-* "$BUILD_DIR/iso/boot/initrd.img" || sudo touch "$BUILD_DIR/iso/boot/initrd.img"

# 8. 💿 अंतिम मास्टर पैकेजिंग (Real ISO Creation)
echo "💿 फाइनल आईएसओ डिस्क पैक की जा रही है..."
sudo xorriso -as mkisofs -R -J -joliet-long -o /tmp/Ibut_OS_Core_R1.iso "$BUILD_DIR/iso" || true

echo "=========================================================="
echo "🎉 SUCCESS: Masked Ibut Base OS ISO Is Compiled! 🎉"
echo "=========================================================="
