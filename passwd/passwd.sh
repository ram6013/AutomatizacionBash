ruta_actual="/home/ramon/Documentos/Bash/passwd"
echo "$ruta_actual"
cd "$ruta_actual"
source .env

encript() {
    contenido="$@"
    contenido=$(echo "$contenido" | tr ' ' '\n')
    echo "$contenido" > "$name2"
    gpg --batch --yes --passphrase "$passwd" -c "$name2"
    rm "$name2"
}

descript(){
    contenido=$(gpg --decrypt "$name")
    if [ $? -ne 0 ] || [ -z "$contenido" ]; then
        echo "Error al descifrar el archivo. Asegúrate de que la contraseña sea correcta."
        exit 1
    fi

}

eliminar() {
    cd "$ruta"
    descript
    eleccion=$(echo "$contenido" | fzf)
    if [ -z "$eleccion" ]; then
        echo "No se ha seleccionado nada"    
        return 1
    fi
    contenido=$(echo "$contenido" | sed "/$eleccion/d")
    encript "$contenido"
    echo "Se ha eliminado $eleccion con éxito."
}


visualizar() {
    cd "$ruta"
    descript
    eleccion=$(echo "$contenido" | fzf)
    if [ -z "$eleccion" ]; then
        echo "No se ha seleccionado nada"
        return 1
    fi
    echo "$eleccion" | xclip -sel clip
}

    
generar() {
    cd "$ruta" 
    name="$1"
    number="$2"

    if [ -z "$name" ] || [ -z "$number" ]; then
        echo "Error: Necesitas proporcionar un nombre y un tamaño para la cadena generada."
        echo "Uso: generar <nombre> <tamaño>"
        return 1
    fi

    lista=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v"
                 "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R"
                 "S" "T" "U" "V" "W" "X" "Y" "Z" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "_" "@")

    generado=""
    for ((i = 1; i <= number; i++)); do
        generado+="${lista[RANDOM % ${#lista[@]}]}"
    done

    resultado="$name:$generado"
    echo "$resultado"
    descript
    contenido="$contenido$(echo -e "\n$resultado")"
    encript $contenido
    echo "Se ha generado con éxito"
}



case $1 in 
    generar)
    generar "$2" "$3"
    ;;
    eliminar)
    eliminar
    ;;
    visualizar)
    visualizar
    ;;
    *)
    echo "Comando no valido"
    ;;
esac