# Copy a file to <file>.bak. Usage: backup file.conf
function backup --description 'Copy file to file.bak'
    if test (count $argv) -ne 1
        echo "Usage: backup <file>"
        return 1
    end
    cp $argv[1] $argv[1].bak
end
