vcmd=$(command -v nvim &>/dev/null && echo nvim || echo vim)
echo $vcmd
if [ "$vcmd" == "nvim" ]; then
        vfl="$HOME/.local/share/nvim/session"
else
        vfl="$HOME/.vim/session"
fi
file=$(find $vfl -type f | fzf +m -1)
if [ -n "$file" ]; then
        vcd=$(grep -em 1 'cd ' "$file")
        if [ -n "$vcd" ]; then
                ${vcd//\~/$HOME}
        fi
        $vcmd
fi
