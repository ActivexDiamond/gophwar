local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("Gopher", WorldObject)
function Gopher:initialize(...)
	WorldObject.initialize(self, ...)
	self.treePosition = 0 
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Gopher