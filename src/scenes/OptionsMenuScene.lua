local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"
local OptionsGUI = require "gui.OptionsGUI"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local OptionsMenuScene = middleclass("TutorialMenuScene", Scene)
function OptionsMenuScene:initialize(...)
	Scene.initialize(self, ...)
	self:addObject(OptionsGUI())
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return OptionsMenuScene
