---[[
io.stdout:setvbuf('no')			--Fix for some terminals not flushing properly with Lua.
--local lovebird = require "libs.lovebird"
--Call update immediately to not miss any prints from the creation of objects or importing of files.
--lovebird:update()

MOUSE_ITEM_COUNT = 0
DEBUG = {
	ECHO_EVENTS = true,
	ALLOW_QUICK_EXIT = true,
	--DRAW_BOUNDING_BOXES = true,
}

local root = "assets/sfx/"
SFX = {
	arrow_shoot = love.audio.newSource(root .. "pewpew.mp3", "static"),
	gopher_eat = love.audio.newSource(root .. "nomnom.mp3", "static"),
	gopher_damage = love.audio.newSource(root .. "ouch.mp3", "static"),
	gopher_death = love.audio.newSource(root .. "death.mp3", "static"),
	craft = love.audio.newSource(root .. "craft.mp3", "static"),
	pickup = love.audio.newSource(root .. "pickup.mp3", "static"),
}

local Game = require "core.Game"

local GAME_NAME = "GophWar"
local TARGET_WINDOW_W = -1
local TARGET_WINDOW_H = -1

Game(GAME_NAME, TARGET_WINDOW_W, TARGET_WINDOW_H)

--]]

--require "cat-paw-extras.quick-tests.overload.all"