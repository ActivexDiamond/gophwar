local lovebird = require "libs.lovebird"
--Call update immediately to not miss any prints from the creation of objects or importing of files.
lovebird:update()
				
local Game = require "core.Game"

local GAME_NAME = "GophWar"
local TARGET_WINDOW_W = 1024
local TARGET_WINDOW_H = 720

local game;
function love.load()
	game = Game(GAME_NAME, TARGET_WINDOW_W,
			TARGET_WINDOW_H)
end

function love.update(dt)
	lovebird:update(dt)
	game:update(dt)
end

function love.draw()
	local g2d = love.graphics
	game:draw(g2d)
end
