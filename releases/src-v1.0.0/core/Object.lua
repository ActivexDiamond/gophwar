local middleclass = require "libs.middleclass"

local DataRegistry = require "core.DataRegistry"

local Event = require "cat-paw.core.patterns.event.Event"
local EventSystem = require "cat-paw.core.patterns.event.EventSystem"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Object = middleclass("Object")
function Object:initialize(id)
	self.ID = id
	self.depth = 0
	--Not specifying which events will slow down the EventSystem as a whole,
	--but not by a lot.
	GAME:getEventSystem():attach(self, EventSystem.ATTACH_TO_ALL)
	DataRegistry:applyStats(self)
end

------------------------------ Core API ------------------------------
function Object:update(dt)

end

function Object:draw(g2d)

end

function Object:setDepth(depth)
	self.depth = depth;
end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------


return Object