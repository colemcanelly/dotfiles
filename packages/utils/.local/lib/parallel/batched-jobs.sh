
MAX_JOBS=$(nproc)
CURRENT_JOBS=0

batched_job() {
    ((CURRENT_JOBS++))

    if ((CURRENT_JOBS >= MAX_JOBS)); then
        wait -n
        ((CURRENT_JOBS--))
    fi
}
