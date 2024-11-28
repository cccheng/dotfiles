#!/usr/bin/env bash
# shellcheck disable=SC2034

# Enable colors in your shell
TERM="xterm-256color"
CLICOLOR=1
S_COLORS="auto"                         # Sysstat/iostat - enable colors (probably on by default, now)

#
# ANSI code generator
#
# © Copyright 2015 Tyler Akins
# Licensed under the MIT license with an additional non-advertising clause
# See http://github.com/fidian/ansi
# 

ANSI_ESC=$'\033'
ANSI_CSI="${ANSI_ESC}["
ANSI_OSC="${ANSI_ESC}]"
ANSI_ST="${ANSI_ESC}\\"
ANSI_REPORT="" # The return value from ansi::report

ansi::reset-color()             { printf '%s0m' "$ANSI_CSI"; }
ansi::reset-font()              { printf '%s10m' "$ANSI_CSI"; }
ansi::reset-foreground()        { printf '%s39m' "$ANSI_CSI"; }
ansi::reset-background()        { printf '%s49m' "$ANSI_CSI"; }
ansi::reset-ideogram()          { printf '%s65m' "$ANSI_CSI"; }
ansi::reset-attributes()        { printf '%s22;23;24;25;27;28;29;54;55m' "$ANSI_CSI"; }

ansi::bold()                    { printf '%s1m' "$ANSI_CSI"; }
ansi::faint()                   { printf '%s2m' "$ANSI_CSI"; }
ansi::italic()                  { printf '%s3m' "$ANSI_CSI"; }
ansi::underline()               { printf '%s4m' "$ANSI_CSI"; }
ansi::blink()                   { printf '%s5m' "$ANSI_CSI"; }
ansi::rapid-blink()             { printf '%s6m' "$ANSI_CSI"; }
ansi::inverse()                 { printf '%s7m' "$ANSI_CSI"; }
ansi::invisible()               { printf '%s8m' "$ANSI_CSI"; }
ansi::strike()                  { printf '%s9m' "$ANSI_CSI"; }

ansi::fraktur()                 { printf '%s20m' "$ANSI_CSI"; }
ansi::double-underline()        { printf '%s21m' "$ANSI_CSI"; }
ansi::normal()                  { printf '%s22m' "$ANSI_CSI"; }
ansi::plain()                   { printf '%s23m' "$ANSI_CSI"; }
ansi::no-underline()            { printf '%s24m' "$ANSI_CSI"; }
ansi::no-blink()                { printf '%s25m' "$ANSI_CSI"; }
ansi::no-inverse()              { printf '%s27m' "$ANSI_CSI"; }
ansi::visible()                 { printf '%s28m' "$ANSI_CSI"; }
ansi::no-strike()               { printf '%s29m' "$ANSI_CSI"; }

ansi::frame()                   { printf '%s51m' "$ANSI_CSI"; }
ansi::encircle()                { printf '%s52m' "$ANSI_CSI"; }
ansi::overline()                { printf '%s53m' "$ANSI_CSI"; }
ansi::no-border()               { printf '%s54m' "$ANSI_CSI"; }
ansi::no-overline()             { printf '%s55m' "$ANSI_CSI"; }
ansi::ideogram-right-double()   { printf '%s61m' "$ANSI_CSI"; }
ansi::ideogram-right()          { printf '%s60m' "$ANSI_CSI"; }
ansi::ideogram-left()           { printf '%s62m' "$ANSI_CSI"; }
ansi::ideogram-left-double()    { printf '%s63m' "$ANSI_CSI"; }
ansi::ideogram-stress()         { printf '%s64m' "$ANSI_CSI"; }

ansi::black()                   { printf '%s30m' "$ANSI_CSI"; }
ansi::red()                     { printf '%s31m' "$ANSI_CSI"; }
ansi::green()                   { printf '%s32m' "$ANSI_CSI"; }
ansi::yellow()                  { printf '%s33m' "$ANSI_CSI"; }
ansi::blue()                    { printf '%s34m' "$ANSI_CSI"; }
ansi::magenta()                 { printf '%s35m' "$ANSI_CSI"; }
ansi::cyan()                    { printf '%s36m' "$ANSI_CSI"; }
ansi::white()                   { printf '%s37m' "$ANSI_CSI"; }

