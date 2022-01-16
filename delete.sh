#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#
delete_todo() {
psql -U ubuntu -d todosh -c "DELETE FROM public."todo" WHERE "id" = '$1'"
    echo "Todo removed"
}

delete_done() {
psql -U ubuntu -d todosh -c "DELETE FROM public."todo" WHERE "done" = 'true'"
    echo "Done todos removed"
}

main() {
    if [[ "$1" == "delete-todo" ]]
    then
        delete_todo "$2"
    elif [[ "$1" == "delete-done" ]]
    then
        delete_done "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
