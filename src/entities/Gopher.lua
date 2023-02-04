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
 	self.originalPosition = self.pos:getCopy()
end

------------------------------ Core API ------------------------------
function Gopher:update(dt)
	WorldObject.update(self, dt)
	local distanceToRoot = self:_computeDistanceToRoot()
	--Root has died.
	if 	self.eating and self.distanceToRoot ~= distanceToRoot then
		self.eating = false
		self.target = nil
	end
	
	if not self.eating then
		--Haven't started yet.
		if self.bitesTaken == 0 then
			self.distanceToRoot = self:_computeDistanceToRoot()
			self.target = self.nearestRoot
			local offset = math.random(-self.distOffset, self.distOffset)
			self.targetDistance = self.distanceToRoot + offset
		else
			--Finished eating.
			local vel = self.originalPosition - self.scene:getDryadTree().pos 
			vel.length = self.speed
			self.pos = self.pos + vel * dt
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
	
	--Out of screen
	local SW, SH = GAME.windowW, GAME.windowH
	if self.pos.x < 0 or self.pos.x + self.w > SW or
			self.pos.y < 0 or self.pos.y + self.h > SH then
		print(self.ID .. " left screen.")
		self.scene:removeObject(self)
	end
end

------------------------------ Internals ------------------------------
function Gopher:_computeDistanceToRoot()
	self.nearestRoot = self.scene.dryadTree
	return (self.pos - self.nearestRoot.pos):getLength() 
end

function Gopher:_attemptBite()
	print(self.bitesTaken, #self.biteChances)
	if not self.biteChances[self.bitesTaken + 1] then 
		self.eating = false
		return false
	end
	
	local prob = math.random()
	if prob > self.biteChances[self.bitesTaken + 1] then
		self.eating = false
		return false
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