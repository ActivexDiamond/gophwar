local middleclass = require "libs.middleclass"

local DataRegistry = require "core.DataRegistry"
local AssetRegistry = require "core.AssetRegistry"

local Event = require "cat-paw.core.patterns.event.Event"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Object = middleclass("Object")
function Object:initialize(id)
	self.ID = id
	GAME:getEventSystem():attach(self, Event)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Object