# Colors
G="\e[1;32m"   # Green
R="\e[1;31m"   # Red
Y="\e[1;33m"   # Yellow
B="\e[1;34m"   # Blue
M="\e[1;35m"   # Magenta
C="\e[1;36m"   # Cyan
N="\e[0m"      # No Color

# Stylish Banner
clear
echo -e "$G"
echo " █████▒██▓ ██▓  ██████  ██░ ██  ▄▄▄       ██▓     "
echo "▓██   ▒▓██▒▓██▒▒██    ▒ ▓██░ ██▒▒████▄    ▓██▒     "
echo "▒████ ░▒██▒▒██▒░ ▓██▄   ▒██▀▀██░▒██  ▀█▄  ▒██░     "
echo "░▓█▒  ░░██░░██░  ▒   ██▒░▓█ ░██ ░██▄▄▄▄██ ▒██░     "
echo "░▒█░   ░██░░██░▒██████▒▒░▓█▒░██▓ ▓█   ▓██▒░██████▒ "
echo " ▒ ░   ░▓  ░▓  ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒▒   ▓▒█░░ ▒░▓  ░ "
echo " ░      ▒ ░ ▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░  ▒   ▒▒ ░░ ░ ▒  ░ "
echo " ░ ░    ▒ ░ ▒ ░░  ░  ░   ░  ░░ ░  ░   ▒     ░ ░    "
echo "        ░   ░        ░   ░  ░  ░      ░  ░    ░  ░ "
echo "      🔥 𝙑𝙄𝙎𝙃𝘼𝙇𝙓 - 𝙀𝙇𝙄𝙏𝙀 𝙎𝙉𝙄 𝙃𝙐𝙉𝙏𝙀𝙍 🔥"
echo -e "$N"

# Social Media
echo -e "$M"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃  👑 CREATED BY: 𝗩𝗜𝗦𝗛𝗔𝗟 (𝙊𝙛𝙛𝙞𝙘𝙞𝙖𝙡)   👑 ┃"
echo "┃  📷 Instagram: @official_vishal__007  ┃"
echo "┃  📢 Telegram: @officialvishal007      ┃"
echo "┃  🛠 𝙋𝙍𝙊 𝙃𝘼𝘾𝙆𝙀𝙍 𝙏𝙊𝙊𝙇 𝙁𝙊𝙍 𝙎𝙉𝙄 🔥   ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "$N"

# Temporary File for Working SNI List
working_snis=$(mktemp)
trap "rm -f $working_snis" EXIT  # Auto cleanup on exit

# Function to Check Hosts
check_host() {
    local host=$1
    local response=$(curl -4 -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" --connect-timeout 5 --max-time 5 -s -o /dev/null -w "%{http_code}" "https://$host")

    if [[ "$response" == "000" ]]; then
        echo -e "$R✖ $host   [$response]  - Dead ❌$N"
    else
        echo -e "$G✔ $host   [$response]  - Working ✅$N"
        echo "$host" >> "$working_snis"
    fi
}

# Main Menu
while true; do
    echo -e "$B"
    echo "┏━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo "┃    🔥 MAIN MENU 🔥    ┃"
    echo "┣━━━━━━━━━━━━━━━━━━━━━━━┫"
    echo "┃ 1️⃣ Single Scan        ┃"
    echo "┃ 2️⃣ Bulk Scan          ┃"
    echo "┃ 3️⃣ Show Working SNI   ┃"
    echo "┃ 4️⃣ Exit               ┃"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━┛"
    echo -e "$N"
    read -p "Select an option: " choice

    case $choice in
        1)
            read -p "Enter SNI to scan: " sni
            check_host "$sni"
            ;;
        2)
            read -p "Enter file path for bulk scan: " file
            if [[ -f "$file" ]]; then
                mapfile -t hosts < "$file"
                for host in "${hosts[@]}"; do
                    check_host "$host" &
                    sleep 0.1
                done
                wait
            else
                echo -e "$R[✖] ERROR: File Not Found!$N"
            fi
            ;;
        3)
            echo -e "$Y[🚀] WORKING SNI LIST:$N"
            cat "$working_snis" | nl
            ;;
        4)
            break
            ;;
        *)
            echo -e "$R[✖] Invalid Option!$N"
            ;;
    esac
done

# Final Summary
echo -e "$M"
echo "━━━━━━━━━━━━━━━━━━━━━━━"
echo " 🔹 Powered by Dark Team 🔹"
echo "━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "$N"
