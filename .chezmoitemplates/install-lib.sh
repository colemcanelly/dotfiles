# Shared by the install scripts: each step runs quietly, logs to its own file,
# and reports pass/fail. A failed step never aborts the script.
LOG_DIR={{ .chezmoi.sourceDir | quote }}/.logs
mkdir -p "$LOG_DIR"
FAILED=()



declare -A styles=(
	[bold]=1
	[red]=31
	[green]=32
	[yellow]=33
	[blue]=34
	[light-red]=91
	[light-green]=92
	[light-yellow]=93
	[light-blue]=94
)
for c in "${!styles[@]}"; do
	v="${styles[$c]}";
	eval "$c() { printf \$'\e[${v}m%s\e[0m' \"\$*\"; }";
done

if [[ -t 1 ]]; then
	PASS=$(green pass) FAIL=$(red fail) SKIP=$(yellow skip)
else
	PASS=pass FAIL=fail SKIP=skip
fi

cleanup() {
    pkill -P $$
    exit 1
}
trap cleanup SIGINT SIGTERM


# step <name> <cmd...>: run cmd with all output in $LOG_DIR/<name>.log
function step() {
	local name="$1"; shift
	local log="$LOG_DIR/$name.log"
	printf '# %s\n# %s\n' "$(date -Is)" "$*" > "$log"
	printf '    %s... ' "$name"

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
		echo "$name... $SKIP (no $cmd)"
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
