local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"

local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Projectile = middleclass("Projectile", WorldObject)
function Projectile:initialize(...)
	WorldObject.initialize(self, ...)
	self.depth = 10
end

------------------------------ Core API ------------------------------
function Projectile:update(dt)
	WorldObject.update(self, dt)
	
	local vel = brinevector(1, 1)
	vel.length = self.speed
	vel.angle = self.rotation - self.spriteDirectionOffset
	self.pos = self.pos + vel * dt
	--Out of screen
	local SW, SH = GAME.windowW, GAME.windowH
	if self.pos.x < 0 or self.pos.x + self.w > SW or
			self.pos.y < 0 or self.pos.y + self.h > SH then
		print(self.ID .. " left screen.")
		self.scene:removeObject(self)
		GAME:getScheduler():cancel(self.wiggle)
	end
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Projectile