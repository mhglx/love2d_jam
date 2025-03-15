local Class = require("hump.class")
local Draggable = require("draggable")
local GameObject = require("gameobject")

local Food = Class{__includes = {GameObject, Draggable}}

function Food:init(x, y, width, height)
    GameObject.init(self, x, y, width, height)
    Draggable.init(self)
    self.foodType = foodType or "Unknown"
end

-- Drop food
function Food:mousereleased(x, y, button)
    Draggable.mousereleased(self, x, y, button)

    print("dropped food!")
end

function Food:draw()
    GameObject.draw(self)
end

return Food