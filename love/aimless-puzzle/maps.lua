map1 = { 
    --tile grid, 0 is space. 1 is wall. -1 is death pit. (required). 2 is locker.
    { 1, 1, 1, 1, 1, },
    { 1, 0, 0, 1, 1, },
    { 1,-1, 0,-1, 1, },
    { 1, 1, 0, 0, 1, },
    { 1, 1, 1, 1, 1, },
    x_tiles = 5, --width of tile grid (required)
    y_tiles = 5, --height of tile grid (required)
    --color for walls (needed if walls present)
    wall_color = { 
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    --color for pits (needed if pits present)
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    --starting coordinates for player_a and player_b (required)
    start_pos = { 
        a = {2, 2},
        b = {4, 4}
    }
}
map2 = {
    { 1, 1, 1, 1, 1,-1, 1, 1, 1, 1, 1, },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, },
    { 1,-1, 0,-1, 0, 0, 0,-1, 0,-1, 1, },
    { 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, },
    { 1, 1, 1, 1, 1,-1, 1, 1, 1, 1, 1, },
    x_tiles = 11,
    y_tiles = 5,
    wall_color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    start_pos = {
        a = {2, 2},
        b = {10, 4}
    }
}
map3 = {
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0,-1, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 1, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    x_tiles = 8,
    y_tiles = 8,
    wall_color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    start_pos = {
        a = {3, 2},
        b = {7, 7}
    }
}
map4 = {
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 1, 1, 0, 1, 0, 1 },
    { 1, 0, 1, 1, 0, 1, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 1, 0, 1, 1, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    x_tiles = 8,
    y_tiles = 8,
    wall_color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    start_pos = {
        a = {4, 5},
        b = {5, 5}
    }
}
map5 = {
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 1, 1, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 1,-1,-1, 1, 0, 1 },
    { 1, 0, 1,-1,-1, 1, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    x_tiles = 8,
    y_tiles = 8,
    wall_color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    start_pos = {
        a = {2, 2},
        b = {7, 7}
    }
}
map6 = {
    { 1, 1, 1, 1, 1, 0, 0, 0 },
    { 1, 0, 0, 0, 1, 0, 0, 0 },
    { 1, 0, 1, 0, 1, 0, 0, 0 },
    { 1, 0,-1, 0,-1, 1, 1, 1 },
    { 1, 0,-1, 0, 0, 0, 0, 1 },
    { 1, 0,-1, 0, 0,-1, 0, 1 },
    { 1, 0,-1, 0, 0,-1, 0, 1 },
    { 1, 0,-1, 0, 0,-1, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1 },
    x_tiles = 8,
    y_tiles = 10,
    wall_color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    start_pos = {
        a = {2, 2},
        b = {7, 6}
    }
}
map7 = { 
    --tile grid, 0 is space. 1 is wall. -1 is death pit. 2 is locker. (required).
    { 1, 1, 1, 1, 1, 1, 1, 1, },
    { 1, 0, 0, 2, 2, 2, 2, 1, },
    { 1, 0, 0, 0, 0, 0, 2, 1, },
    { 1, 2, 0, 0, 0, 0, 2, 1, },
    { 1, 2, 0, 0, 1, 0, 2, 1, },
    { 1, 2, 0, 0, 0, 0, 0, 1, },
    { 1, 2, 2, 2, 2, 0, 0, 1, },
    { 1, 1, 1, 1, 1, 1, 1, 1, },
    x_tiles = 8, --width of tile grid (required)
    y_tiles = 8, --height of tile grid (required)
    --color for walls (needed if walls present)
    wall_color = { 
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    --color for pits (needed if pits present)
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    --color for locks (needed if locks present)
    lock_color = {
        r = 0,
        g = 0,
        b = 255,
        a = 255
    },
    --starting coordinates for player_a and player_b (required)
    start_pos = { 
        a = {2, 2},
        b = {7, 7}
    }
}
map8 = { 
    --tile grid, 0 is space. 1 is wall. -1 is death pit. 2 is locker. (required).
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
    { 1, 0, 0, 2, 2, 2, 2, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, },
    { 1, 0, 0, 0, 0, 0, 2, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, },
    { 1, 2, 0, 0, 0, 0, 2, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, },
    { 1, 2, 0, 0, 1, 0, 2, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, },
    { 1, 2, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, },
    { 1, 2, 2, 2, 2, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
    x_tiles = 25, --width of tile grid (required)
    y_tiles = 8, --height of tile grid (required)
    --color for walls (needed if walls present)
    wall_color = { 
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    --color for pits (needed if pits present)
    pit_color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255
    },
    --color for locks (needed if locks present)
    lock_color = {
        r = 0,
        g = 0,
        b = 255,
        a = 255
    },
    --starting coordinates for player_a and player_b (required)
    start_pos = { 
        a = {2, 2},
        b = {7, 7}
    }
}
-- the starting map
current_map = map1
-- shitty way to load next map
function nextMap()
    if current_map == map1 then current_map = map2
    elseif current_map == map2 then current_map = map3
    elseif current_map == map3 then current_map = map4
    elseif current_map == map4 then current_map = map5
    elseif current_map == map5 then current_map = map6
    elseif current_map == map6 then current_map = map7
    elseif current_map == map7 then current_map = map8
    elseif current_map == map8 then love.event.push("quit") end
    initMap()
end
