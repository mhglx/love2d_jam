local Class = require("hump.class")
local GameObject = require("gameobject")

local Draggable = Class{}

-- Constructor
function Draggable:init(x, y, width, height)
    -- GameObject:init(self, x, y, width, height)
    -- self.x = x or 100
    -- self.y = y or 100
    -- self.width = width or 100
    -- self.height = height or 50
    self.dragging = false
    self.offsetX = 0
    self.offsetY = 0
end

function Draggable:mousepressed(x, y, button)
    if button == 1 then  -- LMB
        if x > self.x and x < self.x + self.width and
           y > self.y and y < self.y + self.height then
            self.dragging = true
            self.offsetX = x - self.x
            self.offsetY = y - self.y
        end
    end
end

function Draggable:mousemoved(x, y)
    if self.dragging then
        self.x = x - self.offsetX
        self.y = y - self.offsetY
    end
end

function Draggable:mousereleased(x, y, button)
    if button == 1 then -- LMB
        self.dragging = false
    end
end

-- function Draggable:draw()
--     love.graphics.setColor(0, 1, 0)  -- green
--     love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
-- end

return Draggable
