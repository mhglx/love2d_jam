local Timer = require "hump.timer"

local game = {}
game.timeLeft = 42 -- Countdown timer in seconds
game.score = 0

game.volatility = 0
game.maxVolatility = 10

game.timer = Timer.new()
game.timer:every(1, function()
    if game.timeLeft > 0 then
        game.timeLeft = game.timeLeft - 1
    end
end)

local pot = {}
pot.foodItems = {}

local foodTypes = {
    meat = { cookTime = 7, score = 50, volatility = 4 },
    veg = { cookTime = 5, score = 30, volatility = 2 },
    rice_ball = { cookTime = 4, score = 20, volatility = 3 },
    pepper = { cookTime = 5, score = 100, volatility = 7 }
}

local function addFoodToPot(foodType)
    if game.gameOver then return end

    if foodTypes[foodType] then
        local food = { type = foodType, timeLeft = foodTypes[foodType].cookTime, volatility = foodTypes[foodType].volatility }
        table.insert(pot.foodItems, food)

        game.volatility = game.volatility + food.volatility

        if game.volatility > game.maxVolatility then
            game.gameOver = true
        end

        game.timer:during(food.timeLeft, function(dt)
            food.timeLeft = food.timeLeft - dt
        end, function()
            for i, f in ipairs(pot.foodItems) do
                if f == food then
                    game.score = game.score + foodTypes[f.type].score
                    game.volatility = game.volatility - f.volatility
                    table.remove(pot.foodItems, i)
                    break
                end
            end
        end)
    end
end

function love.keypressed(key)
    if key == "1" then
        addFoodToPot("meat")
    elseif key == "2" then
        addFoodToPot("veg")
    elseif key == "3" then
        addFoodToPot("rice_ball")
    elseif key == "4" then
        addFoodToPot("pepper")
    end
end

function love.update(dt)
    game.timer:update(dt)
end

function love.draw()
    if game.gameOver then
        love.graphics.print("Game Over!", 50, 50)
        love.graphics.print("Final Score: " .. game.score, 50, 80)
        return
    end

    love.graphics.print("Time Left: " .. game.timeLeft, 50, 50)
    love.graphics.print("Score: " .. game.score, 50, 80)
    love.graphics.print("Food in Pot: " .. #pot.foodItems, 50, 110)
    love.graphics.print("Volatility: " .. game.volatility .. "/" .. game.maxVolatility, 50, 140)

    local y = 170
    for _, food_item in ipairs(pot.foodItems) do
        love.graphics.print(food_item.type .. " - " .. string.format("%.1f", food_item.timeLeft) .. "s", 50, y)
        y = y + 20
    end
end
