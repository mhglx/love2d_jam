local Class = require("hump.class")

local Food = require "food"

Queue = Class{}


function Queue:init(guiElement)
  self.guiElement = guiElement
  self.capacity = 3
  self.foodItems = {}
end

function Queue:fill()
  while #self.foodItems < self.capacity do
      table.insert(self.foodItems, Food.generate())
  end
end

return Queue
