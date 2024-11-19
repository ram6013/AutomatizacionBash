function generar() {
    local name="$1"
    local number="$2"

    if [ -z "$name" ] || [ -z "$number" ]; then
        echo "Generar necesita que le des un nombre y el tamaño que quieres"
        return 1
    fi

    lista=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v"
           "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R"
           "S" "T" "U" "V" "W" "X" "Y" "Z" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "_" "@")
    
    local generado="" 
    for i in $(seq 1 "$number"); do
        generado+="${lista[$RANDOM % ${#lista[@]}]}"
    done

    echo "$name: $generado"
}
