#!/usr/bin/env bash

# Enable unofficial strict mode
set -euo pipefail
IFS=$'\n\t'


# Including unabashed framework
__DIR__=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
. "$__DIR__"/vendor/unabashed/unabashed.sh


__PROJECT__=watcher


trap ctrl_c INT


usage() {
  output__tell__message "<info>Usage</>"
  output__tell__message "<comment>$__PROJECT__ [OPTIONS] -- [file] [file OPTIONS]</>"
  output__tell__message ""
  output__tell__message "<info>  -i [n], --interval=[n]</>   <comment>amount of seconds in between hash checks</>"
  output__tell__message "<info>  -r, --recursive</>          <comment>check all files in base directory for changes</>"
  output__tell__message "<info>  --no-hash</>                <comment>reload without hash checks</>"
  output__tell__message "<info>  -h, --help</>               <comment>display this help section and exit</>"
  exit 1
}


menu() {
  local _title="watcher"

  if ! helpers__empty "${1:-}"; then
    _title="$1"
  fi

  echo -e "$green_b"
  tput cup 0,0
  local _cols=`tput cols`
  _cols=$((_cols-${#_title}))
  printf "%s" "$_title"
  printf "%${_cols}s%s" "`date`"
  output__tell__clearFormatting
}


ctrl_c() {
  tput cnorm
  output__tell__clearFormatting
  clear
  output__tell__message "<comment>ctr+c</> captured. Gracefully shutting down."
  exit 0
}


output__tell__fancyTitle "simple watcher script that will execute a script when it changes" "$__PROJECT__" "fg=white;bg=c_5"
sleep 2


params="$(getopt -o hri: -l help,no-hash,recursive,interval: --name "$(basename "$0")" -- "$@")"


eval set -- "$params"
unset params

interval=10
no_hash=0
recursive=false

while true; do
  case "$1" in
    -i|--interval)
      if helpers__empty "${2:-}"; then
        output__tell__error "-i|--interval requires seconds as parameter"
        exit 1 
      fi
      if ! helpers__is_number $2; then
        output__tell__error "-i|--interval requires an integer as parameter"
        exit 1 
      fi
      interval="$2"
      shift
      ;;
    --no-hash)
      no_hash=1
      ;;
    -r|--recursive)
      recursive=true
      ;;
    --)
      shift
      break;;
    -h|--help|*)
      usage
      break;;
  esac
  shift
done


main() {
  if helpers__empty "${1:-}"; then
    output__tell__error "Please specify a file to watch."
    usage
  fi

  local _file="$1"
  local _hash=0

  if ! helpers__is_file "$_file"; then
      output__tell__error "The script \"$_file\" does not exist."
      exit 1
  fi

  if [[ "$no_hash" == 0 ]]; then
    if [[ "$recursive" == false ]]; then
      _hash=$(helpers__get_hash "$_file")
    else
      _hash=$(helpers__get_hash $(dirname "$_file") "$recursive")
    fi
  fi

  shift

  local _options="$@"
  local _interval_count=-1
  local _newhash=""
  tput civis

  while true; do
    if [[ "$no_hash" == 0 ]]; then
      if [[ "$recursive" == false ]]; then
        _newhash=$(helpers__get_hash "$_file")
      else
        _newhash=$(helpers__get_hash $(dirname "$_file") "$recursive")
      fi
    fi

    if [[ "$no_hash" == 1 ]] || [[ "$_newhash" != "$_hash" ]] || [[ "$_interval_count" == -1 ]]; then
      output__tell__clearFormatting
      clear
      menu "$_file $_options"
      echo ""
      echo ""
      bash $_file $_options

      if [[ "$no_hash" == 0 ]]; then
        _hash="$_newhash"
      fi
    fi
        
    _interval_count=0

    while true; do
      sleep 1
      _interval_count=$((_interval_count+1))
      menu "$_file $_options"

      if [[ $_interval_count == $interval ]]; then
        break
      fi
    done
  done
}


main "$@"
