local Class = require("hump.class")
local Timer = require "hump.timer"

local GameObject = require("gameobject")
local Food = require "food"

Pot = Class{__includes = {GameObject}}


function Pot:init(x, y, width, height)
  GameObject.init(self, x, y, width, height)
  self.foodItems = {}
  self.volatility = 0
  self.timer = Timer.new()
end

function Pot:addFood(foodType, game)
    if Food.types[foodType] then
        local food = {
            type = foodType,
            timeLeft = Food.types[foodType].cookTime,
            volatility = Food.types[foodType].volatility
        }
        table.insert(self.foodItems, food)

        self.volatility = self.volatility + food.volatility

        -- TODO: dependency inversion
        if self.volatility > game.maxVolatility then
            game.gameOver = true
        end

        self.timer:during(food.timeLeft, function(dt)
            food.timeLeft = food.timeLeft - dt
        end, function()
            for i, f in ipairs(self.foodItems) do
                if f == food then
                    game.score = game.score + Food.types[f.type].score
                    self.volatility = self.volatility - f.volatility
                    table.remove(self.foodItems, i)
                    break
                end
            end
        end)
    end
end

function Pot:update(dt)
    self.timer:update(dt)
end

return Pot
