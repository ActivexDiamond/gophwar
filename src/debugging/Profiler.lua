local jitp = require "jit.p"

local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local EvSceneObjectAdd = require "events.EvSceneObjectAdd"
local EvSceneObjectRemove = require "events.EvSceneObjectRemove"
local EvGameQuit = require "cat-paw.core.patterns.event.os.EvGameQuit"
local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"

local WorldObject = require "core.WorldObject"
local Gopher = require "entities.Gopher"
local ItemDrop = require "entities.ItemDrop"

------------------------------ Locals (For Performance) ------------------------------
local getTime = love.timer.getTime
local getFPS = love.timer.getFPS

------------------------------ Constructor ------------------------------
local Profiler = middleclass("Profiler")
function Profiler:initialize()
	Object.initialize(self)
	self.depth = 100
	self.fps, self.tps = 0, 0
	self.objectCount = 0
	self.worldObjectCount, self.itemDropCount, self.gopherCount = 0, 0, 0
	self.cooldown = 60 * 5

	--self.jitpArgs = "i1Flv4"
	--self.jitpArgs = "Fl10r"
	self.jitpArgs = "Fl10r"
	
	self.profilingCooldown = 5
	self.showFps = true
	self.showQuickDebug = true
		

	self.tempLogFile = "jitp-log/temp.log"
	self.jitpLogFile = "jitp-log/" .. os.time() .. ".log"
	jitp.start(self.args, self.tempLogFile)
	self.jitpLog = ""
	--Already set in setRunningFullProfiling but its cleaner to have all mandatory members in init.
	self.lastJitpDump = 0
	
end	

------------------------------ Core API ------------------------------
function Profiler:update(dt)
	Object.update(self, dt)
	self.cooldown = self.cooldown > 0 and self.cooldown - 1 or self.cooldown
	if self.cooldown == 0 then
		if getFPS() < 55 then
			local str = "Objects: %d\nWorldObjects: %d (ItemDrops=%d,Gophers=%d)"
			print(str:format(self.objectCount, self.worldObjectCount, self.itemDropCount,
					self.gopherCount))
			self.cooldown = -1
		end
	end
	
	if self.runningFullProfiling and (getTime() - self.lastJitpDump > self.profilingCooldown) then
		jitp.stop()
		self.lastJitpDump = getTime()
		
		local temp = assert(io.open(self.tempLogFile, 'r'))
		local log = temp:read("*all")
		temp:close()
		
		local logFile = assert(io.open(self.jitpLogFile, "a"))
		logFile:write(log)
		io.write(log)
		logFile:write("=============== Next Dump ===============\n")
		io.write("=============== Next Dump ===============\n")
		logFile:close()
		
		if not self.freezeProfilingDisplay then
			self.jitpLog = log
		end
		jitp.start(self.jitpArgs, self.tempLogFile)
	end
end

function Profiler:draw(g2d)
	Object.draw(self, g2d)
	local LINE_W = 16
	local x, y = 0, GAME.windowH / 2
	if self.showQuickDebug then
		y = y - LINE_W
		local ent = GAME:getCurrentState().bumpWorld:countItems()
		g2d.print("raw-ent-count: " .. ent, x, y)
		y = y - LINE_W * 2
		local str = "Objects: %d\nWorldObjects: %d (ItemDrops=%d,Gophers=%d)"
		g2d.print(str:format(self.objectCount, self.worldObjectCount, self.itemDropCount,
				self.gopherCount), x, y)
	end
	if self.showFps then
		y = y - LINE_W
		g2d.print("FPS: " .. getFPS(), x, y)
	end
	if self.runningFullProfiling then
		if self.freezeProfilingDisplay then
			g2d.setColor(1, 0, 0)
			g2d.print("Usage Statistics (DISPLAY-FROZEN, profiling still running!):", 250, 0)
			g2d.print(self.jitpLog, 250, 16)
			g2d.setColor(1, 1, 1)
		else
			g2d.print("Usage Statistics (LIVE) (" .. self.profilingCooldown .. "s):", 250, 0)
			g2d.print(self.jitpLog, 250, 16)
		end
	end
end

------------------------------ Scene Callbacks ------------------------------
function Profiler:onSceneDestroy()
	print"scene destroy"
end

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

Profiler[EvGameQuit] = function(self, e)
	print("game quit")	
end

Profiler[EvKeyPress] = function(self, e)
	if e.key == 'space' then
		if self:isRunningFullProfiling() then 
			self.freezeProfilingDisplay = not self.freezeProfilingDisplay
		end
	elseif e.key == 'f2' then
		self.showFps = not self.showFps 
	elseif e.key == 'f3' then
		self.showQuickDebug = not self.showQuickDebug
	elseif e.key == 'f4' then
		self:setRunningFullProfiling(not self:isRunningFullProfiling())
	end
end

------------------------------ Getters / Setters ------------------------------
function Profiler:getJitpArgs() return self.jitpArgs end
function Profiler:isRunningFullProfiling() return self.runningFullProfiling end

--TODO: A nice table of options instead of the raw string.
function Profiler:setJitpArgs(args)
	self.jitpArgs = args
end

function Profiler:setRunningFullProfiling(bool)
	if self.runningFullProfiling == bool then return end
	self.runningFullProfiling = bool
	if bool then
		jitp.start(self.jitpArgs, self.tempLogFile)
		self.lastJitpDump = getTime()
	else
		jitp.stop()
	end
end

return Profiler