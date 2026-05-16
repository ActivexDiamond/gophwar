local middleclass = require "libs.middleclass"

local DataRegistry = require "core.DataRegistry"
local AssetRegistry = require "core.AssetRegistry"

local Event = require "cat-paw.core.patterns.event.Event"
--local EvMouse = require "cat-paw.core.patterns.event.mouse.EvMouse"
local EvMouseMove = require "cat-paw.core.patterns.event.mouse.EvMouseMove"

local EventSystem = require "cat-paw.core.patterns.event.EventSystem"

local WorldObject = require "core.WorldObject"
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DummyObject = middleclass("DummyObject", WorldObject)
function DummyObject:initialize(...)
	WorldObject.initialize(self, ...)
end

------------------------------ Core API ------------------------------
function DummyObject:update(dt)

	if love.keyboard.isDown("u") then
		print("dummyObject getting update " .. dt)
	end
end

function DummyObject:draw(g2d)
	local spr, sx, sy = AssetRegistry:getSprObj(self)
	g2d.setColor(1, 1, 1, 1)
	g2d.draw(spr, self.x, self.y, 0, sx, sy)
	
	if love.keyboard.isDown("u") then
		print("dummyObject getting draw ")
	end
end

------------------------------ API ------------------------------

------------------------------ Callbacks ------------------------------
DummyObject[EvMouseMove] = function(self, e)
	--Those are too spammy.
	if e.class == EvMouseMove then return end
	--print("Got event: " .. tostring(e))
end

------------------------------ Getters / Setters ------------------------------

return DummyObject