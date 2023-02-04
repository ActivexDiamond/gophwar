local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"
local CreditGUI = require "gui.CreditGUI"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local CreditMenuScene = middleclass("CreditMenuScene", Scene)
function CreditMenuScene:initialize(...)
	Scene.initialize(self, ...)
	self:addObject(CreditGUI())
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return CreditMenuScene