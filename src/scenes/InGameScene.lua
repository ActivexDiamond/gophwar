local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local Gopher = require "entities.Gopher"
local DryadTree = require "entities.DryadTree"
--local BaseBow = require "entities.BaseBow"
 
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InGameScene = middleclass("InGameScene", Scene)
function InGameScene:initialize(...)
	Scene.initialize(self, ...)

	self:addObject(Gopher("base_gopher", self, 100, 100, 32, 32))


	local treeX = (GAME.windowW / 2) - (128 / 2)
	local treeY = (GAME.windowH / 2) - (128 / 2)
	self:addObject(DryadTree("drayd_tree", self, treeX, treeY, 128, 128))

	local bowX = (GAME.windowW / 2) - (64 / 2)
	local bowY = (GAME.windowH / 2) - (64 / 2)
--	self:addObject(BaseBow("base_bow", self, bowX, bowY, 64, 64))
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return InGameScene