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
	print(self.scene)
	local pos = self:getCenter()
	local arrow = Projectile("crossbow_base_arrow", self.scene, pos.x - 5, pos.y - 5)
	arrow:setSpriteOffset(WorldObject.SPRITE_CENTER)
	arrow:setRotation(self.rotation + math.pi)
	
	self.scene:addObject(arrow)
	
end
------------------------------ Getters / Setters ------------------------------

return BaseBow