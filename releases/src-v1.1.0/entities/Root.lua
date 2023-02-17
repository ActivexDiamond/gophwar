local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Root = middleclass("Root", WorldObject)
function Root:initialize(scene, x, y)
	WorldObject.initialize(self, "root", scene, x, y)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Root