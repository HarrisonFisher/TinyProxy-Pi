#!/bin/bash
# TinyProxy-Pi Installer Script
# By: Harrison Fisher
# Licensed under the MIT License
# See LICENSE file for details
set -e

# === Default Configuration ===
USERNAME="proxyuser"
PASSWORD="proxypass"
PORT=8888
MAXCLIENTS=100
MINSPARE=5
MAXSPARE=20
STARTSERVERS=10
MAXREQPERCHILD=0
TIMEOUT=600
LOGLEVEL="Info"

# === Help Message ===
usage() {
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  --username <name>           Proxy username (default: proxyuser)"
    echo "  --password <pass>           Proxy password (default: proxypass)"
    echo "  --port <port>               Listening port (default: 8888)"
    echo "  --maxclients <num>          Max clients (default: 100)"
    echo "  --minspare <num>            Min spare servers (default: 5)"
    echo "  --maxspare <num>            Max spare servers (default: 20)"
    echo "  --startservers <num>        Start servers (default: 10)"
    echo "  --maxreqperchild <num>      Max requests per child (default: 0 = unlimited)"
    echo "  --timeout <seconds>         Timeout (default: 600)"
    echo "  --loglevel <level>          Log level (default: Info)"
    echo "  --help                      Show this help message"
    echo
    echo "Example:"
    echo "  $0 --username myuser --password mypass --port 8080 --maxclients 200 --loglevel Debug"
    exit 0
}

# === Parse Arguments ===
while [[ $# -gt 0 ]]; do
    case "$1" in
        --username) USERNAME="$2"; shift 2 ;;
        --password) PASSWORD="$2"; shift 2 ;;
        --port) PORT="$2"; shift 2 ;;
        --maxclients) MAXCLIENTS="$2"; shift 2 ;;
        --minspare) MINSPARE="$2"; shift 2 ;;
        --maxspare) MAXSPARE="$2"; shift 2 ;;
        --startservers) STARTSERVERS="$2"; shift 2 ;;
        --maxreqperchild) MAXREQPERCHILD="$2"; shift 2 ;;
        --timeout) TIMEOUT="$2"; shift 2 ;;
        --loglevel) LOGLEVEL="$2"; shift 2 ;;
        --help) usage ;;
        *) echo "❌ Unknown option: $1"; usage ;;
    esac
done

# === Show Summary ===
echo "🔧 Setting up TinyProxy with:"
echo "   Username:           $USERNAME"
echo "   Password:           $PASSWORD"
echo "   Port:               $PORT"
echo "   MaxClients:         $MAXCLIENTS"
echo "   MinSpareServers:    $MINSPARE"
echo "   MaxSpareServers:    $MAXSPARE"
echo "   StartServers:       $STARTSERVERS"
echo "   MaxReqPerChild:     $MAXREQPERCHILD"
echo "   Timeout:            $TIMEOUT"
echo "   LogLevel:           $LOGLEVEL"
echo

# === Install TinyProxy ===
sudo apt update -y
sudo apt install -y tinyproxy curl

# === Generate Configuration ===
sudo bash -c "cat > /etc/tinyproxy/tinyproxy.conf" <<EOF
User nobody
Group nogroup
Port ${PORT}
Timeout ${TIMEOUT}
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatFile "/usr/share/tinyproxy/stats.html"
LogFile "/var/log/tinyproxy/tinyproxy.log"
LogLevel ${LOGLEVEL}
PidFile "/run/tinyproxy/tinyproxy.pid"
MaxClients ${MAXCLIENTS}
MinSpareServers ${MINSPARE}
MaxSpareServers ${MAXSPARE}
StartServers ${STARTSERVERS}
MaxRequestsPerChild ${MAXREQPERCHILD}
Allow 0.0.0.0/0
BasicAuth ${USERNAME} ${PASSWORD}
ViaProxyName "TinyProxyPi"
EOF

# === Enable + Restart ===
sudo systemctl enable tinyproxy
sudo systemctl restart tinyproxy

# === Display Connection Info ===
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo
echo "✅ TinyProxy installation complete!"
echo "---------------------------------------"
echo "Local network proxy (LAN use):"
echo "http://${USERNAME}:${PASSWORD}@${LOCAL_IP}:${PORT}"
echo "---------------------------------------"
echo
