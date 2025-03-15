-- Beep boop testing testing...
-- If you are using vs code, you can run this with shortcut alt+L

function love.load()
    number = 0
end

function love.update(dt)
    if number < 10000 then number = number + 1 end
end

function love.draw()
    -- Note the top-left origin convention
    -- i.e. y coords will increment positively going "down" from the 
    -- top-left of the screen
    love.graphics.print("Hello World!", 400, 300)
    love.graphics.print(number, 400, 350)
end

