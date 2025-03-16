local Class = require("hump.class")

local GameObject = require("gameobject")

Reserve = Class{__includes = {GameObject}}


function Reserve:init(x, y, width, height)
  GameObject.init(self, x, y, width, height)
  self.foodItems = {}
end

return Reserve
