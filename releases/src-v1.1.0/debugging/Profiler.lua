local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local EvSceneObjectAdd = require "events.EvSceneObjectAdd"
local EvSceneObjectRemove = require "events.EvSceneObjectRemove"

local WorldObject = require "core.WorldObject"
local Gopher = require "entities.Gopher"
local ItemDrop = require "entities.ItemDrop"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Profiler = middleclass("Profiler")
function Profiler:initialize()
	Object.initialize(self)
	self.depth = 100
	self.fps, self.tps = 0, 0
	self.objectCount = 0
	self.worldObjectCount, self.itemDropCount, self.gopherCount = 0, 0, 0
	self.cooldown = 60 * 5
end	

------------------------------ Core API ------------------------------
function Profiler:update(dt)
	Object.update(self, dt)
	self.cooldown = self.cooldown > 0 and self.cooldown - 1 or self.cooldown
	if self.cooldown == 0 then
		if love.timer.getFPS() < 55 then
			local str = "Objects: %d\nWorldObjects: %d (ItemDrops=%d,Gophers=%d)"
			print(str:format(self.objectCount, self.worldObjectCount, self.itemDropCount,
					self.gopherCount))
			self.cooldown = -1
		end
	end	
end

function Profiler:draw(g2d)
	Object.draw(self, g2d)
	local LINE_W = 16
	local x, y = 0, GAME.windowH / 2
	y = y - LINE_W
	g2d.print("average fps (1 sec): " .. love.timer.getFPS(), x, y)
	y = y - LINE_W
	local ent = GAME:getCurrentState().bumpWorld:countItems()
	g2d.print("raw-ent-count: " .. ent, x, y)
	y = y - LINE_W * 2
	local str = "Objects: %d\nWorldObjects: %d (ItemDrops=%d,Gophers=%d)"
	g2d.print(str:format(self.objectCount, self.worldObjectCount, self.itemDropCount,
			self.gopherCount), x, y)
end

------------------------------ API ------------------------------

------------------------------ Events ------------------------------
Profiler[EvSceneObjectAdd] = function(self, e)
	self.objectCount = self.objectCount + 1
	if e.object:isInstanceOf(WorldObject) then
		self.worldObjectCount = self.worldObjectCount + 1
	end
	if e.object:isInstanceOf(ItemDrop) then
		self.itemDropCount = self.itemDropCount + 1
	elseif e.object:isInstanceOf(Gopher) then
		self.gopherCount = self.gopherCount + 1
	end 
end

Profiler[EvSceneObjectRemove] = function(self, e)
	self.objectCount = self.objectCount - 1
	if e.object:isInstanceOf(WorldObject) then
		self.worldObjectCount = self.worldObjectCount - 1
	end
	if e.object:isInstanceOf(ItemDrop) then
		self.itemDropCount = self.itemDropCount - 1
	elseif e.object:isInstanceOf(Gopher) then
		self.gopherCount = self.gopherCount - 1
	end
end

------------------------------ Getters / Setters ------------------------------

return Profiler