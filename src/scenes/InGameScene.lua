local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local Gopher = require "entities.Gopher"
 
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InGameScene = middleclass("InGameScene", Scene)
function InGameScene:initialize(...)
	Scene.initialize(self, ...)
	
	self:addObject(Gopher("base_gopher", 300, 300, 32, 32))
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return InGameScene