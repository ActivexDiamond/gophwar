---[[
io.stdout:setvbuf('no')			--Fix for some terminals not flushing properly with Lua.
local lovebird = require "libs.lovebird"
--Call update immediately to not miss any prints from the creation of objects or importing of files.
lovebird:update()

DEBUG = {
	ECHO_EVENTS = true,
	ALLOW_QUICK_EXIT = true,
}

local Game = require "core.Game"

local GAME_NAME = "GophWar"
local TARGET_WINDOW_W = 1024
local TARGET_WINDOW_H = 720

function love.load()
	Game(GAME_NAME, TARGET_WINDOW_W,
			TARGET_WINDOW_H)
end

function love.update(dt)
	lovebird:update(dt)
	GAME:update(dt)
end

function love.draw()
	local g2d = love.graphics
	GAME:draw(g2d)
end

--]]

--require "cat-paw-extras.quick-tests.overload.all"