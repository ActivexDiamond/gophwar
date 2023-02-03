local middleclass = require "libs.middleclass"

local AbstractGame = require "core.AbstractGame"

local Scene = require "cat-paw-mods.Scene"
local MainMenuScene = require "scenes.MainMenuScene"
local OptionsMenuScene = require "scenes.OptionsMenuScene"
local CreditMenuScene = require "scenes.CreditMenuScene"
local TutorialMenuScene = require "scenes.TutorialMenuScene"
local InGameScene = require "scenes.InGameScene"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Game = middleclass("Game", AbstractGame)
function Game:initialize(...)
	AbstractGame.initialize(self, ...)
	GAME = self
	self:add(Game.MAIN_MENU_SCENE_ID, MainMenuScene())
	self:add(Game.OPTIONS_MENU_SCENE_ID, OptionsMenuScene())
	self:add(Game.CREDIT_MENU_SCENE_ID, CreditMenuScene())
	self:add(Game.TUTORIAL_MENU_SCENE_ID, TutorialMenuScene())
	self:add(Game.IN_GAME_SCENE_ID, InGameScene())
	
	self:goTo(Game.MAIN_MENU_SCENE)
end

------------------------------ Constants ------------------------------
Game.MAIN_MENU_SCENE_ID = 0
Game.OPTIONS_MENU_SCENE_ID = 1
Game.CREDIT_MENU_SCENE_ID = 2
Game.TUTORIAL_MENU_SCENE_ID = 3
Game.IN_GAME_SCENE_ID = 4

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Game