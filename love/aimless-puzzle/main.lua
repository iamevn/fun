require("maps")
function love.load()
    print("arrow keys to move\nq to quit\nr to restart level\nu to undo\nOverlap the circles")
    love.window.setMode(700, 700, {resizable=false, vsync=true, centered=true})
    sound_move = love.audio.newSource("sound/move.wav", "static")
    sound_oops = love.audio.newSource("sound/oops.wav", "static")
    sound_boom = love.audio.newSource("sound/boom.wav", "static")
    sound_win = love.audio.newSource("sound/win.wav", "static")
    sound_undo = love.audio.newSource("sound/undo.wav", "static")
    tilesize = 64
    player_a = {
        fill = .95, --size of circle relative to tilesize
        grid_x = 0, --current x coordinate in grid units
        grid_y = 0, --current y coordinate in grid units
        act_x = 0, --current x coordinate in pixels
        act_y = 0, --current y coordinate in pixels
        speed = 10, --speed for transition movement
        is_locked = false, --true if locked by a lock space
        color = { --color information
            r = 255,
            g = 0,
            b = 255,
            a = 127
        }
    }
    player_b = {
        fill = .95,
        grid_x = 0,
        grid_y = 0,
        act_x = 0,
        act_y = 0,
        speed = 10,
        is_locked = false,
        color = {
            r = 0,
            g = 255,
            b = 0,
            a = 150
        }
    }
    map = {}
    -- color to be used for text
    color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255,
        h = 0,
        s = 255,
        v = 255
    }
    initMap()
end

-- sets map tiles to whatever current_map is and sets up tilesize and player locations for the map effectively reseting the level
function initMap()
    map = current_map
    -- scale tilesize to fit window
    love.resize(love.window.getWidth(), love.window.getHeight())
    player_a.grid_x, player_a.grid_y = current_map.start_pos.a[1],current_map.start_pos.a[2]
    player_a.act_x, player_a.act_y = player_a.grid_x * tilesize, player_a.grid_y * tilesize
    player_b.grid_x, player_b.grid_y = current_map.start_pos.b[1],current_map.start_pos.b[2]
    player_b.act_x, player_b.act_y = player_b.grid_x * tilesize, player_b.grid_y * tilesize
    moves = {}
    hasWon = false
    isDead = false
end


-- undoes last move, need to skip over undos that don't do anything
function undo()
    if #moves > 0 then
        sound_undo:play()
        local move = table.remove(moves)
        player_a.grid_x = move[1]
        player_a.grid_y = move[2]
        player_a.act_x, player_a.act_y = player_a.grid_x * tilesize, player_a.grid_y * tilesize
        player_b.grid_x = move[3]
        player_b.grid_y = move[4]
        player_b.act_x, player_b.act_y = player_b.grid_x * tilesize, player_b.grid_y * tilesize
    end
end

-- test if space to move into is empty
function test_a(x, y)
    if map[player_a.grid_y + y][player_a.grid_x + x] == 1 then
        return false
    end
    return true
end

function test_b(x, y)
    if map[player_b.grid_y + y][player_b.grid_x + x] == 1 then
        return false
    end
    return true
end

-- test if a and b are in same spot
function checkIfWon()
    if player_a.grid_x == player_b.grid_x and player_a.grid_y == player_b.grid_y then
        sound_win:play()
        hasWon = true
    end
end

