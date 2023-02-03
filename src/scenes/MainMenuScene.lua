local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local DummyObject = require "debugging.DummyObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local MainMenuScene = middleclass("MainMenuScene", Scene)
function MainMenuScene:initialize(...)
	Scene.initialize(self, ...)
	print("at main menu")
	self:addObject(DummyObject())
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return MainMenuScene