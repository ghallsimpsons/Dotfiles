GITHUB_USER="ghallsimpsons"

function github() {
    if [ "$#" -ne 1 ]
    then
        cat <<EOF
USAGE:
    github [user/]<repo>[.git]
EOF
    return 1
    fi
    REPO=$( 
        awk -v USER=$GITHUB_USER            '\
            { repo = $1 };                   \
            !/[/]/ { repo=USER"/"repo };     \
            !/\.git$/ { repo=repo".git" };   \
            { print repo };                  \
            ' <<< $1
        )

    git clone ssh://git@github.com/$REPO
}
