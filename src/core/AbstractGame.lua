local middleclass = require "libs.middleclass"

local Fsm = require "cat-paw.core.patterns.state.Fsm"
local ApiHooks = require "core.ApiHooks"

--local suit = require "libs.suit"
local Scheduler = require "cat-paw.core.timing.Scheduler"

local EventSystem = require "cat-paw.core.patterns.event.EventSystem"



------------------------------ Constructor ------------------------------
local AbstractGame = middleclass("AbstractGame", Fsm)
function AbstractGame:initialize(title, targetWindowW, targetWindowH)
	Fsm.initialize(self)
		
	self.title = title or "Untitled Game"
	love.window.setTitle(title)
	self.windowW, self.windowH = targetWindowW, targetWindowH
	love.window.setMode(targetWindowW, targetWindowH)
			
	self.scheduler = Scheduler()
	self.eventSystem = EventSystem()
	ApiHooks.hookHandler(self)
end

------------------------------ Constants ------------------------------
--This temp code for GUI scaling, and some configs for the Inventory code from cat-paw.
--This should be placed somewhere more proper.
AbstractGame.graphics = {}
do
	local g = AbstractGame.graphics
	g.GUI_SCALE = 0.75
	GUI_SCALE = g.GUI_SCALE				--TODO: Store GUI scale correctly.
	g.ITEM_W, g.ITEM_H = 48, 48

	g.CELL_PAD_X, g.CELL_PAD_Y = 4, 4	--space between slot-borders and item inside of it.
	g.CELL_W = g.ITEM_W + g.CELL_PAD_X
	g.CELL_H = g.ITEM_H + g.CELL_PAD_Y
	
	g.INV_PAD = 4						--space between slots
end

------------------------------ Core ------------------------------
function AbstractGame:load(args)
	print(self.title .. " loaded.")
end

function AbstractGame:update(dt)
	Fsm.update(self, dt)
	
	self.scheduler:update(dt)
	self.eventSystem:poll()
end

function AbstractGame:draw(g2d)
	Fsm.draw(self, g2d)
	
--	g.scale(AbstractGame.graphics.GUI_SCALE)
--		if self.loadedWorld then self.loadedWorld:drawGui() end
--	g.scale(1/AbstractGame.graphics.GUI_SCALE)
end

------------------------------ Other ------------------------------
--Wrapper so AbstractGame can be directly passed to ApiHooks. Shouldn't be used anywhere else.
--If you want to queue stuff, use game:getEventSystem():queue(event)
--TODO: Find a better way to make this class an ApiHooks work nicely.
function AbstractGame:queue(...)
	self.eventSystem:queue(...)
end

------------------------------ Getters / Setters ------------------------------
function AbstractGame:getWindowW() return self.windowW end
function AbstractGame:getWindowH() return self.windowH end
function AbstractGame:getWindowSize() return self.windowW, self.windowH end

function AbstractGame:setWindowSize(w, h) 
	self.windowW, self.windowH = w, h
	love.window.setMode(w, h)
end

--TODO: Service locator
function AbstractGame:getEventSystem()
	return self.eventSystem
end

function AbstractGame:getScheduler()
	return self.scheduler
end

return AbstractGame

