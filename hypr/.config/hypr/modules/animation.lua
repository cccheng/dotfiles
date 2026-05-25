local hl = _G.hl

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("easeOutQuint",     { type = "bezier", points = {  {0.23,    1},    {0.32, 1}        } })
hl.curve("easeInOutCubic",   { type = "bezier", points = {  {0.65,    0.05}, {0.36, 1}        } })
hl.curve("linear",           { type = "bezier", points = {  {0,       0},    {1,    1}        } })
hl.curve("almostLinear",     { type = "bezier", points = {  {0.5,     0.5},  {0.75, 1}        } })
hl.curve("quick",            { type = "bezier", points = {  {0.15,    0},    {0.1,  1}        } })
hl.curve("bounce",           { type = "bezier", points = {  {0.91,    0.12}, {0.86, 1.36}     } })

hl.curve("spring_menu",      { type = "spring", mass   = 1, stiffness =      80,    dampening = 14 })
hl.curve("spring_window",    { type = "spring", mass   = 1, stiffness =      30,    dampening = 8  })
hl.curve("spring_workspace", { type = "spring", mass   = 1, stiffness =      30,    dampening = 10 })
hl.curve("spring_special",   { type = "spring", mass   = 1, stiffness =      30,    dampening = 8  })

hl.animation({ leaf = "global",           enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border",           enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true, speed = 5, spring = "spring_window",    style = "gnomed" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 3, spring = "spring_window",    style = "gnomed" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1, spring = "spring_window",    style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3, spring = "spring_window" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 3, spring = "spring_window" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1, spring = "spring_window" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1, bezier = "almostLinear" })
hl.animation({ leaf = "zoomFactor",       enabled = true, speed = 7, bezier = "quick" })

hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, spring = "spring_workspace", style = "slide" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 5, spring = "spring_workspace", style = "slidefade" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 1, spring = "spring_workspace", style = "slidefade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, spring = "spring_special",   style = "slidefadevert -50%" })

