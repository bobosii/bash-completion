#!/bin/bash

_es2panda_completions() {
    # ':' karakterini kelime ayırıcılar listesinden çıkar
    COMP_WORDBREAKS=${COMP_WORDBREAKS//:/}

    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    local yaml_file="/home/hw-intern2/arkcompiler/ets_frontend/ets2panda/util/options.yaml"

    # Eğer --option:sub kısmındaysa
    if [[ "$cur" == --*:* ]]; then
        local mainopt="${cur%%:*}"
        local partial_subopt="${cur#*:}"
        local mainopt_clean="${mainopt#--}"

        # sub_option'ları yaml'den çek
        local subopts=$(yq ".options[] | select(.name == \"${mainopt_clean}\") | .sub_options[].name" "$yaml_file" 2>/dev/null)

        local suggestions=()
        for sub in $subopts; do
            suggestions+=("${mainopt}:${sub}")
        done

        COMPREPLY=($(compgen -W "${suggestions[*]}" -- "$cur"))
        return 0
    fi

    # Normal ana optionları çek
    local opts=$(yq '.options[].name' "$yaml_file" | sed 's/^/--/')
    COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
}

complete -F _es2panda_completions es2panda
