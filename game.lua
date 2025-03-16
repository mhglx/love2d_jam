local Timer = require "hump.timer"

local Pot = require "pot"
local Queue = require "queue"
local Reserve = require "reserve"

local Game = {}

function Game.new()
    local self = {
        timeLeft = 42,
        score = 0,
        volatility = 0,
        maxVolatility = 10,
        timer = Timer.new(),
        pot = Pot(0, 0, 0, 0),
        queue = Queue(0, 0, 0, 0),
        reserve = Reserve(0, 0, 0, 0)
    }

    function self:update(dt)
        self.timer:update(dt)
        if self.timeLeft > 0 then
            self.timeLeft = self.timeLeft - 1
        end
    end

    function self:swapReserve()
        if self.gameOver then return end
        if #self.reserve.foodItems == 1 then
          self.reserve.foodItems[1], self.queue.foodItems[1] = self.queue.foodItems[1], self.reserve.foodItems[1]
        else
          _ = table.remove(self.queue.foodItems, 1)
          self.reserve.foodItems[1] = self.queue.foodItems[1]
          self.queue:fill()
        end
    end

    function self:addFoodFromQueue()
        if self.gameOver then return end
        local foodType = table.remove(self.queue.foodItems, 1)
        self.pot:addFood(foodType, self)
        self.volatility = self.pot.volatility
        self.queue:fill()
    end

    return self
end

return Game
