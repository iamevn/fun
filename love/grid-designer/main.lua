function love.load()
    love.window.setMode(700, 700, {resizable=false, vsync=false, centered=true})
    tilesize = 64
    width = 5
    height = 5
    grid = {{}}
    gridColor = {200, 200, 200, 255}
    blockTypes = {}
    blockTypes[-3] = {"a start"}
    blockTypes[-2] = {"b start"}
    blockTypes[-1] = {"pit", "fill", 255, 0, 0, 255}
    blockTypes[0] = {"space", "fill", 0, 0, 0, 255}
    blockTypes[1] = {"wall", "fill", 255, 255, 255, 255}
    blockTypes[2] = {"lock", "line", 0, 0, 255, 255}
    currentBlock = 0
    aStart = {}
    bStart = {}
    changeGrid(width, height)
    timer = 0
    clicks = {}
end

function love.keypressed(key)
    if key == "q" then
        love.event.push("quit")
    -- shift + hjkl/←↓↑→ to grow/shrink grid horizontally/vertically
    elseif (key == "l" or key == "right") and love.keyboard.isDown("lshift", "rshift") then
        changeGrid(width + 1, height)
    elseif (key == "h" or key == "left") and love.keyboard.isDown("lshift", "rshift") then
        if width > 1 then
            changeGrid(width - 1, height)
        end
    elseif (key == "j" or key == "down") and love.keyboard.isDown("lshift", "rshift") then
        changeGrid(width, height + 1)
    elseif (key == "k" or key == "up") and love.keyboard.isDown("lshift", "rshift") then
        if height > 1 then
            changeGrid(width, height - 1)
        end
    -- shift + s to save
    elseif key == "s" and love.keyboard.isDown("lshift", "rshift") then
        saveToFile("maps")
    end
end

-- store starting grid coordinates for mouse press
function love.mousepressed(x, y, button)
    if button == "l" then
        press_x, press_y = pixelToGrid(x, y)
    elseif button == "r" then
        cycle(1)
    elseif button == "m" then
        cycle(-1)
    end
end

-- highlight each square in range from where mouse was pressed to where it was released
function love.mousereleased(x, y, button)
    if button == "l" then
        rel_x, rel_y = pixelToGrid(x, y)
        if rel_x ~= 0 and rel_y ~= 0 and press_x ~= 0 and press_y ~= 0 then
            for y=math.min(rel_y, press_y), math.max(rel_y, press_y) do
                for x=math.min(rel_x, press_x), math.max(rel_x, press_x) do
                    highlight(x, y, currentBlock)
                end
            end
        end
    end
end

function love.update(dt)
    timer = timer + dt
end

-- resize tiles to best fit window size
function love.resize(w, h)
    tilesize = w / (width + 2)
    if tilesize * (height + 2) > h then
        tilesize = h / (height + 2)
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("width: " .. #grid[1] .. "\nheight: " .. #grid .. "\ncurrent block: " .. blockTypes[currentBlock][1])
    -- set origin so that tiles are always in center
    x_org = (love.window.getWidth() - tilesize * (width + 2)) / 2
    y_org = (love.window.getHeight() - tilesize * (height + 2)) / 2
    love.graphics.translate(x_org, y_org)

    love.graphics.setColor(255, 255, 255, 255)
    for y = 1, height do
        for x = 1, width do
            love.graphics.setColor(tableToColor(blockTypes[grid[y][x]], 2))
            love.graphics.rectangle(blockTypes[grid[y][x]][2], x * tilesize, y * tilesize, tilesize, tilesize)
            if blockTypes[grid[y][x]][2] == "fill" then
                love.graphics.setColor(tableToColor(gridColor))
                love.graphics.rectangle("line", x * tilesize, y * tilesize, tilesize, tilesize)
            end
        end
    end
    if #aStart == 2 then
        love.graphics.setColor(255, 0, 255, 127)
        love.graphics.circle("fill", aStart[1] * tilesize + (tilesize / 2), aStart[2] * tilesize + (tilesize / 2), tilesize / 2 * .95, 100)
    end
    if #bStart == 2 then
        love.graphics.setColor(0, 255, 0, 150)
        love.graphics.circle("fill", bStart[1] * tilesize + (tilesize / 2), bStart[2] * tilesize + (tilesize / 2), tilesize / 2 * .95, 100)
    end
end

function changeGrid(newWidth, newHeight)
    local tempArray = {}
    for y = 1, newHeight do
        tempArray[y] = {}
        for x = 1, newWidth do
            if #grid >= y and #grid[1] >= x then
                tempArray[y][x] = grid[y][x]
            else
                tempArray[y][x] = 0
            end
        end
    end

    grid = tempArray
    width, height = newWidth, newHeight
    love.resize(love.window.getWidth(), love.window.getHeight())
end

-- converts pixel coordinates to grid coordinates (returns 0, 0 if outside of grid)
function pixelToGrid(pixel_x, pixel_y)
    local x, y = (pixel_x - x_org) / tilesize, (pixel_y - y_org) / tilesize
    x, y = math.floor(x), math.floor(y)
    if x < 1 or y < 1 or x > width or y > height then
        return 0, 0
    else
        return x, y
    end
end

-- changes grid[y][x] to be c if it isn't c or 0 if it is c
function highlight(x, y, c)
    if x > 0 and x <= width and y > 0 and y <= height then
        if c == -3 then
            aStart = {x, y}
        elseif c == -2 then
            bStart = {x, y}
        elseif grid[y][x] == c then
            grid[y][x] = 0
        else
            grid[y][x] = c
        end
    end
end

-- cycles forward and back through types of blocks
function cycle(i)
    if i == nil then
        i = 1
    end

    currentBlock = (currentBlock + 3 + i) % 6 - 3
end

function tableToColor(colorTable, i)
    if i == null then
        i = 0
    end
    return colorTable[1 + i], colorTable[2 + i], colorTable[3 + i], colorTable[4 + i]
end

-- output the map grid to a file
function saveToFile(filename)
    output = "\n{"
    for y = 1, #grid do
        output = output .. "\n    {"
        for x = 1, #grid[y] do
            if grid[y][x] >= 0 then
                output = output .. " "
            end
            output = output .. grid[y][x] .. ","
        end
        output = output .. " },"
    end
    output = output .. "\n    x_tiles = " .. #grid[1] .. ","
    output = output .. "\n    y_tiles = " .. #grid .. ","
    output = output .. "\n    start_pos = {"
    if #aStart == 2 then
        output = output .. "\n        a = {" .. aStart[1] .. ", " .. aStart[2] .. "},"
    end
    if #bStart == 2 then
        output = output .. "\n        b = {" .. bStart[1] .. ", " .. bStart[2] .. "},"
    end
    output = output .. "\n    }\n}"
    print(output)
    print("saving to file " .. filename)
    local file = assert(io.open(filename, "a"))
    file:write(output)
    file:close()
end
