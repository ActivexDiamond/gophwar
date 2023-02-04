local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Projectile = middleclass("Projectile", WorldObject)
function Projectile:initialize(...)
	WorldObject.initialize(self, ...)
	self.depth = 100
end

------------------------------ Core API ------------------------------
function Projectile:update(dt)
	WorldObject.update(self, dt)
	
	local complete = self.wiggleTween:update(dt)
	if complete then
		self.wiggleDirection = self.wiggleDirection * -1
		self.wiggleTween = tween.new(self.wiggleDuration, self, 
				{rotation = self.wiggleDirection * self.wiggleRange})
	end
	
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