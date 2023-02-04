local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"
local tween = require "libs.tween"

local WorldObject = require "core.WorldObject"
local ItemDrop = require "entities.ItemDrop"

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
	self.vel = brinevector(0, 0)
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
			--local offset = math.random(-self.distOffset, self.distOffset)
			self.targetDistance = self.distanceToRoot - self.distOffset
		else
			--Finished eating.
			self.vel = self.originalPosition - self.scene:getDryadTree().pos 
			self.vel.length = self.speed
			--self.pos = self.pos + vel * dt
		end
	end
	
	if self.target then
		self.vel = self.nearestRoot:getCenter() - self.pos 
		self.vel.length = self.speed
		--self.pos = self.pos + vel * dt
		
		--if within offset and tolerance, stop
		local dist = (self.pos - self.target:getCenter()):getLength()
		dist = dist - self.distOffset
		if dist <= self.tolerance then
			self.vel = brinevector(0, 0)
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
--			print(self.ID .. " left screen.")
			self.scene:removeObject(self)
			GAME:getScheduler():cancel(self.wiggle)
		end
	end
	
	if self.pos.x < GAME.windowW / 2 then
		self.flipSpriteX = 1
	else
		self.flipSpriteX = -1
	end
end

------------------------------ Interactions ------------------------------
function Gopher:takeDamage(damage)
	love.audio.play(SFX.gopher_damage)
	self.health = self.health - damage
	self.flash = self.flashBaseDuration
	if self.health <= 0 then
		self:onDeath()
	end
end

------------------------------ Callbacks ------------------------------
function Gopher:onDeath()
	print(self.ID .. " died.")
	love.audio.play(SFX.gopher_death)
	self.scene:removeObject(self)
	GAME:getScheduler():cancel(self.wiggle)	
	
	if math.random() < self.dropChance then
		self.scene:addObject(ItemDrop(self.drop, self.scene, self.pos.x, self.pos.y, 1))
		return 
	end
	if math.random() < 0.8 then
		self.scene:addObject(ItemDrop("wood_stick", self.scene, self.pos.x, self.pos.y, 
				math.random(1, 6)))
	end
end

------------------------------ Internals ------------------------------
function Gopher:_computeDistanceToRoot()
	self.nearestRoot = self.scene:getDryadTree()
	return (self.pos - self.nearestRoot:getCenter()):getLength() 
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
		love.audio.play(SFX.gopher_eat)
		self.bitesTaken = self.bitesTaken + 1
		self.scene:getDryadTree():takeDamage(self.damage)
		self:_attemptBite()
	end, {self})
end

------------------------------ Getters / Setters ------------------------------


return Gopher