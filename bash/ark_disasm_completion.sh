#!/bin/bash

_ark_disasm_completions()
{
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local opts="--help --verbose --quiet --skip-string-literals --debug --debug-file --version"

    # debug-file: sonrası dosya tamamlama
    if [[ "${cur}" == --debug-file:* ]]; then
        local suffix="${cur#--debug-file:}"
        COMPREPLY=( $(compgen -f -- "${suffix}") )
        for i in "${!COMPREPLY[@]}"; do
            COMPREPLY[$i]="--debug-file:${COMPREPLY[$i]}"
        done
        return 0
    fi

    # -- ile başlayan seçenek tamamlama
    if [[ "${cur}" == --* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
    fi

    # Dosya tamamlama (argüman olarak)
    COMPREPLY=( $(compgen -f -- "${cur}") )
}

# Bu fonksiyonu ark_disasm komutuna bağla
complete -F _ark_disasm_completions ark_disasm
