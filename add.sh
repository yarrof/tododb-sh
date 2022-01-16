#!/bin/bash

add_user() {
    #Először rákeresünk az általunk megadott névre, hogy létezik-e ilyen az adatbázisban.
    user_id="$(psql -qt ubuntu -d todosh -c "
SELECT id FROM public."user" WHERE name = '$1'"
)"
#Itt pedig ha létezik, kiírunk egy hibaüzenetet, ha nem létezik, akkor pedig elkészítjük az adott nevű usert.
if [ -n "$user_id" ]
then
echo "User Exist: $1"
else
psql -U ubuntu -d todosh -c "INSERT INTO public."user" (name) VALUES ('$1')"
    echo "User added: $1"
fi
}

add_todo() {
    user_id="$(psql -qt ubuntu -d todosh -c "
SELECT id FROM public."user" WHERE name = '$1'"
)"
#Itt is rákeresünk a user-re, és ha nem létezik hibaüzenetet kapunk, ha létezik, a program lefut.
if [ -n "$user_id" ]
then
psql -U ubuntu -d todosh -c "
    INSERT INTO public."todo" (task,user_id) SELECT '$2', "id" FROM public."user" WHERE "name" = '$1';"
    echo "Todo added"
else
echo "Non existing user!"
fi
    
}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    else
    #Ha nem megfelelő a parancs, hibaüzenetet írok ki!
    echo "Bad command, only add-user and add-todo works!"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
