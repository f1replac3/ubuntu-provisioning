#!/usr/bin/env bash

LOCAL_IP=$(ip -br a | grep wlp | awk '{print $3}')
VPN_IP=$(ip -br a | grep tun0 | awk '{print $3}')
IP_OUTPUT1=$(ip -br -c a | awk 'NR==1 {print $1,$2,$3}')
IP_OUTPUT2=$(ip -br -c a | awk 'NR==2 {print $1,$2,$3}')
IP_OUTPUT3=$(ip -br -c a | awk 'NR==3 {print $1,$2,$3}')
IP_OUTPUT4=$(ip -br -c a | awk 'NR==4 {print $1,$2,$3}')
if ip link show tun0 | grep -q "UP"; then
    echo "<span weight='normal'><tt>tun0 </tt></span><span color='green' weight='normal'><small><tt>$VPN_IP</tt></small></span> | length=24"
else
   echo "<span weight='normal'><tt>Local </tt></span><span color='red' weight='normal'><small><tt>$LOCAL_IP</tt></small></span> | length=24"
fi

echo "---"

if [ "$ARGOS_MENU_OPEN" == "true" ]; then
    echo "$IP_OUTPUT1 | font=monospace bash=\"ip -br a | awk 'NR==1 {print \$3}'| sed 's#/.*##' | wl-copy; exit\" terminal=false"
    echo "$IP_OUTPUT2 | font=monospace bash=\"ip -br a | awk 'NR==2 {print \$3}'| sed 's#/.*##' | wl-copy; exit\" terminal=false"
    echo "$IP_OUTPUT3 | font=monospace bash=\"ip -br a | awk 'NR==3 {print \$3}'| sed 's#/.*##' | wl-copy; exit\" terminal=false"
    if ip link show tun0 | grep -q "UP"; then
        echo "$IP_OUTPUT4 | font=monospace bash=\"ip -br a | awk 'NR==4 {print \$3}'| sed 's#/.*##' | wl-copy; exit\" terminal=false"
    fi
else
    echo "Loading..."
fi

echo "---"
echo "View IP Output | bash='ip -c a'"
