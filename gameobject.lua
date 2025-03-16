-- Basically represents an in-game object with certain attributes
-- in the 2d game world such as
-- position
-- shape (TODO:)
-- image (texture) (TODO:)
-- ...
-- that you can run simple collision checks on.

local Class = require("hump.class")

local GameObject = Class{}

function GameObject:init(x, y, width, height)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 50
    self.height = height or 50
end

function GameObject:draw()
    love.graphics.setColor(0, 1, 0)  -- green
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- simple aabb collision check
function GameObject:checkCollision(other)
    if not other then
        error("GameObject:checkCollision() - 'other' is nil!")
    end

    return self.x < other.x + other.width and
        self .x + self.width > other.x and
        self.y < other.y + other.height and
        self.y + self.height > other.y
end

return GameObject







