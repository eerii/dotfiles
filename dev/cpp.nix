{ pkgs, ... }:
{
    devenv.shells.gcc = {
        packages = with pkgs; [ gcc13 cmake ];
        enterShell = ''
            mkdir -p bin
            g() {
                if [ $# -eq 0 ]; then
                    echo "Usage: g <filename>"
                    return 1
                fi
                if [[ "$1" == *.c || "$1" == *.cpp ]]; then
                    echo "Enter the file name without .c/.cpp"
                    return 1
                fi
                gcc "$1.c" -o "bin/$1" $\{@:2\}
            }
            c() {
                if [ -f "$PWD/makefile" -o -f "$PWD/Makefile" ]; then
                    make
                else
                    g $1
                fi
                ./bin/$1 $\{@:2\}
            }
        '';
    };

    devenv.shells.clang = {
        packages = with pkgs; [ llvmPackages_16.libcxxClang cmake ];
        enterShell = "";
    };

}
