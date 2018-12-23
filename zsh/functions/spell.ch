# vim:ft=zsh:et:sw=4
(( next_word = 2 | 8192 ))
local __word __miss __match
integer __offset
__start_pos="$3" __end_pos="$4"
string_style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-tri]}
error_style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}unknown-token]}
if [[ "$2" = \"* || "$2" = \'* ]]; then
    reply+=("$__start_pos $__end_pos $string_style")
    for __word in $=2; do
        __miss="$(aspell list <<< "$__word")"
        if [[ -n "$__miss" ]]; then
            __match="${__word%%$__miss*}"
            [[ -n "$__match" ]] && __offset=${#__match} || __offset=0
            (( __start=__start_pos+__offset-${#PREBUFFER}, __end=__start_pos+__offset+${#__miss}-${#PREBUFFER}, __start >= 0 )) && \
            reply+=("$__start $__end $error_style")
        fi
        (( __start_pos=__start_pos+${#__word}+1 ))
    done
    (( this___word = next___word ))
    _start_pos=$4
    return 0
fi
chroma/-git.ch $*
