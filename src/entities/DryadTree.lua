local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

local shack = require "libs.shack"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DryadTree = middleclass("DryadTree", WorldObject)
function DryadTree:initialize(...)
	WorldObject.initialize(self, ...)
	self.gameOver = false
	self.shake = 0
end

------------------------------ Core API ------------------------------
function DryadTree:draw(g2d)
	WorldObject.draw(self, g2d)
	if self.shake > 0 then
		shack:setShake(20)
		self.shake = self.shake - 1
	else
		shack:setShake(0)
	end
end

------------------------------ Interactions ------------------------------
function DryadTree:takeDamage(damage)
	self.health = self.health - damage
	--self.flash = self.flashBaseDuration
	self.shake = self.shakeBaseDuration
	if self.health <= 0 then
		self:onDeath()
	end
end

------------------------------ Callbacks ------------------------------
function DryadTree:onDeath()
	print("===== Game Over! =====")
	GAME:goTo(GAME.GAME_OVER_SCENE_ID)
	error "implement game over screen pls"
end
------------------------------ Getters / Setters ------------------------------

return DryadTree