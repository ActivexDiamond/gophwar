local middleclass = require "libs.middleclass"
local brinevector = require "libs.brinevector"

local Scene = require "cat-paw-mods.Scene"

local Gopher = require "entities.Gopher"
local DryadTree = require "entities.DryadTree"
local BaseBow = require "entities.BaseBow"
 
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InGameScene = middleclass("InGameScene", Scene)
function InGameScene:initialize(...)
	Scene.initialize(self, ...)

	local treeX = (GAME.windowW / 2) - (128 / 2)
	local treeY = (GAME.windowH / 2) - (128 / 2)
	self.dryadTree = DryadTree("dryad_tree", self, treeX, treeY, 128, 128)
	self.dryadTree:setDepth(1)
	self:addObject(self.dryadTree)

	local bowX = (GAME.windowW / 2) - (64 / 2)
	local bowY = (GAME.windowH / 2) - (64 / 2)
	local baseBow = BaseBow("base_bow", self, bowX, bowY, 64, 64)
	baseBow:setDepth(12)
	self:addObject(baseBow)
	
	self:addObject(Gopher("base_gopher", self, 100, 100, 32, 32))
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