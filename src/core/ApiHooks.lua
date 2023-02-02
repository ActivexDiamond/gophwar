local class = require "libs.cruxclass"

local suit = require "libs.suit"

local Evsys = require "evsys.Evsys"
local IEventHandler = require "evsys.IEventHandler"

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
local ApiHooks = class("LoveHooks")
function ApiHooks:init(game)
	self:_hookLoveCallbacks(game)
	
	self:_hookSuit()
	self:_hookSuitCallbacks()
end

------------------------------ Hooks ------------------------------
---------LoveEvents->Evsys
function ApiHooks:_hookLoveCallbacks(game)
	local wrap = ApiHooks._loveCallbackWrapper
	--Game
	if game.run then love.run = game.run 
	else
		love.load = game.load
		love.update = game.tick
		love.draw = game.draw
	end
	--Evsys
	love.keypressed = wrap(self.onKeyPressed)
	love.keyreleased = wrap(self.onKeyReleased)
	love.textinput = wrap(self.onTextInput)
	
	love.mousepressed = wrap(self.onMousePressed)
	love.mousereleased = wrap(self.onMouseReleased)
	love.mousemoved = wrap(self.onMouseMoved)
	love.wheelmoved = wrap(self.onWheelMoved)
	
	love.focus = wrap(self.onWindowFocus)
	love.resize = wrap(self.onWindowResize)
	love.quit = wrap(self.onGameQuit)
end

---------Suit
function ApiHooks:_hookSuit()
	--Convert widget.hit to return L/R/false button vs true/false.
	local um = suit.updateMouse	
	local s = GUI_SCALE	--TODO: Fetch GUI scale correctly.
	function suit.updateMouse(self, x, y, button_down)
		local m1, m2 = love.mouse.isDown(1), love.mouse.isDown(2)
		local b = (m1 and 1 or 0) + (m2 and 2 or 0)
		if b == 0 then b = false end
		um(self, x/s, y/s, b)		
	end
end

function ApiHooks:_hookSuitCallbacks()
	local SuitHookDummy = class("SuitHookDummy"):include(IEventHandler)
	SuitHookDummy:attach(KeyPressEvent, function(self, e)
		suit.keypressed(e.k)
	end)
	SuitHookDummy:attach(TextInputEvent, function(self, e)
		suit.textinput(e.char)
	end)
end

------------------------------ Helpers ------------------------------
function ApiHooks:_loveCallbackWrapper(f)
	return f and function(...) -- wrapper or nil 
		return f(self, ...)
	end
end

------------------------------ Evsys ------------------------------

---------Keyboard
function ApiHooks:onKeyPressed(k, code, isRepeat)
	Evsys:queue(KeyPressEvent(k, code, isRepeat))
	suit.keypressed(k)
end
function ApiHooks:onKeyReleased(k, code, isRepeat)
	Evsys:queue(KeyReleaseEvent(k, code, isRepeat))
end
function ApiHooks:onTextInput(char)
	Evsys:queue(TextInputEvent(char))
	suit.textinput(char)
end

---------Mouse
function ApiHooks:onMousePressed(x, y, button, touch)
	Evsys:queue(MousePressEvent(x, y, button, touch))
end
function ApiHooks:onMouseReleased(x, y, button, touch)
	Evsys:queue(MouseReleaseEvent(x, y, button, touch))
end
function ApiHooks:onMouseMoved(x, y, dx, dy, touch)
	Evsys:queue(MouseMoveEvent(x, y, dx, dy, touch))
end
function ApiHooks:onWheelMoved(x, y)
	Evsys:queue(MouseWheelEvent(x, y))
end

---------OS
function ApiHooks:onWindowFocus(focus)
	Evsys:queue(WindowFocusEvent(focus))
end
function ApiHooks:onWindowResize(w, h)
	Evsys:queue(WindowResizeEvent(w, h))
end
function ApiHooks:onGameQuit()
	Evsys:queue(GameQuitEvent())
end

return ApiHooks()