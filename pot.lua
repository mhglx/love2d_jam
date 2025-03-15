local Timer = require "hump.timer"
local Food = require "food"

local Pot = {}

function Pot.new()
    local self = {
        foodItems = {},
        volatility = 0,
        timer = Timer.new()
    }

    function self:addFood(foodType, game)
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

    function self:update(dt)
        self.timer:update(dt)
    end

    function self:getFoodCount()
        return #self.foodItems
    end

    function self:getVolatility()
        return self.volatility
    end

    function self:getFoodItems()
        return self.foodItems
    end

    return self
end

return Pot
