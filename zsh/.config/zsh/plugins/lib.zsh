
BASE_PATH=~/.config/zsh/plugins

plugins=(
    /nx-completion/nx-completion.plugin.zsh
    /zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)


for plugin in $plugins; do
    plugin_path="${BASE_PATH}${plugin}"
    if [[ -f $plugin_path ]]; then
        source "$plugin_path"
    else
        echo "Plugin not found: $plugin_path" >&2
    fi
done
