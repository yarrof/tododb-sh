#!/bin/bash
#

mark_todo() {
    todo_id="$(psql -qt ubuntu -d todosh -c "
SELECT id FROM public."todo" WHERE id = '$1'"
)"
if [ -n "$todo_id" ]
then
psql -U ubuntu -d todosh -c "UPDATE public."todo" SET done = 'true' WHERE "id" = '$1'"
   echo "Marked as done"
else
echo "Todo not found: $1"
fi
}

unmark_todo() {
    todo_id="$(psql -qt ubuntu -d todosh -c "
SELECT id FROM public."todo" WHERE id = '$1'"
)"
if [ -n "$todo_id" ]
then
psql -U ubuntu -d todosh -c "UPDATE public."todo" SET done = 'false' WHERE "id" = '$1'"
    echo "Marked as *not* done"
else
echo "Todo not found: $1"
fi
}

main() {
    if [[ "$1" == "mark-todo" ]]
    then
        mark_todo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        unmark_todo "$2"
    else
    echo "Bad command, only mark-todo and unmark-todo works! "
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
