local middleclass = require "libs.middleclass"

local Event = require "cat-paw.core.patterns.event.Event"
local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DebugObject = middleclass("DebugObject")
function DebugObject:initialize()
	GAME:getEventSystem():attach(self, Event)
end

------------------------------ Core API ------------------------------

------------------------------ Callbacks ------------------------------
DebugObject[EvKeyPress] = function(self, e)
	if DEBUG.ALLOW_QUICK_EXIT and e.key == 'escape' then
		love.event.quit()
	end
end
------------------------------ Getters / Setters ------------------------------

return DebugObject