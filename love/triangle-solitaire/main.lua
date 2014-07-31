math.randomseed(os.time())
love.window.setMode(700, 700, {resizable=false, vsync=false})
print("[q] or [esc] to quit\n[r] to restart\n[f] to toggle fullscreen")

-- run on load or on reset
function love.load()
    -- rows in triangle, diameter of circles, speed of movement
    height, diameter, speed = 5, 50, 15
    numCircles = height + ((height - 1) / 2) * height

    triangle = {}
    for y = 1, height do
        triangle[y] = {}
        for x = 1, y do
            triangle[y][x] = randColor()
        end
    end

    love.resize(love.window.getWidth(), love.window.getHeight())
    for y = 1, height do
        for x = 1, y do
            triangle[y][x]["act_x"] = triangle[y][x]["mid_x"]
            triangle[y][x]["act_y"] = triangle[y][x]["mid_y"]
        end
    end

    -- used for win screen text (hsv to make the rainbow effect simpler)
    textColor = {
        r = 255,
        g = 255,
        b = 255,
        a = 255,
        h = 0,
        s = 255,
        v = 255
    }
    emptyColor = {
        r = 50, 
        g = 50, 
        b = 50, 
        a = 255
    }
    emptySize = diameter / 2

    needToRemoveOne, noneSelected = true, true
end

-- q and escape quit
-- r resets
-- f toggles fullscreen
function love.keypressed(key)
    if key == "q" or key == "escape" then
        love.event.push("quit")
    elseif key == "r" then
        love.load()
    elseif key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
    end
end

-- the first circle clicked on will be removed
-- after that, clicking a circle will select it
-- clicking an empty spot will try to jump the selected circle there
-- clicking anything but a circle will deselect the current circle
function love.mousepressed(x, y, button)
    sel_x, sel_y = pixelToTriangle(x - origin.x, y - origin.y)
    -- if a circle's spot was clicked
    if sel_x ~= 0 and sel_y ~= 0 then 
        if needToRemoveOne then
            setEmpty(sel_x, sel_y)
            numCircles = numCircles - 1
            needToRemoveOne = false
        elseif noneSelected then
            hold(sel_x, sel_y)
        else
            tryToJumpTo(sel_x, sel_y)
        end
    else
        noneSelected = true
    end
end

-- set up circle diameter to fit nicely on screen 
-- store the location onscreen for each circle's midpoint
-- set the origin for drawing so that the triangle will be centered
function love.resize(w, h)
    diameter = w / (height * 2)
    if diameter * (height * 2) > h then
        diameter = h / (height * 2)
    end
    
    for y = 1, height do
        for x = 1, y do
            -- leave one diameter of spacing between each circle horizontally and phi diameters of spacing vertically
            triangle[y][x]["mid_x"] = diameter * (2 * (x - 1) + (height - y + 0.5))
            triangle[y][x]["mid_y"] = diameter * y * ((1 + math.sqrt(5)) / 2) - (diameter / 2)
        end
    end
    origin = {
        x = (love.window.getWidth() - diameter * (height * 2 - 1)) / 2,
        y = (love.window.getHeight() - diameter * (height * 2 - 1)) / 2
    }
end

-- move each circle's pixel location torwards their set midpoint
function love.update(dt)
    for y = 1, height do
        for x = 1, y do
            if triangle[y][x][1] ~= "empty" then
                triangle[y][x]["act_x"] = triangle[y][x]["act_x"] - ((triangle[y][x]["act_x"] - triangle[y][x]["mid_x"]) * speed * dt)
                triangle[y][x]["act_y"] = triangle[y][x]["act_y"] - ((triangle[y][x]["act_y"] - triangle[y][x]["mid_y"]) * speed * dt)
            end
        end
    end
end

-- draw text and graphics
function love.draw()
    love.graphics.setNewFont(30)
    if not noneSelected then
        love.graphics.setColor(tableToColor(triangle[held_y][held_x]))
        love.graphics.print("\ncircle " .. held_x .. ", " .. held_y .. " selected")
    else
        love.graphics.setColor(textColor.r, textColor.g, textColor.b, textColor.a)
        love.graphics.print("\nnone selected")
    end

    if numCircles == 1 then
        -- do a simple rainbow effect on the text if have won
        if textColor.h < 255 then
            textColor.h = textColor.h + 1
        else
            textColor.h = 0
        end
        textColor.r, textColor.g, textColor.b = hsv(textColor.h, textColor.s, textColor.v)
        love.graphics.setColor(textColor.r, textColor.g, textColor.b, textColor.a)
        love.graphics.print("!!!!!!")
    else
        love.graphics.print(numCircles .. " left")
    end

    -- set origin so that tiles are always in center
    love.graphics.translate(origin.x, origin.y)

    -- draw circles
    for y = 1, height do
        for x = 1 , y do
            if triangle[y][x][1] == "empty" then
                love.graphics.setColor(tableToColor(emptyColor))
                love.graphics.rectangle("fill", triangle[y][x]["mid_x"] - emptySize / 2, triangle[y][x]["mid_y"] - emptySize / 2, emptySize, emptySize)
            else
                love.graphics.setColor(tableToColor(triangle[y][x]))
                love.graphics.circle("fill", triangle[y][x]["act_x"], triangle[y][x]["act_y"], diameter / 2, 100)
            end
        end
    end
