#!/bin/sh
# Prints one rules file as a hook's additionalContext, for hooks.json.
#
#   emit-rules.sh <hook event name> <file, relative to the plugin root>
#
# JSON rather than plain stdout: SessionStart would take plain text, but
# SubagentStart reads only hookSpecificOutput.additionalContext. POSIX sh and
# awk only, so it runs the same under Git Bash on Windows, macOS's BSD awk and
# Linux. The escaping copies one character at a time instead of using gsub,
# whose handling of backslashes in the replacement differs between awks.
# Reads only the plugin's own file and touches no network.
set -eu

event=$1
file="${CLAUDE_PLUGIN_ROOT:?}/$2"

awk -v event="$event" '
function esc(s,    out, i, c) {
	out = ""
	for (i = 1; i <= length(s); i++) {
		c = substr(s, i, 1)
		if (c == "\\") out = out "\\\\"
		else if (c == "\"") out = out "\\\""
		else if (c == "\t") out = out "\\t"
		else if (c == "\r") out = out "\\r"
		else out = out c
	}
	return out
}
BEGIN { printf "{\"hookSpecificOutput\":{\"hookEventName\":\"%s\",\"additionalContext\":\"", event }
{ printf "%s\\n", esc($0) }
END { printf "\"}}\n" }
' "$file"
