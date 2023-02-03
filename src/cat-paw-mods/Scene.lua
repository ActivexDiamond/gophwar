local middleclass = require "libs.middleclass"
local State = require "cat-paw.core.patterns.state.State"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Scene = middleclass("Scene", State)
function Scene:initialize()
	State.initialize(self)
	self.objects = {}
end

------------------------------ Core API ------------------------------
function State:update(dt)
	for obj, _ in pairs(self.objects) do
		obj:update(dt)
	end
end

function State:draw(g2d)
	for obj, _ in pairs(self.objects) do
		obj:draw(g2d)
	end
end

function State:enter(from, ...)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneEnter then obj:onSceneEnter(from, ...) end
	end
end

function State:leave(to)
	for obj, _ in pairs(self.objects) do
		if obj.onSceneLeave then obj:onSceneLeave(to) end
	end
end

function State:activate(fsm)
	self.fsm = fsm
		for obj, _ in pairs(self.objects) do
		if obj.onSceneActivate then obj:onSceneActivate(fsm) end
	end
end

function State:destroy()
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
	return true
end

--- Returns true if remove successfull, false otherwise.
--- Will fail if object does not exist.
function Scene:removeObject(obj)
	if not self.object[obj] then return false end
	
	self.objects[obj] = nil
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