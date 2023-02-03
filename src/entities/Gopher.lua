local middleclass = require "libs.middleclass"
local Object = require "core.Object"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Gopher = middleclass("Gopher", Object)
function Gopher:initialize(...)
	Object.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Gopher