# Go N directories up (default 1). Usage: up   up 3
function up --description 'Go N directories up'
    set -l n 1
    if string match -qr '^\d+$' -- $argv[1]
        set n $argv[1]
    end
    cd (string repeat -n $n ../)
end
