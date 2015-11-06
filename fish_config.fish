# fish_config.fish -- Lorin's version

function fish_prompt
    set_color $fish_color_status   # red
    echo -n (hostname -s)
    set_color normal
    echo -n '$ '
end
