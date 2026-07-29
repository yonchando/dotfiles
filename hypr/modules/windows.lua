hl.window_rule({
    match = {
        class = "^(org.telegram.desktop)$",
    },
    workspace = "1",
})

hl.window_rule({
    match = {
        class = "^(google-chrome)$",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(jetbrains-datagrip)$",
    },
    workspace = "5",
})

hl.window_rule({
    match = {
        class = "^(swayimg)$",
    },
    size = {1600, 900},
    float = true
})

hl.window_rule({
    match = {
        class = "^(org.gnome.Nautilus)$",
    },
    size = {1600, 900},
    float = true
})

hl.window_rule({
    match = {
        class = "^(org.gnome.Loupe)$",
    },
    size = {1600, 900},
})

hl.window_rule({
    match = {
        class = "^(vlc)$",
    },
    workspace = "9",
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "19 monitor_h-120",
    float = true,
})
