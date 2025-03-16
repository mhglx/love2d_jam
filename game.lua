local Timer = require "hump.timer"

local Pot = require "pot"
local Food = require "food"

local Game = {}

function Game.new()
    local self = {
        timeLeft = 42,
        score = 0,
        volatility = 0,
        maxVolatility = 10,
        timer = Timer.new(),
        pot = Pot(),
        queueCapacity = 3,
        queue = {},
        reserve = {}
    }

    function self:update(dt)
        self.timer:update(dt)
        if self.timeLeft > 0 then
            self.timeLeft = self.timeLeft - 1
        end
    end

    function self:refillQueue()
        while #self.queue < self.queueCapacity do
            table.insert(self.queue, Food.generate())
        end
    end

    function self:swapReserve()
        if self.gameOver or #self.queue == 0 then return end
        if next(self.reserve) ~= nil then
          self.reserve[1], self.queue[1] = self.queue[1], self.reserve[1]
        else
          _ = table.remove(self.queue, 1)
          self.reserve[1] = self.queue[1]
          self:refillQueue()
        end
    end

    function self:addFoodFromQueue()
        if self.gameOver then return end
        local foodType = table.remove(self.queue, 1)
        self.pot:addFood(foodType, self)
        self.volatility = self.pot:getVolatility()
        self:refillQueue()
    end

    return self
end

return Game
