local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("Gopher", WorldObject)
function Gopher:initialize(...)
	WorldObject.initialize(self, ...)
	self.bitesTaken = 0
 	self.target = nil
 	self.targetDistance = 0
 	self.eating = false
 	self.distanceToRoot = self:_computeDistanceToRoot()
end

------------------------------ Core API ------------------------------
function Gopher:update(dt)
	WorldObject.update(self, dt)
	local distanceToRoot = self:_computeDistanceToRoot()
	--Root has died, new nearest emerges.
	if 	self.distanceToRoot ~= distanceToRoot then
		self.eating = false
	end
	if not self.eating then
		if self.bitesTaken == 0 then
			self.distanceToRoot = self:_computeDistanceToRoot()
			self.target = self.nearestRoot
			local offset = math.random(self.minOffset, self.maxOffset)
			self.targetDistance = self.distanceToRoot + offset
		else
			--target outside of map
		end
	end
	
	if self.target then
		--move in dir
		--if within offset and tolerance, stop
		self.eating = true
	end
	
	if self.bitesTaken > 0 then
		self.currentFrame = 1
	end
end
------------------------------ Internals ------------------------------
function Gopher:_computeDistanceToRoot()
	print(self.scene, self.scene:getDryadTree())
	self.nearestRoot = self.scene.dryadTree
	return (self.pos - self.nearestRoot.pos):getLength() 
end

------------------------------ Getters / Setters ------------------------------


return Gopher