_zsh_autosuggest_strategy_custom() {
	# Reset options to defaults and enable LOCAL_OPTIONS
	emulate -L zsh

	# Enable extended glob for completion ignore pattern
	setopt EXTENDED_GLOB

	typeset -g suggestion
	local line REPLY

	# Exit if we don't have completions
	whence compdef >/dev/null || return

	# Exit if we don't have zpty
	zmodload zsh/zpty 2>/dev/null || return

	# Exit if our search string matches the ignore pattern
	[[ -n "$ZSH_AUTOSUGGEST_COMPLETION_IGNORE" ]] && [[ "$1" == $~ZSH_AUTOSUGGEST_COMPLETION_IGNORE ]] && return

	# Zle will be inactive if we are in async mode
	if zle; then
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_sync
	else
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_async "\$1"
		zpty -w $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME $'\t'
	fi

	{
		# The completion result is surrounded by null bytes, so read the
		# content between the first two null bytes.
		zpty -r $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME line '*'$'\0''*'$'\0'

		# Extract the suggestion from between the null bytes.  On older
		# versions of zsh (older than 5.3), we sometimes get extra bytes after
		# the second null byte, so trim those off the end.
		# See http://www.zsh.org/mla/workers/2015/msg03290.html
		suggestion="$BUFFER${${${(@0)line}[2]}:${#BUFFER}}"
	} always {
		# Destroy the pty
		zpty -d $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME
	}
}
