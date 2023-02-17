local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"
local brinevector = require "libs.brinevector"

local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Button = middleclass("Button", WorldObject)
function Button:initialize(id, scene, x, y, recipe)
	WorldObject.initialize(self, id, scene, x, y)
	self.w, self.h = 32, 32
	self.useInvSpr = false
	self.recipe = recipe
	self.ID = self.recipe.result
	self.depth = 100
	self.rect = true
	self.filled = true
	
end

------------------------------ Core API ------------------------------


function Button:update(dt)
	WorldObject.update(self, dt)
	if not love.mouse.isDown(2) then return end
	local mv = brinevector(love.mouse.getPosition())
	local dist = (self:getCenter() - mv):getLength()
	if dist <= self.w then
		if MOUSE_ITEM then return end
		--print("got hit", self, self.recipe.result)
		local inv = self.scene:getInventoryManager().items
		if self.recipe.essence_base <= inv.essence_base and
				self.recipe.essence_chonky <= inv.essence_chonky and
				self.recipe.wood_stick <= inv.wood_stick then
			inv.essence_base = inv.essence_base - self.recipe.essence_base
			inv.essence_chonky = inv.essence_chonky - self.recipe.essence_chonky
			inv.wood_stick = inv.wood_stick - self.recipe.wood_stick
			MOUSE_ITEM = self.recipe.result
			MOUSE_ITEM_COUNT = self.recipe.amount 
		end
	end
	
end
------------------------------ Callbacks ------------------------------
--Button[EvMousePress] = function(self, e)
--	local mv = brinevector(love.mouse.getPosition())
--	local dist = (self:getCenter() - mv):getLength()
--	print(self.w, 32)
--	if dist <= self.w then
--		if MOUSE_ITEM then return end
--		print("got hit", self, self.recipe.result)
--		
--		self.scene:getInventoryManager():addItem(self.ID, self.amount)
--		self.scene:removeObject(self)
--		love.audio.play(SFX.pickup)
--		
--		local inv = self.scene:getInventoryManager().items
--		if self.recipe.essence_base <= inv.essence_base and
--				self.recipe.essence_chonky <= inv.essence_chonky and
--				self.recipe.wood_stick <= inv.wood_stick then
--			inv.essence_base = inv.essence_base - self.recipe.essence_base
--			inv.essence_chonky = inv.essence_chonky - self.recipe.essence_chonky
--			inv.wood_stick = inv.wood_stick - self.recipe.wood_stick
--			MOUSE_ITEM = self.recipe.result 
--		end
--	end
--end

------------------------------ Getters / Setters ------------------------------

return Button