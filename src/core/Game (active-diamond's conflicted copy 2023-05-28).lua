 local middleclass = require "libs.middleclass"

local AbstractGame = require "cat-paw.engine.AbstractGame"

local Scene = require "cat-paw-mods.Scene"
local MainMenuScene = require "scenes.MainMenuScene"
local OptionsMenuScene = require "scenes.OptionsMenuScene"
local CreditMenuScene = require "scenes.CreditMenuScene"
local TutorialMenuScene = require "scenes.TutorialMenuScene"
local InGameScene = require "scenes.InGameScene"
local GameOverScreen = require "scenes.GameOverScene"

local shack = require "libs.shack"

------------------------------ Helpers ------------------------------
local State = require "cat-paw.core.patterns.state.State"

------------------------------ Constructor ------------------------------
local Game = middleclass("Game", AbstractGame)
function Game:initialize(...)
	AbstractGame.initialize(self, ...)
	math.randomseed(os.time())
	self:_loadAllAssets()
	
	self.SCALE = 1
	self.windowW = self.windowW / self.SCALE
	self.windowH = self.windowH / self.SCALE  
	
	GAME = self
	self:add(Game.MAIN_MENU_SCENE_ID, MainMenuScene())
	self:add(Game.OPTIONS_MENU_SCENE_ID, OptionsMenuScene())
	self:add(Game.CREDIT_MENU_SCENE_ID, CreditMenuScene())
	self:add(Game.TUTORIAL_MENU_SCENE_ID, TutorialMenuScene())
	self:add(Game.IN_GAME_SCENE_ID, InGameScene())
	self:add(Game.GAME_OVER_SCENE_ID, GameOverScreen())
	
	self:goTo(Game.MAIN_MENU_SCENE_ID)
	--self:goTo(Game.IN_GAME_SCENE_ID)
end

------------------------------ Constants ------------------------------
Game.MAIN_MENU_SCENE_ID = 0
Game.OPTIONS_MENU_SCENE_ID = 1
Game.CREDIT_MENU_SCENE_ID = 2
Game.TUTORIAL_MENU_SCENE_ID = 3
Game.IN_GAME_SCENE_ID = 4
Game.GAME_OVER_SCENE_ID = 5

------------------------------ Core API ------------------------------
function Game:update(dt)
	AbstractGame.update(self, dt)
	shack:update(dt)
end

function Game:draw()
	local g2d = love.graphics
	shack:apply()
	AbstractGame.draw(self, g2d)
end

------------------------------ Internals ------------------------------
function AbstractGame:_loadAllAssets()
	local tAll, tData, tInv, tObj, tGui
	local time = love.timer.getTime
	
	tAll = time() 
	local DataRegistry = require "core.DataRegistry"
	print "------------------------------ Loading Data... ------------------------------"
		tData = time(); DataRegistry:loadData(); tData = time() - tData
	print "Done!\n"
		
	local AssetRegistry = require "core.AssetRegistry"
	print "------------------------------ Loading Sprites (inv)... ------------------------------"
	tInv = time(); AssetRegistry:loadSprInv(); tInv = time() - tInv
	
	print "------------------------------ Loading Sprites (obj)... ------------------------------"
	tObj = time(); AssetRegistry:loadSprObj(); tObj = time() - tObj
	
	print "------------------------------ Loading Sprites (gui)... ------------------------------"
		tGui = time(); AssetRegistry:loadSprGui(); tGui = time() - tGui
	print "Done!"
	tAll = time() - tAll
	
local str = string.format([[
------------------------------------------------------------
	Loading dat took: %.2fms
	Loading Inv took: %.2fms
	Loading Obj took: %.2fms
	Loading Gui took: %.2fms
	>Total load-time: %.4fs
------------------------------------------------------------
	]], tData*1e3, tInv*1e3, tObj*1e3, tGui*1e3, tAll)
	print(str)
end

------------------------------ Getters / Setters ------------------------------

return Game
