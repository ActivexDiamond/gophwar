local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local AssetRegistry = require "core.AssetRegistry"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local WorldObject = middleclass("WorldObject", Object)
function WorldObject:initialize(id, scene, x, y, w, h)
	Object.initialize(self, id)
	self.scene = scene
	self.pos = brinevector(x, y)
	self.w, self.h = w, h
	self.currentFrame = 0
	self.rotation = 0
	self.spriteOrigin = brinevector(0, 0)	
end

------------------------------ Core API ------------------------------
function WorldObject:draw(g2d)
	Object.draw(self, g2d)
	local spr, sx, sy = AssetRegistry:getSprObj(self)
	local frame;
	if type(spr[1]) == 'table' then
		frame = frame[self.currentFrame]
	else
		frame = spr
	end

	g2d.setColor(1, 1, 1, 1)
	g2d.draw(frame, self.pos.x, self.pos.y, self.rotation, sx, sy,
			self.spriteOrigin.x, self.spriteOrigin.y)
	if self.rect then
		g2d.rectangle('line', self.pos.x, self.pos.y, self.w, self.h)
	end
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------
function WorldObject:getPosition() return self.pos end
function WorldObject:getRotation() return self.rotation end
function WorldObject:getSpriteOrigin() return self.spriteOrigin end

function WorldObject:setPosition(x, y)
	self.pos.x = x
	self.pos.y = y
end

function WorldObject:setRotation(r)
	self.rotation = r
end

function WorldObject:setSpriteOrigin(x, y)
	self.spriteOrigin.x = x
	self.spriteOrigin.y = y
end

return WorldObject