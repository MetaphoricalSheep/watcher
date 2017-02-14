if [[ -z "$__UNABASHEDDIR__" ]]; then
  echo -e "\e[31m""ERROR: \e[39m\e[49m You cannot source this file directly. Source unabashed.sh. \e[39m\n"
  exit 1
fi


#
# Checks if the OS Version is in a given array
# 
unabashed_os_version_check() {
  require_parameter_count "$FUNCNAME" "$LINENO" 1 "$#"

  if (! helpers__in_array "$__UA_OS_VERSION__" ${@:1}); then
    output__tell__error "$__UA_OS_NAME__ is not currently supported by this install script."

    exit 1
  fi
}


check_dependency() {
  require_parameter_count "$FUNCNAME" "$LINENO" 1 "$#"

  local _func
  _func="$1"; shift

  command -v "$_func" >/dev/null 2>&1 || return 1
}


command_not_found_handle() {
  local _caller_file
  _caller_file=$(echo $(caller | awk '{print $2}'))
  output__tell__error "$_caller_file::${FUNCNAME[1]}::$LINENO::$1: command not found"
  return $?
}
