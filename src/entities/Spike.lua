local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"
local tween = require "libs.tween"

local PhysicsObject = require "core.PhysicsObject"
local Gopher = require "entities.Gopher"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Spike = middleclass("Spike", PhysicsObject)
function Spike:initialize(...)
	PhysicsObject.initialize(self, ...)
	self:setSpriteOffset(PhysicsObject.SPRITE_CENTER)
	self.hitGophers = setmetatable({}, {__mode = "kv"})
	print("spike init", self.scene)
end

------------------------------ Core API ------------------------------
function Spike:update(dt)
	PhysicsObject.update(self, dt)
	print"xxx"
end

------------------------------ Interactions ------------------------------
function Spike:takeDamage(damage)
	love.audio.play(SFX.gopher_damage)
	self.health = self.health - damage
	self.flash = self.flashBaseDuration
	if self.health <= 0 then
		self:onDeath()
	end
end

------------------------------ Callbacks ------------------------------
function Spike:onCollision(other)
	print "colis"
	if other:isInstanceOf(Gopher) then
		print "hitting gopher"
		self.hitGophers[other] = true
		other:takeDamage(self.damage)
		self.health = self.health - 1
		if self.health <= 0 then
			self:onDeath()
		end
	end
end

function Spike:onDeath()
	self.scene:removeObject(self)
end

------------------------------ Internals ------------------------------
function Spike:_computeDistanceToRoot()
	self.nearestRoot = self.scene:getDryadTree()
	return (self.pos - self.nearestRoot:getCenter()):getLength() 
end

function Spike:_attemptBite()
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


return Spike