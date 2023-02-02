require "prototype.main"

--[[
------------------------------ libs ------------------------------
local utils = require "libs.utils"

local Slab = require "Slab"					--So it initializes.
local Scheduler = require "libs.Scheduler"

local SimulationContainer = require "SimulationContainer" 

------------------------------ Config Init ------------------------------

------------------------------ Simulation Init ------------------------------

------------------------------ Core API ------------------------------
function love.update(dt)
	SimulationContainer:tick(dt)
	
	Scheduler:tick(dt)
end

function love.draw()
	local g = love.graphics
	SimulationContainer:draw(g)
	
	Scheduler:draw(g)
end

--]]