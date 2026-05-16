--============================ Env Setup ==============================
print("Setting stdout's vbuf mode to 'no'. This is needed for some consoles to work properly.")
io.stdout:setvbuf("no")

local extraPaths = "src/?.lua;src/?/init.lua;"
package.path = extraPaths .. package.path
--Love adds 2 extra loaders which are used for searching the .love archive and what not.
--They are not affected by `package.path`.
love.filesystem.setRequirePath(extraPaths .. love.filesystem.getRequirePath())

--[===[
local lovebird = require "libs.lovebird"
--Call update immediately to not miss any prints from the creation of objects or importing of files.
lovebird:update()
--]===]

--============================ Version Printers ==============================
local version = require "cat-paw.version"

print("============================================================")
print("Running Lua version:      ", _VERSION)
if jit then
	print("Running Luajit version:   ", jit.version)
end

print("Running Love2d version: ", love.getVersion())
print("Running CatPaw version: ", version)
print("\nCurrently using the following 3rd-party libraries (and possibly more):")
print("middleclass\tBy Kikito\tSingle inheritance OOP in Lua\t[MIT License]")
print("bump\t\tBy Kikito\tSimple platformer physics.\t[MIT License]")
print("suit\t\tBy vrld\t\tImGUIs for Lua/Love2D\t\t[MIT License]")
print("Huge thanks to (Kikito and vrld) for their wonderful contributions to the community; and for releasing their work under such open licenses!")
print("============================================================")	


--============================ Quick & Dirty Globals ==============================
MOUSE_ITEM_COUNT = 0
DEBUG = {
	ECHO_EVENTS = true,
	ALLOW_QUICK_EXIT = true,
--	DRAW_BOUNDING_BOXES = true,
}

--============================ SFX ==============================
local root = "assets/sfx/"
SFX = {
	arrow_shoot = love.audio.newSource(root .. "pewpew.mp3", "static"),
	gopher_eat = love.audio.newSource(root .. "nomnom.mp3", "static"),
	gopher_damage = love.audio.newSource(root .. "ouch.mp3", "static"),
	gopher_death = love.audio.newSource(root .. "death.mp3", "static"),
	craft = love.audio.newSource(root .. "craft.mp3", "static"),
	pickup = love.audio.newSource(root .. "pickup.mp3", "static"),
}

--============================ Entry Point ==============================
local Game = require "core.Game"

local GAME_NAME = "GophWar"
local TARGET_WINDOW_W = 540
local TARGET_WINDOW_H = 960

Game(GAME_NAME,   TARGET_WINDOW_W, TARGET_WINDOW_H)

