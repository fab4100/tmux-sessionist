#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# global variable
if [ "$#" -ne 2 ]; then
    echo "Need 2 args (session_name & session_path)"
    exit 0
fi
SESSION_NAME="$1"
SESSION_PATH="$2"

source "$CURRENT_DIR/helpers.sh"

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

create_new_tmux_session() {
	if session_name_not_provided; then
		exit 0
	elif session_exists_exact; then
		switch_to_session "$SESSION_NAME"
		display_message "Switched to existing session ${SESSION_NAME}" "2000"
	else
		TMUX="" tmux -S "$(tmux_socket)" new-session -d -s "$SESSION_NAME" -c "$SESSION_PATH"
		switch_to_session "$SESSION_NAME"
	fi
}

main() {
	create_new_tmux_session
}
main
