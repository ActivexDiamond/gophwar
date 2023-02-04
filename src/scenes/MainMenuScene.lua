local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local EventSystem = require "cat-paw.core.patterns.event.EventSystem"
local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"

local DummyObject = require "debugging.DummyObject"
--local GuiTest = require "gui.GuiTest"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local MainMenuScene = middleclass("MainMenuScene", Scene)
function MainMenuScene:initialize(...)
	Scene.initialize(self, ...)
	GAME:getEventSystem():attach(self, EventSystem.ATTACH_TO_ALL)
	self:addObject(DummyObject("iron_oreblock", self, 32, 32, 32, 32))
--	self:addObject(GuiTest)
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