local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"
local brinevector = require "libs.brinevector"

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
	if 	self.eating and self.distanceToRoot ~= distanceToRoot then
		self.eating = false
	end
	
	if not self.eating then
		if self.bitesTaken == 0 then
			self.distanceToRoot = self:_computeDistanceToRoot()
			self.target = self.nearestRoot
			local offset = math.random(-self.distOffset, self.distOffset)
			self.targetDistance = self.distanceToRoot + offset
		else
			--target outside of map
		end
	end
	
	if self.target then
		local vel = self.nearestRoot.pos - self.pos 
		vel.length = self.speed
		self.pos = self.pos + vel * dt
		--if within offset and tolerance, stop
		local dist = (self.pos - self.target.pos):getLength()
		if dist <= self.tolerance then
			self.eating = true
			self.distanceToRoot = self:_computeDistanceToRoot()
			self.target = nil
			self:_attemptBite()
		end
	end
	
	if self.bitesTaken > 0 then
		self.currentFrame = 1
	end
end
------------------------------ Internals ------------------------------
function Gopher:_computeDistanceToRoot()
	self.nearestRoot = self.scene.dryadTree
	return (self.pos - self.nearestRoot.pos):getLength() 
end

function Gopher:_attemptBite()
	print(self.bitesTaken, #self.biteChances)
	if not self.biteChances[self.bitesTaken + 1] then return end
	
	local prob = math.random()
	if prob > self.biteChances[self.bitesTaken + 1] then
		return
	end
	
	local offset = math.random(-self.biteCooldownOffset, self.biteCooldownOffset)
	local cooldown = self.biteCooldown + offset
	GAME:getScheduler():callAfter(cooldown, function(dt, percentage, self)
		print "x"
		self.bitesTaken = self.bitesTaken + 1
		self:_attemptBite()
	end, {self})
end

------------------------------ Getters / Setters ------------------------------


return Gopher