local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local AssetRegistry = require "core.AssetRegistry"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local WorldObject = middleclass("WorldObject", Object)
function WorldObject:initialize(id, scene, x, y)
	Object.initialize(self, id)
	self.scene = scene
	self.pos = brinevector(x, y)
	
	self.vel = brinevector(0, 0)
	self.currentFrame = 0
	self.rotation = 0
	self.spriteOffset = {x = 0, y = 0}
	self.flash = 0	
	
	self.flipSpriteX = 1
	self.flipSpriteY = 1
end

------------------------------ Constants ------------------------------
WorldObject.SPRITE_CENTER = {0.5, 0.5}
WorldObject.SPRITE_BOTTOM_CENTER = {0.5, 1}

------------------------------ Core API ------------------------------
function WorldObject:draw(g2d)
	Object.draw(self, g2d)
	local spr, sx, sy
	if self.useInvSpr then
		spr, sx, sy = AssetRegistry:getSprInv(self)
	else
		spr, sx, sy = AssetRegistry:getSprObj(self)
	end
	local frame;
	if spr[0] and spr[0].typeOf and spr[0]:typeOf("Drawable") then
		frame = spr[self.currentFrame]
	else
		frame = spr
	end

	sx = sx * self.flipSpriteX
	sy = sy * self.flipSpriteY
	local x = self.pos.x + self.w * self.spriteOffset.x
	local y = self.pos.y + self.h * self.spriteOffset.y
	local ox = frame:getWidth() * self.spriteOffset.x 
	local oy = frame:getHeight() * self.spriteOffset.y
	
	
	if self.flash > 0 then
		g2d.setColor(1, 0, 0, 1)
		self.flash = self.flash - 1
	else
		g2d.setColor(1, 1, 1, 1)
	end
	g2d.draw(frame, x, y, self.rotation, sx, sy, ox, oy)
	if DEBUG.DRAW_BOUNDING_BOXES then
		g2d.rectangle('line', self:getBoundingBox())
		g2d.setPointSize(4)
		local center = self:getCenter()
		g2d.points(x, y)
	end
	g2d.setColor(1, 1, 1, 1)
end

------------------------------ API ------------------------------

------------------------------ Phyiscs ------------------------------

------------------------------ Getters / Setters ------------------------------
function WorldObject:getPosition() return self.pos end
function WorldObject:getRotation() return self.rotation end
--function WorldObject:getSpriteOffset() return self.spriteOffset end

function WorldObject:getCenter()
	return brinevector(self.pos.x + self.w / 2, 
			self.pos.y + self.h / 2)
end
function WorldObject:getBoundingBox()
	local x = self.pos.x
	local y = self.pos.y
	local w = self.w
	local h = self.h
	return x, y, w, h
end

function WorldObject:setPosition(x, y)
	self.pos.x = x
	self.pos.y = y
end

function WorldObject:setRotation(r)
	self.rotation = r
end

--Either x/y (factors to be multiplied by the sprite's pre-scaling size) or a SPRITE_ constant.
function WorldObject:setSpriteOffset(a, b)
	if type(a) == 'table' then
		self.spriteOffset.x = a[1]
		self.spriteOffset.y = a[2]
	else
		self.spriteOffset.x = a
		self.spriteOffset.y = b
	end
end

return WorldObject