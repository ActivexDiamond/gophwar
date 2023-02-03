local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local OptionsMenuScene = middleclass("TutorialMenuScene", Scene)
function OptionsMenuScene:initialize(...)
	Scene.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return OptionsMenuScene
