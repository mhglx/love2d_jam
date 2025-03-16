local Class = require("hump.class")

local GameObject = require("gameobject")
local Food = require "food"

Queue = Class{__includes = {GameObject}}


function Queue:init(x, y, width, height)
  GameObject.init(self, x, y, width, height)
  self.capacity = 3
  self.foodItems = {}
end

function Queue:fill()
  while #self.foodItems < self.capacity do
      table.insert(self.foodItems, Food.generate())
  end
end

return Queue
