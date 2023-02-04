local middleclass = require "libs.middleclass"
local Object = require "core.Object"
local Root = require "entities.Root"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------
------------------------------ Constructor ------------------------------
local RootController = middleclass("RootController", Object)
function RootController:initialize(scene)
	Object.initialize(self, "root_controller")
	self.scene = scene
	
	self:_addRoot(100, 100)
end

------------------------------ Core API ------------------------------
function RootController:update(dt)
	Object.update(self, dt)
end

function RootController:draw(g2d)
	Object.draw(self, g2d)
end

------------------------------ Internals ------------------------------
function RootController:_addRoot(x, y, rot)
	local root = Root(self.scene, x, y)
	root:setSpriteOffset(WorldObject.SPRITE_CENTER)
	root:setRotation(rot)
	self.scene:addObject(root)
end

------------------------------ Getters / Setters ------------------------------

return RootController