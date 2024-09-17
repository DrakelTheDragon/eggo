# shellcheck shell=bash

_log() {
    local level="$1"
    local message="$2"

    local timestamp
    timestamp="$(date +'%Y-%m-%d %H:%M:%S')"

    local source
    source="$(basename "${BASH_SOURCE[2]:-${BASH_SOURCE[1]}}")"

    if [[ "${level}" == "ERRO" ]]; then
        local lineno="${BASH_LINENO[1]:-${BASH_LINENO[0]}}"
        local funcname="${FUNCNAME[2]:-main}"
        printf '[%s] <%s.%s:%s> %s | %s\n' "$timestamp" "$source" "$funcname"  "$lineno" "$level" "$message"
    else
        printf '[%s] %s | %s\n' "$timestamp" "$level" "$message"
    fi
}

die() {
    _log "ERRO" "$1" >&2 && exit "${?:-1}"
}

say() {
    _log "INFO" "$1"
}
