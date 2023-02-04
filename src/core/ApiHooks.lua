local middleclass = require "libs.middleclass"


local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"
local EvKeyRelease = require "cat-paw.core.patterns.event.keyboard.EvKeyRelease"
local EvTextInput = require "cat-paw.core.patterns.event.keyboard.EvTextInput"
local EvTextEdit = require "cat-paw.core.patterns.event.keyboard.EvTextEdit"


local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"
local EvMouseRelease = require "cat-paw.core.patterns.event.mouse.EvMouseRelease"
local EvMouseMove = require "cat-paw.core.patterns.event.mouse.EvMouseMove"
local EvMouseWheel = require "cat-paw.core.patterns.event.mouse.EvMouseWheel"

local EvWindowFocus = require "cat-paw.core.patterns.event.os.EvWindowFocus"
local EvWindowResize = require "cat-paw.core.patterns.event.os.EvWindowResize"
local EvGameQuit = require "cat-paw.core.patterns.event.os.EvGameQuit"

------------------------------ Constructor ------------------------------
local ApiHooks = middleclass("ApiHooks")
function ApiHooks:initialize()
	error("Attempting to initialize static class!" .. ApiHooks)
end

------------------------------ API ------------------------------
-- Can be any object (or even table) with `queue`, `load`, `tick`, and 
-- `draw` methods. And optionally a `run` method.
-- `load` can be nil with no issues. `tick` and `draw` can technically be null
-- but logic will not process nor will anything be drawn.
function ApiHooks.static.hookHandler(handler)
	ApiHooks._hookLoveCallbacks(handler)
end

------------------------------ Hooks ------------------------------
---------LovEvents->Evsys
function ApiHooks.static._hookLoveCallbacks(handler)
	local wrap = ApiHooks._loveCallbackWrapper
	--Game
	if handler.run then love.run = handler.run 
	else
		handler.load = handler.load
		handler.update = handler.tick
		handler.draw = handler.draw
	end
	--Evsys
	
	love.keypressed = wrap(handler, ApiHooks._onKeyPressed)
	love.keyreleased = wrap(handler, ApiHooks._onKeyReleased)
	love.textinput = wrap(handler, ApiHooks._nTextInput)
	love.texteditted = wrap(handler, ApiHooks._nTextEdit)
	
	love.mousepressed = wrap(handler, ApiHooks._onMousePressed)
	love.mousereleased = wrap(handler, ApiHooks._onMouseReleased)
	love.mousemoved = wrap(handler, ApiHooks._onMouseMoved)
	love.wheelmoved = wrap(handler, ApiHooks._onMouseWheel)
	
	love.focus = wrap(handler, ApiHooks._onWindowFocus)
	love.resize = wrap(handler, ApiHooks._onWindowResize)
	love.quit = wrap(handler, ApiHooks._onGameQuit)
end

------------------------------ Helpers ------------------------------
function ApiHooks.static._loveCallbackWrapper(handler, f)
	return f and function(...) -- wrapper or nil 
		return f(handler, ...)
	end
end

------------------------------ Evsys ------------------------------

---------Keyboard
function ApiHooks.static._onKeyPressed(handler, k, code, isRepeat)
	handler:queue(EvKeyPress(k, code, isRepeat))
end
function ApiHooks.static._onKeyReleased(handler, k, code, isRepeat)
	handler:queue(EvKeyRelease(k, code, isRepeat))
end
function ApiHooks.static._onTextInput(handler, char)
	handler:queue(EvTextInput(char))
end

function ApiHooks.static._onTextEdit(handler, text, start, length)
	handler:queue(EvTextEdit(text, start, length))
end

---------Mouse
function ApiHooks.static._onMousePressed(handler, x, y, button, touch)
	handler:queue(EvMousePress(x, y, button, touch))
end
function ApiHooks.static._onMouseReleased(handler, x, y, button, touch)
	handler:queue(EvMouseRelease(x, y, button, touch))
end
function ApiHooks.static._onMouseMoved(handler, x, y, dx, dy, touch)
	handler:queue(EvMouseMove(x, y, dx, dy, touch))
end
function ApiHooks.static._onMouseWheel(handler, x, y)
	handler:queue(EvMouseWheel(x, y))
end

---------OS
function ApiHooks.static._onWindowFocus(handler, focus)
	handler:queue(EvWindowFocus(focus))
end
function ApiHooks.static._onWindowResize(handler, w, h)
	handler:queue(EvWindowResize(w, h))
end
function ApiHooks.static._onGameQuit(handler)
	handler:queue(EvGameQuit())
end

return ApiHooks