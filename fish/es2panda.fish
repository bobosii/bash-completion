function __es2panda_main_options
    echo --es2panda
    echo --help
    echo --arktsconfig
    echo --extension
    echo --module
    echo --parse-only
    echo --dump-ast
    echo --dump-cfg
    echo --dump-dynamic-ast
    echo --dump-ast-only-silent
    echo --list-files
    echo --parse-jsdoc
    echo --dump-assembly
    echo --debug-info
    echo --dump-debug-info
    echo --opt-level
    echo --ets-module
    echo --eval-mode
    echo --ets-warnings
    echo --werror
    echo --enable
    echo --disable
    echo --debugger-eval
    echo --line
    echo --source
    echo --panda-files
    echo --generate-decl
    echo --enabled
    echo --path
    echo --emit-declaration
    echo --thread
    echo --dump-size-stat
    echo --output
    echo --log-level
    echo --stdlib
    echo --gen-stdlib
    echo --plugins
    echo --skip-phases
    echo --ast-verifier
    echo --warnings
    echo --errors
    echo --phases
    echo --full-program
    echo --json
    echo --json-path
    echo --list-phases
    echo --ets-unnamed
    echo --ets-path
    echo --exit-before-phase
    echo --exit-after-phase
    echo --dump-before-phases
    echo --dump-after-phases
    echo --dump-ets-src-before-phases
    echo --dump-ets-src-after-phases
    echo --bco-optimizer
    echo --bco-compiler
    echo --perm-arena
    echo --dump-perf-metrics
    echo --simultaneous
end

function __es2panda_suboptions
    set -l cur (commandline -ct)
    set -l mainopt (string split ":" -- $cur)[1]
    set -l cleanopt (string replace -- -- "" $mainopt)
    if test $cleanopt = 'ets-warnings'; echo --ets-warnings:disable; end
    if test $cleanopt = 'ets-warnings'; echo --ets-warnings:enable; end
    if test $cleanopt = 'ets-warnings'; echo --ets-warnings:werror; end
    if test $cleanopt = 'debugger-eval'; echo --debugger-eval:line; end
    if test $cleanopt = 'debugger-eval'; echo --debugger-eval:panda-files; end
    if test $cleanopt = 'debugger-eval'; echo --debugger-eval:source; end
    if test $cleanopt = 'generate-decl'; echo --generate-decl:enabled; end
    if test $cleanopt = 'generate-decl'; echo --generate-decl:path; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:errors; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:full-program; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:json; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:json-path; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:phases; end
    if test $cleanopt = 'ast-verifier'; echo --ast-verifier:warnings; end
end

complete -c es2panda -n 'string match -rq "^-" -- (commandline -ct) && not string match -rq "^--.*:.*" -- (commandline -ct)' -a '(__es2panda_main_options)'
complete -c es2panda -f -n 'string match -rq "^--.*:.*" -- (commandline -ct)' -a '(__es2panda_suboptions)'
