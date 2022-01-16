#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
#

list_users() {
    psql -U ubuntu -d todosh -c "SELECT * FROM public."user""
  #  psql <<EOF
#SELECT * FROM "public"."user";
#EOF
}

list_todos() {
    psql -U ubuntu -d todosh -c "SELECT * FROM public."todo""
}

list_user_todos() {
    echo "User: $1"
    psql -U ubuntu -d todosh -c "SELECT * FROM public."todo" INNER JOIN public."user" ON public."user".id = public."todo".user_id WHERE public."user".name = '$1' ORDER BY public."todo".id"
}

main() {
    if [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
