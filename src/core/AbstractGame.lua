local class = require "libs.cruxclass"

local FiniteStateMachine = require "core.FiniteStateMachine"

local suit = require "libs.suit"
local Scheduler = require "utils.Scheduler"

local Evsys = require "evsys.Evsys"
local KeyPressEvent = require "evsys.input.KeyPressEvent"
local KeyReleaseEvent = require "evsys.input.KeyReleaseEvent"
local TextInputEvent = require "evsys.input.TextInputEvent"

local MousePressEvent = require "evsys.input.MousePressEvent"
local MouseReleaseEvent = require "evsys.input.MouseReleaseEvent"
local MouseMoveEvent = require "evsys.input.MouseMoveEvent"
local MouseWheelEvent = require "evsys.input.MouseWheelEvent"

local WindowFocusEvent = require "evsys.os.WindowFocusEvent"
local WindowResizeEvent = require "evsys.os.WindowResizeEvent"
local GameQuitEvent = require "evsys.os.GameQuitEvent"


------------------------------ Constructor ------------------------------

--TODO: Refactor to be FSM-based.
local AbstractGame = class("AbstractGame", FiniteStateMachine)
function AbstractGame:init(title)
	self.title = title or "Untitled Game"
	--TODO: Proper ServiceLocator
	--self.Scheduler = Scheduler
	self:_hookLoveCallbacks()
	self:_hookLibs()
end

------------------------------ Constants ------------------------------
AbstractGame.GRAVITY_X = 0
AbstractGame.GRAVITY_Y = 25

AbstractGame.graphics = {}
do
	local g = AbstractGame.graphics
	g.GUI_SCALE = 0.75
	GUI_SCALE = g.GUI_SCALE --TODO: Store GUI scale correctly.
	g.ITEM_W, g.ITEM_H = 48, 48

	g.CELL_PAD_X, g.CELL_PAD_Y = 4, 4	--space between slot-borders and item inside of it.
	g.CELL_W = g.ITEM_W + g.CELL_PAD_X
	g.CELL_H = g.ITEM_H + g.CELL_PAD_Y
	
	g.INV_PAD = 4						--space between slots
end
------------------------------ Core ------------------------------
function AbstractGame:tick(dt)
	FiniteStateMachine.tick(self, dt)
	
	self.scheduler:tick(dt)
	Evsys:poll()
end

function AbstractGame:draw()
	local g = love.graphics
	FiniteStateMachine.draw(self, g)
	
	if self.loadedWorld then self.loadedWorld:draw(g) end
	
	g.scale(AbstractGame.graphics.GUI_SCALE)
		if self.loadedWorld then self.loadedWorld:drawGui() end
	g.scale(1/AbstractGame.graphics.GUI_SCALE)
end

------------------------------ Getters / Setters ------------------------------
function AbstractGame:getLoadedWorld()
	return self.loadedWorld
end

function AbstractGame:setLoadedWorld(w)
	self.loadedWorld = w
end

return AbstractGame

--[[
Needed methods:

getLoadedWorld
getGridW
getGridH

Note: Is a singleton

return Game() -- this script should return an instance of
	Game, the only one; providing no access to the class's init.
	(Possibly requiring to forbid access to the class in it's entirety)
--]]