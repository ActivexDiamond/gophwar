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
	
	local tree = self.scene:getDryadTree():getCenter()
	local x, y = tree.x, tree.y
	for i = 1, 3 do
--		self:_addRoot(x + (32*3 * i), y, math.pi / 2)
	end
	
	--self:_addRootCircle(256, math.pi/8)
	--self:_addRootCircle(220, math.pi/28)
end

------------------------------ Core API ------------------------------
function RootController:update(dt)
	Object.update(self, dt)
end

function RootController:draw(g2d)
	Object.draw(self, g2d)
end

------------------------------ Internals ------------------------------
function RootController:_addRootCircle(dist, angleDiff)
	local tree = self.scene:getDryadTree():getCenter()
	for a = 0, math.pi * 2, angleDiff do
		for i = 1, 3 do 
			local pos = brinevector(1, 1)
			pos.angle = a
			pos.length = 32*3 * i
			local rootPos = brinevector(tree.x + pos.x, tree.y + pos.y)
			local dir = (tree - rootPos):getAngle()
			
			self:_addRoot(rootPos.x, rootPos.y, dir + math.pi/2)
--			self:_addRoot(tree.x + pos.x, tree.y + pos.y, rot - math.pi/4)
		end
	end	
end

function RootController:_addRoot(x, y, rot)
	local root = Root(self.scene, x, y)
	root:setSpriteOffset(WorldObject.SPRITE_CENTER)
	root:setRotation(rot)
	self.scene:addObject(root)
	root.depth = -10
end

------------------------------ Getters / Setters ------------------------------

return RootController