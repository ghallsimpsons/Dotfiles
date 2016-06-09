### ZSH functions and utilities

# Stifle all output from a command. Postfix operator.
# SOME COMMAND no-output
alias -g no-output=">/dev/null 2>&1"

function command-exists {
    command -v "$1" no-output
}

# directory containing the script that invokes this function
# this-script-dir --> '/home/jitl/bin'
function this-script-dir {
    echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}

# expands a string with Bash/ZSH substitutions in it
# expand-string 'hello $USER' --> "hello jitl"
function expand-string {
    eval echo "$1"
}

# With two arguments, prepends the second argument to the path-like variable
# in the first argument, if not present. With one argument, prepends to PATH.
function prepend_to_path {
    if [ -z "$2" ]; then
        PATHVAR="PATH"
        TO_PREPEND="$1"
    else
        PATHVAR="$1"
        TO_PREPEND="$2"
    fi
    if [[ "${(P)PATHVAR}" =~ "(^|:)$TO_PREPEND(:|$)" ]]; then
        return 0
    fi
    eval $PATHVAR=\"$TO_PREPEND:${(P)PATHVAR}\"
}
