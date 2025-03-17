local Class = require("hump.class")

Reserve = Class{}


function Reserve:init(guiElement)
  self.guiElement = guiElement
  self.foodItems = {}
end

return Reserve
