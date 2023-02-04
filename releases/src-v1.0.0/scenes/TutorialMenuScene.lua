local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local TutorialMenuScene = middleclass("TutorialMenuScene", Scene)
function TutorialMenuScene:initialize(...)
	Scene.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return TutorialMenuScene