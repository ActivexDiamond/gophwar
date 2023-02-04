local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local CreditMenuScene = middleclass("CreditMenuScene", Scene)
function CreditMenuScene:initialize(...)
	Scene.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return CreditMenuScene