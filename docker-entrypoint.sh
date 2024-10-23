#!/bin/sh

# inspired by: https://github.com/docker-library/mysql/blob/master/docker-entrypoint.sh

log () {
    local type="$1"; shift
    # accept argument string or stdin
    local text="$*"; if [ "$#" -eq 0 ]; then text="$(cat)"; fi
    local dt; dt="$(date -Iseconds)"
    printf '%s [%s] [Entrypoint]: %s\n' "$dt" "$type" "$text"
}

error () {
    log ERROR "$@" >&2
    exit 1
}

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
    local var="$1"
    local fileVar="${var}_FILE"
    local def="${2:-}"
    
    if [ ! -z "$(eval "echo \"\$$var\"")" ] && [ ! -z "$(eval "echo \"\$$fileVar\"")" ]; then
	error "Both $var and $fileVar are set (but are exclusive)"
    fi
    local val="$def"
    
    if [ ! -z "$(eval "echo \"\$$var\"")" ]; then
	val="$(eval "echo \"\$$var\"")"
    elif [ ! -z "$(eval "echo \"\$$fileVar\"")" ]; then
	val="$(cat "$(eval "echo \"\$$fileVar\"")")"
    fi
    export "$var"="$val"
    unset "$fileVar"
}

docker_setup_env () {

    # Initialize values that might be stored in a file
    file_env 'DB_USER'
    file_env 'DB_PASSWORD'
}

_main () {
    docker_setup_env
    exec "$@"
}

_main "$@"
