#!/bin/bash
#. list.sh

#if [[ "$1" == "list-users" ]]
#then
#    list_users
#fi
main() {
    if [[ "$1" == "list-users" ]]
    then
    ./list.sh "$1"
    elif [[ "$1" == "list-todos" ]]
    then
    ./list.sh "$1"
    elif [[ "$1" == "list-user-todos" ]]
    then
    ./list.sh list-user-todos "$2"
    elif [[ "$1" == "add-user" ]]
    then
    ./add.sh add-user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
    ./add.sh add-todo "$2" "$3"
    elif [[ "$1" == "mark-todo" ]]
    then
    ./mark.sh mark-todo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
    ./mark.sh unmark-todo "$2"
    elif [[ "$1" == "delete-todo" ]]
    then
    ./delete.sh delete-todo "$2"
    elif [[ "$1" == "delete-done" ]]
    then
    ./delete.sh delete-done "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