end

-- returns a random rgb color
function randColor()
    return {
        r = math.random(255), 
        g = math.random(255), 
        b = math.random(255), 
        a = 255
    }
end

-- returns table's r, g, b, and a components
function tableToColor(t)
    return t.r, t.g, t.b, t.a
end

-- returns coordinates in tranagle table for the circle containing the pixel point (x, y). returns (0, 0) if (x, y) is not in a circle
function pixelToTriangle(px_x, px_y)
    local dist = 0
    for y = 1, height do
        for x = 1, y do
            dist = distance(triangle[y][x]["mid_x"], triangle[y][x]["mid_y"], px_x, px_y)
            if dist <= diameter / 2 then
                return x, y
            end
        end
    end

    return 0, 0
end

-- returns the distance between two points
function distance(ax, ay, bx, by)
    return math.sqrt((ax - bx) ^ 2 + (ay - by) ^ 2)
end

-- !! fix terrible brute force circle finder thing !!
--                 (1, 1)
--             (1, 2), (2, 2)
--         (1, 3), (2, 3), (3, 3)
--     (1, 4), (2, 4), (3, 4), (4, 4)
-- (1, 5), (2, 5), (3, 5), (4, 5), (5, 5)
-- idea 1:
--      start at (1, 1) 
--      find distance
--      if in circle, found it
--      else check circles around distance away from first circle
-- idea 2:
--      check if point is in main triangle
--      divide into subtriangles
--      identify which point is in
--      repeat until down to a circle, at which point check if in circle
-- idea 3:
--      somehow identify closest midpoint
--      check if in circle

-- if spot is already empty, return false
-- otherwise remove circle in spot
-- (expects valid coordinates)
function setEmpty(x, y)
    if triangle[y][x][1] ~= "empty" then
        local mid_x, mid_y = triangle[y][x]["mid_x"], triangle[y][x]["mid_y"]
        triangle[y][x] = {"empty"}
        triangle[y][x]["mid_x"] = mid_x
        triangle[y][x]["mid_y"] = mid_y
        return true
    else
        return false
    end
end

-- select a circle, do nothing if empty spot (expects valid coordinates)
function hold(x, y)
    if triangle[y][x][1] ~= "empty" then
        held_x, held_y = x, y -- has no meaning if noneSelected == true
        noneSelected = false
    end
end

-- if spot is empty, jump selected circle there
-- if spot isn't empty select the circle there
-- (expects valid coordinates)
function tryToJumpTo(x, y)
    if triangle[y][x][1] == "empty" then
        jumpTo(x, y)
        -- what the fuck? need to call resize to update graphics
        love.resize(love.graphics.getWidth(), love.graphics.getHeight())
        noneSelected = true
    else
        hold(x, y)
    end
end

-- returns true if a spot is a valid jump point from selected circle and removes the intermediate circle
-- if point is not 2 away or point doesn't have a circle to remove in between then returns false
-- for a point valid jump points are 2 away along hex grid with a circle between it and jump point
--  a   b
--   \ /
--  c-*-d
--   / \
--  e   f
--  a: (x - 2, y - 2)
--  b: (x, y - 2)
--  c: (x - 2, y)
--  d: (x + 2, y)
--  e: (x, y + 2)
--  f: (x + 2, y + 2)
function checkValidAndRemove(x, y)
    if held_x == x then
        if held_y - 2 == y then
            -- case b
            return setEmpty(held_x, held_y - 1)
        elseif held_y + 2 == y then
            -- case e
            return setEmpty(held_x, held_y + 1)
        end
    elseif held_x - 2 == x then
        if held_y - 2 == y then
            -- case a
            return setEmpty(held_x - 1, held_y - 1)
        elseif held_y == y then
            -- case c
            return setEmpty(held_x - 1, held_y)
        end
    elseif held_x + 2 == x then
        if held_y == y then
            -- case d
            return setEmpty(held_x + 1, held_y)
        elseif held_y + 2 == y then
            -- case f
            return setEmpty(held_x + 1, held_y + 1)
        end
    end
    return false
end

-- jumps circle if jump is valid, removing the circle jumped over
function jumpTo(x, y)
    if checkValidAndRemove(x, y) then
        triangle[y][x] = triangle[held_y][held_x]
        setEmpty(held_x, held_y)
        numCircles = numCircles - 1
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
