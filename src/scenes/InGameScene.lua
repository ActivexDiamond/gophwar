local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"

local Scene = require "cat-paw-mods.Scene"

local EventSystem = require "cat-paw.core.patterns.event.EventSystem"
local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"

local Gopher = require "entities.Gopher"
local DryadTree = require "entities.DryadTree"
local BaseBow = require "entities.BaseBow"
local RootController = require "entities.RootController"
local GopherSpawner = require "entities.GopherSpawner"
local RootController = require "entities.RootController"
local DecorationSpawner = require "entities.DecorationSpawner"
local InventoryManager = require "entities.InventoryManager"
local WorldObject = require "core.WorldObject"
local Profiler = require "debugging.Profiler"

------------------------------ Helpers ------------------------------
local function rgbToLove(r, g, b, a)
	a = a or 255
	return r/255, g/255, b/255, a/255 
end
------------------------------ Constructor ------------------------------
local InGameScene = middleclass("InGameScene", Scene)
function InGameScene:initialize(...)
	Scene.initialize(self, ...)
	GAME:getEventSystem():attach(self, EventSystem.ATTACH_TO_ALL)
	
	--Profiler
	self.profiler = Profiler()
	self:addObject(self.profiler)
	
	--DryadTree
	local tree = DryadTree("dryad_tree", self, 0, 0)
	local treeX = (GAME.windowW / 2) - (tree.w / 2)
	local treeY = (GAME.windowH / 2) - (tree.h / 2)
	tree:setPosition(treeX, treeY)
	tree:setSpriteOffset(WorldObject.SPRITE_CENTER)
	tree:setDepth(1)
	self:addObject(tree)
	self.dryadTree = tree

	--BaseBow
	local baseBow = BaseBow("crossbow_base", self, 0, 0)
	local bowX = (GAME.windowW / 2) - (baseBow.w / 2)
	local bowY = (GAME.windowH / 2) - (baseBow.h / 2)
	baseBow:setPosition(bowX, bowY)
	baseBow:setDepth(12)
	baseBow:setRotation(90)
	self:addObject(baseBow)

	--RootController
	local rootController = RootController(self)
	self:addObject(rootController)
	self.rootController = rootController 

	--GopherSpawner
	local gopherSpawner = GopherSpawner(self)
	self:addObject(gopherSpawner)
	self.gopherSpawner = gopherSpawner

	--DecorationSpawner	
	local decorationSpawner = DecorationSpawner(self)
	self:addObject(decorationSpawner)
	self.decorationSpawner = decorationSpawner		

	--InventoryManager
	local inventoryManager = InventoryManager(self)
	self:addObject(inventoryManager)
	self.inventoryManager = inventoryManager
	
	self:addObject(Gopher("gopher_base", self, 200, 200))
end

------------------------------ Core API ------------------------------
--function InGameScene:update(dt)
--end

function InGameScene:draw(g2d)
	g2d.scale(GAME.SCALE)
	Scene.draw(self, g2d) 
	g2d.setBackgroundColor(rgbToLove(33, 64, 13))
	
	--44, 87, 19
	--33, 64, 13
end

------------------------------ Events ------------------------------
InGameScene[EvKeyPress] = function(self, e)
	if e.key == 'escape' then
		love.event.quit()
	end
end

------------------------------ Getters / Setters ------------------------------
function InGameScene:getDryadTree()
	return self.dryadTree
end

function InGameScene:getInventoryManager()
	return self.inventoryManager
end
	

return InGameScene