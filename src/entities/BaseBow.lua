local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("BaseBow", WorldObject)
function Gopher:initialize(...)
    WorldObject.initialize(self, ...)

end

function Gopher:update(dt)
    local mx, my = love.mouse.getPosition();
    local mouseVector = brinevector(mx, my)

    local selfVector = brinevector(self.pos.x, self.pos.y)

    local test = selfVector - mouseVector;
    print("mv " .. test)
    self:setSpriteOrigin(self.w / 4, self.h / 4)
    self:setRotation(test:getAngle())
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Gopher