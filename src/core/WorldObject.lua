local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local AssetRegistry = require "core.AssetRegistry"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local WorldObject = middleclass("WorldObject", Object)
function WorldObject:initialize(id, x, y, w, h)
	Object.initialize(self, id)
	self.pos = brinevector(x, y)
	self.w, self.h = w, h
	print('x', self.w, self.h)
end

------------------------------ Core API ------------------------------
function WorldObject:draw(g2d)
	Object.draw(self, g2d)
	local spr, sx, sy = AssetRegistry:getSprObj(self)
	g2d.setColor(1, 1, 1, 1)
	g2d.draw(spr, self.pos.x, self.pos.y, 0, sx, sy)
	if self.rect then
		g2d.rectangle('line', self.pos.x, self.pos.y, self.w, self.h)
	end
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return WorldObject