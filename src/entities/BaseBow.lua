local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

local brinevector = require "libs.brinevector"

local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"
local Projectile = require "entities.Projectile"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local BaseBow = middleclass("BaseBow", WorldObject)
function BaseBow:initialize(...)
    WorldObject.initialize(self, ...)
	self:setSpriteOffset(WorldObject.SPRITE_CENTER)
end

function BaseBow:update(dt)
    local mx, my = love.mouse.getPosition();
    local mouseVector = brinevector(mx, my)

    local dir = (self:getCenter() - mouseVector):getAngle()
    self:setRotation(dir + self.spriteDirectionOffset)
end

------------------------------ Core API ------------------------------

------------------------------ Callbacks ------------------------------
BaseBow[EvMousePress] = function(self, e)
	if e.button == 2 then return end
	print("pew")
	local arrow = Projectile("crossbow_base_arrow", self.scene, 100, 100)
end
------------------------------ Getters / Setters ------------------------------

return BaseBow