ansi::black-intense()           { printf '%s90m' "$ANSI_CSI"; }
ansi::red-intense()             { printf '%s91m' "$ANSI_CSI"; }
ansi::green-intense()           { printf '%s92m' "$ANSI_CSI"; }
ansi::yellow-intense()          { printf '%s93m' "$ANSI_CSI"; }
ansi::blue-intense()            { printf '%s94m' "$ANSI_CSI"; }
ansi::magenta-intense()         { printf '%s95m' "$ANSI_CSI"; }
ansi::cyan-intense()            { printf '%s96m' "$ANSI_CSI"; }
ansi::white-intense()           { printf '%s97m' "$ANSI_CSI"; }

ansi::bg-black()                { printf '%s40m' "$ANSI_CSI"; }
ansi::bg-red()                  { printf '%s41m' "$ANSI_CSI"; }
ansi::bg-green()                { printf '%s42m' "$ANSI_CSI"; }
ansi::bg-yellow()               { printf '%s43m' "$ANSI_CSI"; }
ansi::bg-blue()                 { printf '%s44m' "$ANSI_CSI"; }
ansi::bg-magenta()              { printf '%s45m' "$ANSI_CSI"; }
ansi::bg-cyan()                 { printf '%s46m' "$ANSI_CSI"; }
ansi::bg-white()                { printf '%s47m' "$ANSI_CSI"; }

ansi::bg-black-intense()        { printf '%s100m' "$ANSI_CSI"; }
ansi::bg-red-intense()          { printf '%s101m' "$ANSI_CSI"; }
ansi::bg-green-intense()        { printf '%s102m' "$ANSI_CSI"; }
ansi::bg-yellow-intense()       { printf '%s103m' "$ANSI_CSI"; }
ansi::bg-blue-intense()         { printf '%s104m' "$ANSI_CSI"; }
ansi::bg-magenta-intense()      { printf '%s105m' "$ANSI_CSI"; }
ansi::bg-cyan-intense()         { printf '%s106m' "$ANSI_CSI"; }
ansi::bg-white-intense()        { printf '%s107m' "$ANSI_CSI"; }

ansi::restore-cursor()          { printf '%su' "$ANSI_CSI"; }
ansi::save-cursor()             { printf '%ss' "$ANSI_CSI"; }

ansi::column-relative()         { printf '%s%sa' "$ANSI_CSI" "${1-}"; }
ansi::repeat()                  { printf '%s%sb' "$ANSI_CSI" "${1-}"; }
ansi::line()                    { printf '%s%sd' "$ANSI_CSI" "${1-}"; }
ansi::line-relative()           { printf '%s%se' "$ANSI_CSI" "${1-}"; }

ansi::up()                      { printf '%s%sA' "$ANSI_CSI" "${1-}"; }
ansi::down()                    { printf '%s%sB' "$ANSI_CSI" "${1-}"; }
ansi::forward()                 { printf '%s%sC' "$ANSI_CSI" "${1-}"; }
ansi::backward()                { printf '%s%sD' "$ANSI_CSI" "${1-}"; }
ansi::next-line()               { printf '%s%sE' "$ANSI_CSI" "${1-}"; }
ansi::previous-line()           { printf '%s%sF' "$ANSI_CSI" "${1-}"; }
ansi::column()                  { printf '%s%sG' "$ANSI_CSI" "${1-}"; }

ansi::scroll-up()               { printf '%s%sS' "$ANSI_CSI" "${1-}"; }
ansi::scroll-down()             { printf '%s%sT' "$ANSI_CSI" "${1-}"; }
ansi::delete-chars()            { printf '%s%sP' "$ANSI_CSI" "${1-}"; }
ansi::delete-lines()            { printf '%s%sM' "$ANSI_CSI" "${1-}"; }
ansi::tab-backward()            { printf '%s%sZ' "$ANSI_CSI" "${1-}"; }
ansi::tab-forward()             { printf '%s%sI' "$ANSI_CSI" "${1-}"; }

