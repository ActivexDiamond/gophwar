local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"
local brinevector = require "libs.brinevector"

local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local ItemDrop = middleclass("ItemDrop", WorldObject)
function ItemDrop:initialize(id, scene, x, y, amount)
	WorldObject.initialize(self, id, scene, x, y)
	if id == "wood_stick" then
		self.w, self.h = 64, 64
	else
		self.w, self.h = 32, 32
	end
	self.useInvSpr = true
	self.amount = amount
	
	--FIXME: Removal is queued, so this hack is needed.
	self.wasPickedUp = false
end

------------------------------ Core API ------------------------------

------------------------------ Callbacks ------------------------------
ItemDrop[EvMousePress] = function(self, e)
	if self.wasPickedUp then return end
	local mv = brinevector(love.mouse.getPosition())
	local dist = (self:getCenter() - mv):getLength()
	if dist <= self.w then
		self.scene:getInventoryManager():addItem(self.ID, self.amount)
		self.scene:removeObject(self)
		self.wasPickedUp = true
		love.audio.play(SFX.pickup)
	end
end

------------------------------ Getters / Setters ------------------------------

return ItemDrop
