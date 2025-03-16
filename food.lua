local Class = require("hump.class")
local Draggable = require("draggable")
local GameObject = require("gameobject")

local Food = Class{__includes = {GameObject, Draggable}}

Food.types = {
    meat = { name = "Meat", cookTime = 7, score = 50, volatility = 4 },
    veg = { name = "Vegetables", cookTime = 5, score = 30, volatility = 2 },
    rice_ball = { name = "Rice Ball", cookTime = 4, score = 20, volatility = 3 },
    peppah = { name = "Peppah", cookTime = 5, score = 100, volatility = 7 }
}

function Food:init(x, y, width, height)
    GameObject.init(self, x, y, width, height)
    Draggable.init(self)
end

-- Drop food
function Food:mousereleased(x, y, button)
    Draggable.mousereleased(self, x, y, button)

    print("dropped food!")
end

function Food:draw()
    GameObject.draw(self)
end

function Food.generate()
    local foodList = {}
    for key in pairs(Food.types) do
        table.insert(foodList, key)
    end
    return foodList[math.random(#foodList)]
end

function Food.getName(foodType)
    return Food.types[foodType].name
end

function Food.getVolatility(foodType)
    return Food.types[foodType].volatility
end

return Food
