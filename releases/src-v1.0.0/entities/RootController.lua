local middleclass = require "libs.middleclass"
local parent = require "path.parent"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local RootController = middleclass("RootController", parent)
function RootController:initialize(...)
	parent.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return RootController