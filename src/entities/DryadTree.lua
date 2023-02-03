local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("DryadTree", WorldObject)
function Gopher:initialize(...)
	WorldObject.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Gopher