# Universal archive extractor. Usage: extract <file> [file ...]
function extract --description 'Extract any archive'
    for file in $argv
        if not test -f $file
            echo "extract: '$file' is not a file"
            continue
        end

        switch $file
            case '*.tar.gz' '*.tgz'
                tar xzf $file
            case '*.tar.bz2' '*.tbz2'
                tar xjf $file
            case '*.tar.xz' '*.txz'
                tar xJf $file
            case '*.tar.zst'
                tar --zstd -xf $file
            case '*.tar'
                tar xf $file
            case '*.zip'
                if command -q unzip
                    unzip $file
                else
                    echo "extract: unzip not found"
                end
            case '*.gz'
                if command -q gunzip
                    gunzip $file
                else
                    echo "extract: gunzip not found"
                end
            case '*.bz2'
                if command -q bunzip2
                    bunzip2 $file
                else
                    echo "extract: bunzip2 not found"
                end
            case '*.xz'
                if command -q xz
                    xz -d $file
                else
                    echo "extract: xz not found"
                end
            case '*.zst'
                if command -q zstd
                    zstd -d $file
                else
                    echo "extract: zstd not found"
                end
            case '*.7z'
                if command -q 7z
                    7z x $file
                else
                    echo "extract: 7z not found"
                end
            case '*.rar'
                if command -q unrar
                    unrar x $file
                else
                    echo "extract: unrar not found"
                end
            case '*.Z'
                if command -q uncompress
                    uncompress $file
                else
                    echo "extract: uncompress not found"
                end
            case '*'
                echo "extract: '$file' — unknown archive format"
        end
    end
end
