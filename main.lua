local Game = require "game"

local Food = require "food"
local Pot = require "pot"

local game = Game.new()
game:refillQueue()

local gamestate = require "hump.gamestate"

local menuState = {}
local gameState = {}

function menuState:update()
    -- Allow the user to start the game when a key is pressed
    if love.keyboard.isDown("return") then
        -- Switch to the game state
        gamestate.switch(gameState)
    end
end

function menuState:draw()
    -- Draw the menu with a Start Game option
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("Main Menu", 200, 100)
    love.graphics.print("Press Enter to Start Game", 150, 200)
end

function gameState:enter()
    game = Game.new()
    game:refillQueue()
end

function love.load()
    gamestate.registerEvents()
    gamestate.switch(menuState)
end

function love.keypressed(key)
    if game.gameOver then return end

    if key == "space" then
        game:addFoodFromQueue()
    elseif key == "s" then
        game:swapReserve()
    end
end

function gameState:update(dt)
    game.timeLeft = game.timeLeft - dt
    if game.timeLeft == 0.0 then
      game.gameOver = true
    end
    -- game:update(dt) -- this is way too fast?!
    game.pot:update(dt)
end

-- function love.draw()
function gameState:draw()
    if game.gameOver then
        game.pot = Pot()
        love.graphics.print("Game Over!", 50, 50)
        love.graphics.print("Final Score: " .. game.score, 50, 80)
        return
    end

    love.graphics.print("Time Left: " .. game.timeLeft, 50, 50)
    love.graphics.print("Score: " .. game.score, 50, 80)
    love.graphics.print("Food in Pot: " .. #game.pot.foodItems, 50, 110)
    love.graphics.print("Volatility: " .. game.volatility .. "/" .. game.maxVolatility, 50, 140)

    love.graphics.print("Queue:", 50, 170)
    for i, food in ipairs(game.queue) do
        love.graphics.print(i .. ": " .. Food.getName(food) .. " - " .. "volatility: " .. Food.getVolatility(food), 50, 190 + (i * 20))
    end

    if next(game.reserve) ~= nil then
      love.graphics.print("Reserve: " .. (game.reserve[1] and Food.getName(game.reserve[1]) ..  " - " .. "volatility: " .. Food.getVolatility(game.reserve[1])), 50, 280)
    else
      love.graphics.print("Reserve: " ..  "None", 50, 280)
    end

    local y = 300
    for _, food in ipairs(game.pot.foodItems) do
        love.graphics.print(Food.getName(food.type) .. " - " .. string.format("%.1f", food.timeLeft) .. "s", 50, y)
        y = y + 20
    end
end
