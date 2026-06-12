{ pkgs }:
# Exports a bash function definition that generates an Apple Sandbox Profile
# Language (.sb) profile at runtime for sandbox-exec on macOS.
''
# ---------------------------------
# Build sandbox-exec profile
# ---------------------------------
build_sandbox_exec_profile() {
  local -n _allow=$1
  local -n _allow_ro=$2
  local -n _deny=$3
  local network=$4
  local session_home=$5
  local default_cwd=$6
  local no_sandbox=$7

  if [[ "$no_sandbox" == "1" ]]; then
    echo "NO_SANDBOX"
    return
  fi

  local sb_file
  sb_file=$(mktemp "/tmp/monodots-dev-sandbox-XXXXXX.sb")

  {
    echo "(version 1)"
    echo "(deny default)"
    echo "(allow file-read*)"
    echo "(allow file-write* (subpath \"''${session_home}\"))"
    echo "(allow file-write* (subpath \"/tmp\"))"

    local p
    for p in "''${_allow[@]:-}"; do
      if [[ -e "$p" ]]; then
        echo "(allow file-write* (subpath \"$(realpath "$p")\"))"
      fi
    done

    for p in "''${_allow_ro[@]:-}"; do
      if [[ -e "$p" ]]; then
        echo "(allow file-read* (subpath \"$(realpath "$p")\"))"
      fi
    done

    for p in "''${_deny[@]:-}"; do
      if [[ -e "$p" ]]; then
        echo "(deny file-write* (subpath \"$(realpath "$p")\"))"
      fi
    done

    if [[ "$network" == "1" ]]; then
      echo "(allow network*) (allow ipc-posix-sem*)"
    fi
  } > "$sb_file"

  echo "$sb_file"
}
''
