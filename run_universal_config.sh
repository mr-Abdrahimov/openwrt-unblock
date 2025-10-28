#!/bin/sh

DESCRIPTION=$(ubus call system board | jsonfilter -e '@.release.description')
VERSION=$(ubus call system board | jsonfilter -e '@.release.version')
findKey="RouteRich"
findVersion="24.10.2"

if echo "$DESCRIPTION" | grep -qi -- "$findKey" && printf '%s\n%s\n' "$findVersion" "$VERSION" | sort -V | tail -n1 | grep -qx -- "$VERSION"; then
	printf "\033[32;1mThis new firmware. Running new scprit...\033[0m\n"
	wget --no-check-certificate -O /tmp/universal_config_new_podkop.sh https://raw.githubusercontent.com/routerich/RouterichAX3000_configs/refs/heads/new_awg_podkop/universal_config_new_podkop.sh && chmod +x /tmp/universal_config_new_podkop.sh && /tmp/universal_config_new_podkop.sh $1 $2
else
	printf "\033[32;1mThis old firmware.\nRecommendation, upgrade firmware to actual release...\nSleep 5 sec...\033[0m\n"
	sleep 5
	printf "\033[32;1mRunning old scprit...\033[0m\n"
	wget --no-check-certificate -O /tmp/universal_config.sh https://raw.githubusercontent.com/mr-Abdrahimov/openwrt-unblock/refs/heads/main/universal_config.sh && chmod +x /tmp/universal_config.sh && /tmp/universal_config.sh $1 $2
fi
