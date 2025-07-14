function __ark_disasm_options
    printf "%s\n" \
        --help \
        --verbose \
        --quiet \
        --skip-string-literals \
        --debug \
        --debug-file \
        --version
end

function __ark_disasm_debug_file_paths
    set -l cur (string split ":" -- (commandline -ct))[2]
    commandline -f complete
    for file in (commandline -C | string match -r '^.*$')
        echo --debug-file:$file
    end
end

complete -c ark_disasm -f -n 'string match -rq "^--debug-file:.*" -- (commandline -ct)' -a '(for f in (ls); echo --debug-file:$f; end)'

complete -c ark_disasm -f -n 'string match -rq "^--" -- (commandline -ct)' -a '(__ark_disasm_options)'

complete -c ark_disasm -f -n 'not string match -rq "^--" -- (commandline -ct)' -a '(ls)'

