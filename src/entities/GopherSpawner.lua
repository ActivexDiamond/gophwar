local middleclass = require "libs.middleclass"
local Object = require "core.Object"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local GopherSpawner = middleclass("RootController", Object)
function GopherSpawner:initialize(scene)
	Object.initialize(self, "gopher_spawner")
	self.scene = scene

	GAME:getScheduler():callEvery(0.9, function(dt, percentage, self)
		if math.random() < 0.4 then return end
		local pos = brinevector(1, 1)
		pos.angle = math.random(0, 360)
		pos.length = math.random(500, 1000)
		local x = pos.x + GAME.windowW * 0.5
		local y = pos.y + GAME.windowH * 0.5
		self:addObject(Gopher("gopher_base", self, x, y))
	end, {self})
end

------------------------------ Core API ------------------------------
function GopherSpawner:update(dt)
	Object.update(self, dt)
	--called every frame
end

function GopherSpawner:draw(g2d)
	Object.draw(self, g2d)
	--same but for drawing commands. g2d is just love.graphics
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GopherSpawner