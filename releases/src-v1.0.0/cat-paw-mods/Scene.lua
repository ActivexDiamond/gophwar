local middleclass = require "libs.middleclass"
local State = require "cat-paw.core.patterns.state.State"
local util = require "libs.utils"
local bump = require "libs.bump"

local WorldObject = require "core.WorldObject"

local Event = require "cat-paw.core.patterns.event.Event"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Scene = middleclass("Scene", State)
function Scene:initialize()
	State.initialize(self)
	--GAME:getEventSystem():attach(self, {Event})
	self.objects = {}
	self.bumpWorld = bump.newWorld(32)
end

------------------------------ Core API ------------------------------
function Scene:update(dt)
	State.update(self, dt)
	for obj, _ in pairs(self.objects) do
		obj:update(dt)
	end
	
	for obj, _ in pairs(self.objects) do
		if not obj:isInstanceOf(WorldObject) then goto continue end
		local targetPos = obj.pos + obj.vel * dt
		local x, y, cols, len = self.bumpWorld:move(obj, targetPos.x, targetPos.y, 
				obj.collisionFilter or function() return 'cross' end)
		obj:setPosition(x, y)
		if len > 0 then
			for k, col in ipairs(cols) do
				if obj.onCollision then obj:onCollision(col.other) end
				if col.other.onCollision then col.other:onCollision(obj) end
			end
		end
		::continue::
	end
end

function Scene:draw(g2d)
	State.draw(self, g2d)
	for obj, _ in util.sortedObjects(self.objects) do
		obj:draw(g2d)
	end
end

function Scene:enter(from, ...)
	State.enter(self, from, ...)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneEnter then obj:onSceneEnter(from, ...) end
	end
end

function Scene:leave(to)
	State.leave(self, to)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneLeave then obj:onSceneLeave(to) end
	end
end

function Scene:activate(fsm)
	State.activate(self, fsm)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneActivate then obj:onSceneActivate(fsm) end
	end
end

function Scene:destroy()
	State.destroy(self)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneDestroy then obj:onSceneDestroy() end
	end
end

------------------------------ API ------------------------------
--- Returns true if add successfull, false otherwise.
--- Will fail if object already exists.
function Scene:addObject(obj)
	--The keys of the table are used for storage so that object lookup can make use of
	--Lua's internal hashing. This is far faster than looping and also far quicker to implement
	--then some proper search/spatial-storage/hashing algorithm.
	--This also gives us "out of the box" protection against objects being added twice.
	if self.objects[obj] then return false end

	self.objects[obj] = true
	if obj:isInstanceOf(WorldObject) then 
		self.bumpWorld:add(obj, obj.pos.x, obj.pos.y, obj.w, obj.h)
	end
	return true
end

--- Returns true if remove successfull, false otherwise.
--- Will fail if object does not exist.
function Scene:removeObject(obj)
	if not self.objects[obj] then return false end

	self.objects[obj] = nil
	if obj:isInstanceOf(WorldObject) then
		self.bumpWorld:remove(obj)
	end
	return true
end

------------------------------ Getters / Setters ------------------------------
-- Returns a direct reference to its internal buffer. Changes will be reflected!
function Scene:getObjects() return self.objects end

-- `protection` Just in case someone confuses this with `removeObject`.
-- Note calling this will also invalidate any reference to the buffer previously
-- gotten through `getObjects()`
function Scene:clearObjects(protection)
	if protection then
		error("You seem to have passed something. Did you mean to call `Scene:removeObject(obj`)?"
				.. "\nCareful, this clears the entire object buffer!")
	end

	self.objects = {}
end

return Scene