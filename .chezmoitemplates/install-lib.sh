# Shared by the install scripts: each step runs quietly, logs to its own file,
# and reports pass/fail. A failed step never aborts the script.
LOG_DIR={{ .chezmoi.sourceDir | quote }}/.logs
mkdir -p "$LOG_DIR"
FAILED=()

if [[ -t 1 ]]; then
	PASS=$'\e[32mpass\e[0m' FAIL=$'\e[31mfail\e[0m' SKIP=$'\e[33mskip\e[0m'
else
	PASS=pass FAIL=fail SKIP=skip
fi

# step <name> <cmd...>: run cmd with all output in $LOG_DIR/<name>.log
function step() {
	local name="$1"; shift
	local log="$LOG_DIR/$name.log"
	printf '# %s\n# %s\n' "$(date -Is)" "$*" > "$log"
	printf 'Installing %s... ' "$name"

	local code=0
	"$@" >>"$log" 2>&1 </dev/null || code=$?
	if (( code == 0 )); then
		echo "$PASS"
	else
		echo "$FAIL (exit $code, see $log)"
		FAILED+=("$name")
	fi
}

# need <cmd> <names...>: true if cmd exists, otherwise report each name as skipped
function need() {
	local cmd="$1"; shift
	command -v "$cmd" >/dev/null && return 0

	local name
	for name in "$@"; do
		echo "Installing $name... $SKIP (no $cmd)"
		FAILED+=("$name")
	done
	return 1
}

# summary <script source path>: list what didn't install and how to retry
function summary() {
	(( ${#FAILED[@]} )) || return 0
	echo
	echo "Not installed (${#FAILED[@]}): ${FAILED[*]}"
	echo "Logs:  $LOG_DIR"
	echo "Retry: bash <(chezmoi execute-template < '$1')"
}
