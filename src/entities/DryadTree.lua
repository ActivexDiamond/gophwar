local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DryadTree = middleclass("DryadTree", WorldObject)
function DryadTree:initialize(...)
	WorldObject.initialize(self, ...)
	self.gameOver = false
end

------------------------------ Core API ------------------------------

------------------------------ Interactions ------------------------------
function DryadTree:takeDamage(damage)
	self.health = self.health - damage
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