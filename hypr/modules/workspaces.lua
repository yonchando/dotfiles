-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
--
local monitor1 = "HDMI-A-1"
local monitor2 = "DP-1"

hl.workspace_rule({
    workspace = "1",
    monitor = monitor1,
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = monitor1,
    persistent = true
})

hl.workspace_rule({
    workspace = "3",
    monitor = monitor1,
    persistent = true,
})

hl.workspace_rule({
    workspace = "4",
    monitor = monitor1,
    persistent = true,
})

hl.workspace_rule({
    workspace = "5",
    monitor = monitor1,
    persistent = true,
})

hl.workspace_rule({
    workspace = "6",
    monitor = monitor1
})

hl.workspace_rule({
    workspace = "7",
    monitor = monitor2,
})

hl.workspace_rule({
    workspace = "8",
    monitor = monitor2,
})

hl.workspace_rule({
    workspace = "9",
    monitor = monitor2,
    default = true,
})