ansi::insert-chars()            { printf '%s%s@' "$ANSI_CSI" "${1-}"; }
ansi::insert-lines()            { printf '%s%sL' "$ANSI_CSI" "${1-}"; }
ansi::erase-display()           { printf '%s%sJ' "$ANSI_CSI" "${1-}"; }
ansi::erase-chars()             { printf '%s%sX' "$ANSI_CSI" "${1-}"; }
ansi::erase-line()              { printf '%s%sK' "$ANSI_CSI" "${1-}"; }

ansi::color()                   { printf '%s38;5;%sm' "$ANSI_CSI" "$1"; }
ansi::bg-color()                { printf '%s48;5;%sm' "$ANSI_CSI" "$1"; }
ansi::rgb()                     { printf '%s38;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"; }
ansi::bg-rgb()                  { printf '%s48;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"; }

ansi::bell()                    { printf "%s" $'\007'; }
ansi::font()                    { printf '%s1%sm' "$ANSI_CSI" "${1-0}"; }
ansi::show-cursor()             { printf '%s?25h' "$ANSI_CSI"; }
ansi::hide-cursor()             { printf '%s?25l' "$ANSI_CSI"; }
ansi::icon()                    { printf '%s1;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"; }
ansi::title()                   { printf '%s2;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"; }

ansi::position()
{
    local position="${1-}"
    printf '%s%sH' "$ANSI_CSI" "${position/,/;}"
}

ansi::report()
{
    local buff c report

    report=""

    # Note: read bypass piping, which lets this work:
    # ansi --report-window-chars | cut -d , -f 1
    read -p "$ANSI_CSI$3" -r -N "${#2}" -s -t 1 buff

    if [ "$buff" != "$2" ]; then
        return 1
    fi

    read -r -N "${#3}" -s -t 1 buff

    while [[ "$buff" != "$3" ]]; do
        report="$report${buff:0:1}"
        read -r -N 1 -s -t 1 c || exit 1
        buff="${buff:1}$c"
    done

    ANSI_REPORT=$report
}

ansi::report-position() {
    ansi::report 6n "$ANSI_CSI" R || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-icon() {
    ansi::report 20t "${ANSI_OSC}L" "$ANSI_ST" || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-screen-chars() {
    ansi::report 19t "${ANSI_CSI}9;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-title() {
    ansi::report 21t "${ANSI_OSC}l" "$ANSI_ST" || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-window-chars() {
    ansi::report 18t "${ANSI_CSI}8;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-window-pixels() {
    ansi::report 14t "${ANSI_CSI}4;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-window-position() {
    ansi::report 13t "${ANSI_CSI}3;" t || return 1
    printf '%s\n' "${ANSI_REPORT//;/,}"
}

ansi::report-window-state() {
    ansi::report 11t "$ANSI_CSI" t || return 1
    case "$ANSI_REPORT" in
        1)
            printf 'open\n'
            ;;

        2)
            printf 'iconified\n'
            ;;

        *)
            printf 'unknown (%s)\n' "$ANSI_REPORT"
            ;;
    esac
}

ansi::is-ansi-supported()
{
    # Optionally override detection logic
    # to support post processors that interpret color codes _after_ output is generated.
    # Use environment variable "ANSI_FORCE_SUPPORT=<anything>" to enable the override.
    if [[ -n "${ANSI_FORCE_SUPPORT-}" ]]; then
        return 0
    fi

    if hash tput &> /dev/null; then
        if [[ "$(tput colors)" -lt 8 ]]; then
            return 1
        fi

        return 0
    fi

    # Query the console and see if we get ANSI codes back.
    # CSI 0 c == CSI c == Primary Device Attributes.
    # Idea:  CSI c
    # Response = CSI ? 6 [234] ; 2 2 c
    # The "22" means ANSI color, but terminals don't need to send that back.
    # If we get anything back, let's assume it works.
    ansi::report c "$ANSI_CSI?" c || return 1
    [[ -n "$ANSI_REPORT" ]]
}

ansi::reset() {
    ansi::reset-color
    ansi::reset-font
    ansi::erase-display 2
    ansi::position "1;1"
    ansi::show-cursor
}

