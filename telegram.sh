#!/usr/bin/env bash
# vim: set number:
#------------------------------------------------------------------
# script: telegram_service_controller.sh
#
# description: This script listens for commands sent via Telegram and Controls
#              v3-ci systemd service based on Those commands.
#------------------------------------------------------------------

# shellcheck disable=SC1091
# shellcheck disable=SC1090
# shellcheck disable=SC2034

shopt -s lastpipe
shopt -s extdebug
if [[ -n "${DEBUG}" ]]; then
        set -x # DEBUGGING MODE
fi

if [[ -n "${VERBOSE}" ]]; then
        set -v # VERBOSE MODE
fi

if [[ -n "${SYNTAX_CHECK}" ]]; then
        set -n # CHECK SYNTAX WITHOUT RUNNING THE SCRIPT
fi

_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd "$(dirname "$(readlink "${BASH_SOURCE[0]}" || echo ".")")" && pwd)"

#===========================  Constants  ============================#

source "${_path}/.env_telegram"

export PATH=$PATH:/usr/sbin:/usr/bin:/sbin:/bin

readonly SERVICE_NAME="v3-ci-instance5.service"

#========================  Helper Functions  ========================#

source "${_path}/scripts/shared-bash-utilities/common.sh"

function control_service {
        local action="${1}"
        sudo systemctl "${action}" "${SERVICE_NAME}"
        return $?
}
#=============================  Main  ==============================#

#TODO: REFACT offset=0
while sleep 1; do
        response=$(curl -s -X GET "https://api.telegram.org/bot${API_TOKEN}/getUpdates?offset=${offset}" -d chat_id="${CHAT_ID}")

        update_id=$(echo $response | jq '.result[-1].update_id')
        message_text=$(echo $response | jq -r '.result[-1].message.text')

        if [ "$update_id" != "null" ]; then
                offset=$((update_id + 1))
                case "$message_text" in
                /start*)
                        echo "Received /start command"
                        service_status=$(control_service "is-active")
                        if [[ "$service_status" == "active" ]]; then
                                send_alert "Service ${SERVICE_NAME} is currently \
active. You can check the status with /status command,\
stop it with /stop command, and start it again with \
/start command."
                                continue
                        else
                                control_service "start"
                                service_status=$(control_service "is-active")
                                if [[ "$service_status" == "active" ]]; then
                                        send_alert "Service ${SERVICE_NAME} started successfully."
                                else
                                        send_alert "Failed to start service ${SERVICE_NAME}. Use /status command for more details."
                                fi
                        fi
                        ;;
                /stop*)
                        echo "Received /stop command" control_service "stop"
                        service_status=$(control_service "is-active")
                        if [[ "$service_status" == "inactive" ]]; then
                                send_alert "Service ${SERVICE_NAME} is currently inactive"
                        else
                                control_service "stop"
                                service_status=$(control_service "is-active")
                                if [[ "$service_status" == "inactive" ]]; then
                                        send_alert "Service ${SERVICE_NAME} stopped successfully."
                                else
                                        send_alert "Failed to stop service ${SERVICE_NAME}. Use /status command for more details."
                                fi
                        fi
                        ;;
                /status*)
                        echo "Received /status command"
                        service_status=$(control_service "is-active")
                        send_alert "Service ${SERVICE_NAME} is currently ${service_status}."
                        send_alert "$(control_service "status")"
                        ;;
                *)
                        echo "Received unknown command"
                        ;;
                esac
        fi
done
