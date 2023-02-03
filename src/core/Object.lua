local middleclass = require "libs.middleclass"

local DataRegistry = require "core.DataRegistry"

local Event = require "cat-paw.core.patterns.event.Event"
local EventSystem = require "cat-paw.core.patterns.event.EventSystem"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Object = middleclass("Object")
function Object:initialize(id)
	self.ID = id
	GAME:getEventSystem():attach(self, EventSystem.ATTACH_TO_ALL)
	DataRegistry:applyStats(self)
end

------------------------------ Core API ------------------------------
function Object:update(dt)

end

function Object:draw(g2d)

end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Object