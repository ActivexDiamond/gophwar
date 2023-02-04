local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local TutorialMenuGui = require "gui.TutorialMenuGui"
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local TutorialMenuScene = middleclass("TutorialMenuScene", Scene)
function TutorialMenuScene:initialize(...)
	Scene.initialize(self, ...)
	self:addObject(TutorialMenuGui())
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return TutorialMenuScene