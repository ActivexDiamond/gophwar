local middleclass = require "libs.middleclass"
local WorldObject = require "path.WorldObject"
local brinevector = require "libs.brinevector"

local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local ItemDrop = middleclass("ItemDrop", WorldObject)
function ItemDrop:initialize(id, scene, x, y, amount)
	WorldObject.initialize(self, id, scene, x, y)
	self.useInvSpr = true
	self.amount = amount
end

------------------------------ Core API ------------------------------

------------------------------ Callbacks ------------------------------
ItemDrop[EvMousePress] = function(self, e)
	local mv = brinevector(love.mouse.getPosition())
	local dist = (self:getCenter() - mv):getLength()
	if dist <= self.w then
		self.scene:getInventoryController():addItem(self.ID, self.amount)
		self.scene:removeObject(self)
	end
end

------------------------------ Getters / Setters ------------------------------

return ItemDrop