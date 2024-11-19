function generar() {
    local name="$1"
    local number="$2"
    local ruta = "algo"

    if [ -z "$name" ] || [ -z "$number" ]; then
        echo "Error: Necesitas proporcionar un nombre y un tamaño para la cadena generada."
        echo "Uso: generar <nombre> <tamaño>"
        return 1
    fi

    local lista=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v"
                 "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R"
                 "S" "T" "U" "V" "W" "X" "Y" "Z" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "_" "@")

    local generado=""
    for ((i = 1; i <= number; i++)); do
        generado+="${lista[RANDOM % ${#lista[@]}]}"
    done

    local resultado="$name: $generado"
    echo "$resultado"
    echo "$resultado" >> "$ruta"
}

generar "$1" "$2"