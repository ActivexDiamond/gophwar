local middleclass = require "libs.middleclass"
local Object = require "core.Object"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local WorldObject = middleclass("WorldObject", Object)
---Can take (id, x, y) or (id, vector)
function WorldObject:initialize(id, a, b)
	Object.initialize(self, id)
	if b then
		self.pos = brinevector(a, b)
	else
		assert(brinevector.isVector(a), "Invalid WorldObject initialization arguments. Must be either x/y or Vector2.")
		self.pos = a:getCopy()
	end
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return WorldObject