_toDo_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"

    local commands="add done list remove clear help"

    COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
}
complete -F _toDo_completions toDo
# /home/ramon/Documentos/Bash/toDo_tabs.sh