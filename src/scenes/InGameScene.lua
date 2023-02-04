local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"

local Scene = require "cat-paw-mods.Scene"

local Gopher = require "entities.Gopher"
local DryadTree = require "entities.DryadTree"
local BaseBow = require "entities.BaseBow"
local RootController = require "entities.RootController"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InGameScene = middleclass("InGameScene", Scene)
function InGameScene:initialize(...)
	Scene.initialize(self, ...)

	local tree = DryadTree("dryad_tree", self, 0, 0)
	local treeX = (GAME.windowW / 2) - (tree.w / 2)
	local treeY = (GAME.windowH / 2) - (tree.h / 2)
	tree:setPosition(treeX, treeY)
	tree:setDepth(1)
	self:addObject(tree)
	self.dryadTree = tree

	local baseBow = BaseBow("crossbow_base", self, 0, 0)
	local bowX = (GAME.windowW / 2) - (baseBow.w / 2)
	local bowY = (GAME.windowH / 2) - (baseBow.h / 2)
	baseBow:setPosition(bowX, bowY)
	baseBow:setDepth(12)
	baseBow:setRotation(90)
	self:addObject(baseBow)

	local rootController = RootController(self)
	self:addObject(rootController)
	self.rootController = rootController 
	
end

------------------------------ Core API ------------------------------
function InGameScene:update(dt)
	Scene.update(self, dt)
	--print((mv - tv):getLength())
end
------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------
function InGameScene:getDryadTree()
	return self.dryadTree
end

return InGameScene