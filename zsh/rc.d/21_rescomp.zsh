### Aliases for rescomp machines

if [[ "$HOSTNAME" == *rescomp.berkeley.edu || "$HOSTNAME" == *housing.berkeley.edu ]] ; then
    ### Paths
    export SVNCODE="https://svn.rescomp.berkeley.edu/code"
    export SVNTMPL="https://svn.rescomp.berkeley.edu/marketing"
    export CODE="/usr/code/$USER/"

    ### PostgreSQL Database Access
    alias devdb='psql -h dev-grantlandhall-db rescomp'
    alias testdb='psql -h test-db rescomp'
    alias proddb='psql -h db rescomp'

    ### Webtree sync
    alias websync='sudo svn export --force $SVNTMPL/webtree/ /usr/local/www/rescomp/docs/'
fi
