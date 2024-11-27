taskFile="$HOME/Documentos/Task/tasks.txt"
checkFile="$HOME/Documentos/Task/done.txt "


add(){
    if [ -z "$1" ]; then
        echo "Argumentos recibidos: $1 , $2"
        echo "Error: Necesitas proporcionar un nombre para la tarea."
        echo "Uso: $0 add <nombre>"
        return 1
    fi
    if [ ! -f "$taskFile" ]; then
        touch "$taskFile"
    fi
    task="$@"
    if grep -q "$task" "$taskFile"; then
        echo "Error"
        echo "La tarea '$@' ya existe en la lista."
        return 1
    fi

    echo "$@" >> "$taskFile"
    echo "Se ha añadido '$@' a la lista de tareas."
}
list(){

    if [ ! -s "$taskFile" ]; then
        echo "No hay tareas en la lista."
    else
        echo "=====Tareas pendientes:======"
        cat "$taskFile"
        echo "===========Done:============="
        cat "$checkFile"
    fi
}
remove(){
    if [ -z "$1" ]; then
        echo "Error: Necesitas proporcionar un nombre para la tarea que quieres borrar."
        echo "Uso: $0 remove <nombre>"
        return 1
    fi
    task="$@"
    if ! grep -qxF "$task" "$taskFile"; then
        echo "Error: No se encontró la tarea '$@'."
        return 1
    fi
    sed -i "/$task/d" "$taskFile"
    echo "Tarea '$task' borrada."
}
check(){
    if [ -z "$1" ]; then 
        echo "Error: Necesitas proporcionar el nombre que la tarea que has realizado."
        echo "Uso: $0 done <nombre>"
        return 1
    fi
    task="$@"
    if ! grep -qxF "$task" "$taskFile"; then
        echo "No se ha encontrado la tarea"
        return 1
    fi 
    echo "$task" >> "$checkFile"
    sed -i "/$task/d" "$taskFile"
    echo "Check '$task' realizada."
}

clear(){
    if [ -z "$1" ]; then
            echo "Error: Necesitas proporcionar cual quieres vaciar ToDo o Done."
            echo "Uso: toDo clear <ToDo|Done>"
            return 1
        fi
        if [ "$1" == "ToDo" ]; then
            > "$taskFile"
            echo "Se han borrado todas las ToDo."
        elif [ "$1" == "Done" ]; then
            > "$checkFile"
            echo "Se han borrado todas las Done."
        else
            echo "Error: Argumento no reconocido."
            echo "Uso: toDo clear <ToDo|Done>"
        fi
}
case $1 in
    add)
        add $2
        ;;
    list)
        list
        ;;
    remove)
        remove $2
        ;;
    done)
        check $2
        ;;
    clear)
        clear $2
        ;;
    help)
        echo -e "   Uso:      toDo [add|list|remove|done|clear]\n"
        echo -e "   add:      Añadir una tarea a la lista. Se debe especificar el nombre de la tarea. Ejemplo: toDo add 'Comprar pan'"
        echo -e "   list:     Mostrar la lista de tareas y de Done.\n"
        echo -e "   remove:   Borrar una tarea de la lista. Se debe especificar el nombre de la tarea. Ejemplo: toDo remove 'Comprar pan'\n"
        echo -e "   done:     Marcar una tarea como realizada. Se debe especificar el nombre de la tarea. Ejemplo: toDo done 'Comprar pan'\n"
        echo -e "   clear:    Limpiar la lista de tareas o de Done. Se debe especificar cual quieres limpiar ToDo o Done. Ejemplo: toDo clear ToDo\n"
        echo -e "   help:     Mostrar ayuda."
        ;;
    *)
        echo "Comando no reconocido"
        echo "Uso: toDo [add|list|remove] <argumentos>"
        ;;
esac
