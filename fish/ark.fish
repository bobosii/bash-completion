function __ark_main_options
    yq '.options[].name' ~/arkcompiler/build/runtime_options_gen.yaml | sed 's/^/--/'
end

function __ark_suboptions
    set -l cur (commandline -ct)
    set -l mainopt (string split ":" -- $cur)[1]
    set -l cleanopt (string replace -- -- "" $mainopt)

    yq ".options[] | select(.name == \"$cleanopt\") | .sub_options[].name" ~/arkcompiler/build/runtime_options_gen.yaml 2>/dev/null | sed "s|^|$mainopt:|"
end

complete -c ark -f -n 'not string match -rq "^--.*:.*" -- (commandline -ct)' -a '(__ark_main_options)'

complete -c ark -f -n 'string match -rq "^--.*:.*" -- (commandline -ct)' -a '(__ark_suboptions)'

