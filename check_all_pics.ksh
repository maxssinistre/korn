for T in $(ls -ltr | awk '/^d/ { print $NF }'); do echo "changing to $T" ;cd $T ; show_today.ksh -v -t $1; cd - ; done
