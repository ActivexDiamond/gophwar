local middleclass = require "libs.middleclass"
local Object = require "core.Object"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local RootController = middleclass("RootController", Object)
function RootController:initialize(scene)
	Object.initialize(self, "root_controller")
	self.scene = scene
end

------------------------------ Core API ------------------------------
function RootController:update(dt)
	Object.update(self, dt)
	--called every frame
end

function RootController:draw(g2d)
	Object.draw(self, g2d)
	--same but for drawing commands. g2d is just love.graphics
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return RootController