-- convert hsv into rgb
function hsv(h, s, v)
    if s <= 0 then
        return v, v, v
    end
    h, s, v = h / 256 * 6, s / 255, v /255
    local c = v * s
    local x = (1 - math.abs((h % 2) - 1)) * c
    local m, r, g, b = (v - c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return (r + m) * 255, (g + m) * 255, (b + m) * 255
end

function doMove(a, b)
    local a_can_move = test_a(a[1], a[2])
    local b_can_move = test_b(b[1], b[2])
    if a_can_move or b_can_move then
        table.insert(moves, {player_a.grid_x, player_a.grid_y, player_b.grid_x, player_b.grid_y})
        sound_move:play()
    else
        sound_oops:play()
    end
    if a_can_move then
        if not player_a.is_locked then
            player_a.grid_x = player_a.grid_x + a[1]
            player_a.grid_y = player_a.grid_y + a[2]
            if map[player_a.grid_y][player_a.grid_x] == 2 then
                player_a.is_locked = true
                player_a.color.a = player_a.color.a - 100
            end
        else
            player_a.is_locked = false
            player_a.color.a = player_a.color.a + 100
        end
    end
    if b_can_move then
        if not player_b.is_locked then
            player_b.grid_x = player_b.grid_x + b[1]
            player_b.grid_y = player_b.grid_y + b[2]
            if map[player_b.grid_y][player_b.grid_x] == 2 then
                player_b.is_locked = true
                player_b.color.a = player_b.color.a - 100
            end
        else
            player_b.is_locked = false
            player_b.color.a = player_b.color.a + 100
        end
    end

    checkIfWon()
    -- if player is intersected with a killsquare (-1 on level board) kill
    if map[player_a.grid_y][player_a.grid_x] == -1 or map[player_b.grid_y][player_b.grid_x] == -1 then
        kill()
    end
end

function kill()
    sound_boom:play()
    isDead = true
end

function love.keypressed(key)
    if hasWon then 
        if key == "n" then
            nextMap()
        end
    elseif isDead then
        if key == "u" then
            undo()
            isDead = false
        end
    else
        if key == "up" or key == "k" then
            doMove({0, -1}, {0, 1})
        elseif key == "down" or key == "j" then
            doMove({0, 1}, {0, -1})
        elseif key == "left" or key == "h" then
            doMove({-1, 0}, {1, 0})
        elseif key == "right" or key == "l" then
            doMove({1, 0}, {-1, 0})
        elseif key == "u" then
            undo()
        end
    end
    if key == "escape" or key == "q" then
        love.event.push("quit")
    elseif key == "r" or key == " " then
        initMap()
    end
end

function love.update(dt)
    player_a.act_x = player_a.act_x - ((player_a.act_x - (player_a.grid_x * tilesize)) * player_a.speed * dt)
    player_a.act_y = player_a.act_y - ((player_a.act_y - (player_a.grid_y * tilesize)) * player_a.speed * dt)

    player_b.act_x = player_b.act_x - ((player_b.act_x - (player_b.grid_x * tilesize)) * player_b.speed * dt)
    player_b.act_y = player_b.act_y - ((player_b.act_y - (player_b.grid_y * tilesize)) * player_b.speed * dt)
end

--called when window is resized
function love.resize(w, h)
    tilesize = w / (map.x_tiles + 2)
    if tilesize * (map.y_tiles + 2) > h then
        tilesize = h / (map.y_tiles +2)
    end

    player_a.act_x, player_a.act_y = player_a.grid_x * tilesize, player_a.grid_y * tilesize
    player_b.act_x, player_b.act_y = player_b.grid_x * tilesize, player_b.grid_y * tilesize
end

function love.draw()
    -- set origin so that tiles are always in center
    local x = (love.window.getWidth() - tilesize * (map.x_tiles + 2)) / 2
    local y = (love.window.getHeight() - tilesize * (map.y_tiles + 2)) / 2
    love.graphics.translate(x, y)

    -- draw walls and pits
    for y = 1, map.y_tiles do
        for x = 1, map.x_tiles do
            if map[y][x] == 1 then
                love.graphics.setColor(map.wall_color.r, map.wall_color.g, map.wall_color.b, map.wall_color.a)
                love.graphics.rectangle("fill", x * tilesize, y * tilesize, tilesize, tilesize)
            elseif map[y][x] == -1 then
                love.graphics.setColor(map.pit_color.r, map.pit_color.g, map.pit_color.b, map.pit_color.a)
                love.graphics.rectangle("fill", x * tilesize, y * tilesize, tilesize, tilesize)
            elseif map[y][x] == 2 then
                love.graphics.setColor(map.lock_color.r, map.lock_color.g, map.lock_color.b, map.lock_color.a)
                love.graphics.rectangle("line", x * tilesize, y * tilesize, tilesize, tilesize)
            end
        end
    end

    -- draw players
    love.graphics.setColor(player_b.color.r, player_b.color.g, player_b.color.b, player_b.color.a)
    love.graphics.circle("fill", player_b.act_x + tilesize / 2, player_b.act_y + tilesize / 2, tilesize / 2 * player_b.fill, 250)

    love.graphics.setColor(player_a.color.r, player_a.color.g, player_a.color.b, player_a.color.a)
    love.graphics.circle("fill", player_a.act_x + tilesize / 2, player_a.act_y + tilesize / 2, tilesize / 2 * player_a.fill, 250)

    if isDead then
        love.graphics.setNewFont(40)
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.print("ded\n\n[r]estart\n[q]uit\n[u]ndo")
    elseif hasWon then -- win condition
        -- Rainbow color change by stepping hue (and converting to rgb)
        if color.h < 255 then
            color.h = color.h + 1
        else
            color.h = 0
        end
        color.r, color.g, color.b = hsv(color.h, color.s, color.v)

        love.graphics.setNewFont(40)
        love.graphics.setColor(color.r, color.g, color.b, color.a)
        love.graphics.print("Congratulation!\n\n\n\n[n]ext level\n[q]uit", 0, 0)
    end
end
