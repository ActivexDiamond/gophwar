local middleclass = require "libs.middleclass"
local Object = require "core.Object"
local brinevector = require "libs.brinevector"
local Gopher = require "entities.Gopher"

------------------------------ Helpers ------------------------------
local function spawn(dt, percentage, self, chance)
	if math.random() < self.stage.chance then return end
	local pos = brinevector(1, 1)
	pos.angle = math.random(0, self.maxAngle)
	pos.length = math.random(500, 1000)
	local x = pos.x + GAME.windowW * 0.5
	local y = pos.y + GAME.windowH * 0.5
	self.scene:addObject(Gopher("gopher_base", self.scene, x, y))
	self.spawns = self.spawns + 1
end

------------------------------ Constructor ------------------------------
local GopherSpawner = middleclass("GopherSpawner", Object)
function GopherSpawner:initialize(scene)
	Object.initialize(self, "gopher_spawner")
	self.scene = scene
	self.stageIndex = 1
	self.stage = self.stageStats[1]
	self.spawns = 0
	GAME:getScheduler():callEvery(self.stage.cooldown, spawn, {self})
end

------------------------------ Core API ------------------------------
function GopherSpawner:update(dt)
	Object.update(self, dt)
	--Check stage
	local previousStageIndex = self.stageIndex
	for stageIndex, spawns in ipairs(self.stageMarkers) do
		if self.spawns > spawns then
			self.stageIndex = stageIndex
		end
	end
	if self.stageIndex ~= previousStageIndex then
		self.stage = self.stageStats[self.stageIndex]
		GAME:getScheduler():cancel(spawn)
		GAME:getScheduler():callEvery(self.stage.cooldown, spawn, {self})
	end
end

function GopherSpawner:draw(g2d)
	Object.draw(self, g2d)
	
	local line, sep = 0, 20
	g2d.print("Spawns: " .. self.spawns, 0, line * sep)
	
	local line = line + 1
	local str = "Difficulty: %d/%d"
	g2d.print(str:format(self.stageIndex, #self.stageMarkers), 0, line * sep)
	
	local line = line + 1
	local str = "Health: %d"
	g2d.print(str:format(self.scene:getDryadTree().health), 0, line * sep)	
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GopherSpawner