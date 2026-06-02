# mkdir -p then cd into the new directory.
function mkcd --description 'mkdir -p and cd into it'
    mkdir -p $argv[1]; and cd $argv[1]
end
