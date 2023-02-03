local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"

local DummyObject = require "debugging.DummyObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local MainMenuScene = middleclass("MainMenuScene", Scene)
function MainMenuScene:initialize(...)
	Scene.initialize(self, ...)
	self:addObject(DummyObject())
end

------------------------------ Core API ------------------------------
function MainMenuScene:enter(from, ...)
	Scene.enter(self, from, ...)
	print("At MainMenuScene.")
	
end

------------------------------ Callbacks ------------------------------
MainMenuScene[EvKeyPress] = function(self, e)
	if e.key == 'space' then
		print("Got [space],  skipping to InGameScene.")
		self.fsm:goTo(GAME.IN_GAME_SCENE_ID)	
	end
end
		
------------------------------ Getters / Setters ------------------------------

return MainMenuScene