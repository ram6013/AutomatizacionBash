function gitP() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "gitP necesita un texto para el commit"
        return 1
    fi

    git add .
    git commit -m "$name"
    git push
}