local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"
local tween = require "libs.tween"

local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("Gopher", WorldObject)
function Gopher:initialize(...)
	WorldObject.initialize(self, ...)
	self:setSpriteOffset(WorldObject.SPRITE_CENTER)
	self.bitesTaken = 0
 	self.target = nil
 	self.targetDistance = 0
 	self.eating = false
 	self.distanceToRoot = self:_computeDistanceToRoot()
 	self.originalPosition = self.pos:getCopy()
	
	self.wiggleCounter = 0
	
--	self.wiggleTweens = {
--		tween.new(2, self, {rotation = math.pi*0.5}),
--		tween.new(2, self, {rotation = -math.pi*0.5}),
--	}
--	self.activeWiggle = 0
	self.wiggleTween = tween.new(self.wiggleDuration, self, {rotation = self.wiggleRange})
	self.wiggleDirection = 1
end

------------------------------ Core API ------------------------------
function Gopher:update(dt)
	WorldObject.update(self, dt)
	
	local complete = self.wiggleTween:update(dt)
	if complete then
		self.wiggleDirection = self.wiggleDirection * -1
		self.wiggleTween = tween.new(self.wiggleDuration, self, 
				{rotation = self.wiggleDirection * self.wiggleRange})
	end
	
	local distanceToRoot = self:_computeDistanceToRoot()
	--Root has died.
	if self.eating and self.distanceToRoot ~= distanceToRoot then
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
	if not self.eating and not self.target then
		local SW, SH = GAME.windowW, GAME.windowH
		if self.pos.x < 0 or self.pos.x + self.w > SW or
				self.pos.y < 0 or self.pos.y + self.h > SH then
			print(self.ID .. " left screen.")
			self.scene:removeObject(self)
			GAME:getScheduler():cancel(self.wiggle)
		end
	end
end

------------------------------ Internals ------------------------------
function Gopher:_computeDistanceToRoot()
	self.nearestRoot = self.scene.dryadTree
	return (self.pos - self.nearestRoot.pos):getLength() 
end

function Gopher:_attemptBite()
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
		self.bitesTaken = self.bitesTaken + 1
		self:_attemptBite()
	end, {self})
end

------------------------------ Getters / Setters ------------------------------


return Gopher