#!/usr/bin/env bats

. "$BATS_TEST_DIRNAME"/../unabashed.sh

#------------------------------------------------helpers.helpers__is_number------------------------------------------------------------------

@test "check that \`helpers__is_number\` returns 1" {
  run helpers__is_number
  [ $status = 1 ]
}


@test "check that \`helpers__is_number 7\` returns 0" {
  run helpers__is_number 7
  [ $status = 0 ]
}


@test "check that \`helpers__is_number B\` returns 1" {
  run helpers__is_number B
  [ $status = 1 ]
}


@test "check that \`helpers__is_number 1str4num5\` returns 1" {
  run helpers__is_number 1str4num5
  [ $status = 1 ]
}

#-----------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------helpers.is_array------------------------------------------------------------------
@test "check that \`is_array\` returns 1" {
  run is_array
  [ $status = 1 ]
}


@test "check that \`is_array 4\` returns 1" {
  run is_array 4
  [ $status = 1 ]
}


@test "check that \`is_array U\` returns 1" {
  run is_array U
  [ $status = 1 ]
}


@test "check that \`is_array (a, b, 4, word)\` returns 0" {
  local _array=(a, b, 4, word)
  run is_array _array
  [ $status = 0 ]
}

#-----------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------helpers.file_exists------------------------------------------------------------------
@test "check that \`file_exists\` returns 1" {
  run file_exists
  [ $status = 1 ]
}


@test "check that \`file_exists /a/b/c/d/e\` returns 1" {
  run file_exists /a/b/c/d/e
  [ $status = 1 ]
}


@test "check that \`file_exists /usr/local/bin/unabashed\` returns 0" {
  run helpers__is_file /usr/local/bin/unabashed
  [ $status = 0 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.helpers__empty----------------------------------------------------------------------
@test "check that \`helpers__empty\` returns 1" {
  run helpers__empty
  [ $status = 0 ]
}


@test "check that \`helpers__empty 5\` returns 1" {
  run helpers__empty 5
  [ $status = 1 ]
}


@test "check that \`helpers__empty \"\"\` returns 0" {
  run helpers__empty ""
  [ $status = 0 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.dir_exists----------------------------------------------------------------------

@test "check that \`dir_exists\` returns 1" {
  run dir_exists
  [ $status = 1 ]
}


@test "check that \`dir_exists /a/b/c/d/e/f\` returns 1" {
  run dir_exists /a/b/c/d/e/f
  [ $status = 1 ]
}


@test "check that \`dir_exists 55123123\` returns 1" {
  run directory_exists 55123123
  [ $status = 1 ]
}


@test "check that \`dir_exists /usr/local/bin\` returns 0" {
  run is_dir /tmp
  [ $status = 0 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.check_root----------------------------------------------------------------------
@test "check that \`check_root\` returns 1" {
  run check_root
  [ $status = 1 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.in_array----------------------------------------------------------------------
@test "check that \`in_array\` returns 1" {
  run helpers__in_array
  [ $status = 1 ]
}


@test "check that \`in_array needle\` returns 1" {
  run helpers__in_array needle
  [ $status = 1 ]
}


@test "check that \`in_array one two\` returns 1" {
  run helpers__in_array one two
  [ $status = 1 ]
}


@test "check that \`in_array needle (a, b, 34)\` returns 1" {
  local _array
  _array=(a, b, 34)
  run helpers__in_array needle "${_array[@]}"
  [ $status = 1 ]
}


@test "check that \`in_array needle (a, b, 34, needle)\` returns 0" {
  _array=(a, b, 34, "needle")
  run helpers__in_array "needle" "${_array[@]}"
  [ $status = 0 ]
}


@test "check that \`in_array one (a, b, 34, needle)\` returns 1" {
  _array=(a, b, 34, "needle")
  run helpers__in_array "one" "${_array[@]}"
  [ $status = 1 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.function_exists----------------------------------------------------------------------
@test "check that \`function_exists\` returns 1" {
  run function_exists
  [ $status = 1 ]
}


@test "check that \`function_exists notanexistingfunctionhere\` returns 1" {
  run function_exists notanexistingfunctionhere
  [ $status = 1 ]
}


@test "check that \`function_exists helpers__is_number\` returns 0" {
  run function_exists helpers__is_number
  [ $status = 0 ]
}
#-----------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------helpers.helpers__empty_dir----------------------------------------------------------------------
@test "check that \`helpers__empty_dir\` returns 1" {
  run helpers__empty_dir
  [ $status = 1 ]
}


@test "check that \`helpers__empty_dir thereisnodirectorylikethishere\` returns 1" {
  run helpers__empty_dir thereisnodirectorylikethishere
  [ $status = 1 ]
}


@test "check that \`helpers__empty_dir /usr/local/bin\` returns 1" {
  run helpers__empty_dir /usr/local/bin
  [ $status = 1 ]
}


@test "check that \`helpers__empty_dir /tmp/arandomdirnamethatshouldnotexist\` returns 0" {
  local _file
  _file=/tmp/arandomdirnamethatshouldnotexist
  mkdir "$_file"
  run helpers__empty_dir "$_file"
  rm -rf "$_file"
  [ $status = 0 ]
}
#------------------------------------------------helpers.helpers__empty_dir----------------------------------------------------------------------

