# vim:ft=zsh:et:sw=4
(( next_word = 2 | 8192 ))
typeset -gA chroma_spell_cache
__start_pos="$3" __end_pos="$4"
dict="${FAST_HIGHLIGHT_SPELL_DICT:-/usr/share/dict/american-english}"
string_style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-tri]}
error_style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}unknown-token]}
if [[ "$2" = \"* || "$2" = \'* ]]; then
    reply+=("$__start_pos $__end_pos $string_style")
    words=$(echo -e "$2" | gawk '{
        nf = split($0,a,/\w+[[:punct:]]\w+|\w+/,b)
        for (i = 1; i < nf; ++i) printf "%s %s ", length(a[i]), b[i]
    }')
    for word in $=words; do
        [ -z "$x" ] && (( __start_pos=__start_pos+word )) && x=" " && continue
        x=""
        if [ -z $chroma_spell_cache[$word] ]; then
            grep -iqFx "$word" "$dict" && check=1 || check=0
            chroma_spell_cache[$word]=$check
        else
            check=${chroma_spell_cache[$word]}
        fi
        (( __end_pos=__start_pos+${#word} ))
        [ $check -eq 0 ] && reply+=("$__start_pos $__end_pos $error_style")
        (( __start_pos=__end_pos ))
    done
    (( this_word = next_word ))
    _start_pos=$4
    return 0
fi
chroma/-git.ch $* && return 0
return 1
