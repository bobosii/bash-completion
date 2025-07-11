#!/bin/bash

function ark(){
}

_ark_completions() {
    COMP_WORDBREAKS=${COMP_WORDBREAKS//:/}

    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    local yaml_file="/home/ewx1438531/arkcompiler/build/runtime_options_gen.yaml"

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

    local opts=$(yq '.options[].name' "$yaml_file" | sed 's/^/--/')
    COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
}

complete -F _ark_completions ark
