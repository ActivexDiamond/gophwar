local middleclass = require "libs.middleclass"
local Object = require "core.Object"
local Root = require "entities.Root"
local WorldObject = require "core.WorldObject"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------
------------------------------ Constructor ------------------------------
local RootController = middleclass("RootController", Object)
function RootController:initialize(scene)
	Object.initialize(self, "root_controller")
	self.scene = scene
	
	local dist = 128 * 2
	local tree = self.scene:getDryadTree():getCenter()
	for a = 0, math.pi * 2, math.pi  /32 do
		local pos = brinevector(1, 1)
		pos.angle = a
		pos.length = dist
		
		self:_addRoot(tree.x + pos.x, tree.y + pos.y, pos.angle)
	end
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