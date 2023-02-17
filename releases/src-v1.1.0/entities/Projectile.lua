local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"

local PhysicsObject = require "core.PhysicsObject"
local Gopher = require "entities.Gopher"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Projectile = middleclass("Projectile", PhysicsObject)
function Projectile:initialize(...)
	PhysicsObject.initialize(self, ...)
	love.audio.play(SFX.arrow_shoot)
	self.depth = 99
end

------------------------------ Core API ------------------------------
function Projectile:update(dt)
	PhysicsObject.update(self, dt)
	
	self.vel = brinevector(1, 1)
	self.vel.length = self.speed
	self.vel.angle = self.rotation - self.spriteDirectionOffset
	--self.pos = self.pos + self.vel * dt
	--Out of screen
	local SW, SH = GAME.windowW, GAME.windowH
	if self.pos.x < 0 or self.pos.x + self.w > SW or
			self.pos.y < 0 or self.pos.y + self.h > SH then
		self.scene:removeObject(self)
	end
end

------------------------------ API ------------------------------
function Projectile:onCollision(other)
	if other:isInstanceOf(Gopher) then
		other:takeDamage(self.damage)
		self.scene:removeObject(self)
	end
end

------------------------------ Getters / Setters ------------------------------

return Projectile