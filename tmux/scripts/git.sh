MIN_MAJOR_VERSION="2"
MIN_MINOR_VERSION="1"
TMUX_VERSION="$(tmux -V)"
branch_symbol=""
git_colour="5"
svn_colour="220"
hg_colour="45"

if [[ "${TMUX_VERSION}" =~ .*([[:digit:]]+)\.([[:digit:]]+) ]]; then
	TMUX_MAJOR_VERSION="${BASH_REMATCH[1]}"
	TMUX_MINOR_VERSION="${BASH_REMATCH[2]}"
	if [[ ("${TMUX_MAJOR_VERSION}" -gt "${MIN_MAJOR_VERSION}") || (("${TMUX_MAJOR_VERSION}" -eq "${MIN_MAJOR_VERSION}") && ("${TMUX_MINOR_VERSION}" -ge "${MIN_MINOR_VERSION}")) ]]; then
		get_tmux_cwd() {
			tmux display -p -F "#{pane_current_path}"
		}
	fi
fi

if [[ -z "$(type -t get_tmux_cwd)" ]]; then
	get_tmux_cwd() {
		local env_name=$(tmux display -p "TMUXPWD_#D" | tr -d %)
		local env_val=$(tmux show-environment | grep --color=never "$env_name")
		# The version below is still quite new for tmux. Uncomment this in the future :-)
		#local env_val=$(tmux show-environment "$env_name" 2>&1)

		if [[ ! $env_val =~ "unknown variable" ]]; then
			local tmux_pwd=$(echo "$env_val" | sed 's/^.*=//')
			echo "$tmux_pwd"
		fi
	}
fi

unset MIN_MAJOR_VERSION
unset MIN_MINOR_VERSION
unset TMUX_VERSION

run_segment() {
	tmux_path=$(get_tmux_cwd)
	cd "$tmux_path"
	branch=""
	if [ -n "${git_branch=$(__parse_git_branch)}" ]; then
		branch="$git_branch"
	elif [ -n "${svn_branch=$(__parse_svn_branch)}" ]; then
		branch="$svn_branch"
	elif [ -n "${hg_branch=$(__parse_hg_branch)}" ]; then
		branch="$hg_branch"
	fi

	if [ -n "$branch" ]; then
		echo "${branch}"
	fi
	return 0
}


# Show git banch.
__parse_git_branch() {
	type git >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

	# Quit if this is not a Git repo.
	branch=$(git symbolic-ref HEAD 2> /dev/null)
	if [[ -z $branch ]] ; then
		# attempt to get short-sha-name
		branch=":$(git rev-parse --short HEAD 2> /dev/null)"
	fi
	if [ "$?" -ne 0 ]; then
		# this must not be a git repo
		return
	fi

	# Clean off unnecessary information.
	branch=${branch#refs\/heads\/}

	echo  -n "#[fg=colour${git_colour}]${branch_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${branch}"
}

# Show SVN branch.
__parse_svn_branch() {
	type svn >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	local svn_info=$(svn info 2>/dev/null)
	if [ -z "${svn_info}" ]; then
		return
	fi


	local svn_root=$(echo "${svn_info}" | sed -ne 's#^Repository Root: ##p')
	local svn_url=$(echo "${svn_info}" | sed -ne 's#^URL: ##p')

	local branch=$(echo "${svn_url}" | egrep -o '[^/]+$')
	echo "#[fg=colour${svn_colour}]${branch_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${branch}"
}

__parse_hg_branch() {
	type hg >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	summary=$(hg summary)
	if [ "$?" -ne 0 ]; then
		return
	fi

	local branch=$(echo "$summary" | grep 'branch:' | cut -d ' ' -f2)
	echo  "#[fg=colour${hg_colour}]${branch_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${branch}"
}

run_segment()
