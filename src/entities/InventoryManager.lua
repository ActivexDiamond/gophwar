local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local AssetRegistry = require "core.AssetRegistry"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InventoryManager = middleclass("InventoryManager", Object)
function InventoryManager:initialize(scene)
	Object.initialize(self, "inventory_manager")
	self.scene = scene
	
	self.items = {
		essence_base = 0,
		essence_chonky = 0,
		wood_stick = 0,
	}
end

------------------------------ Core API ------------------------------

function InventoryManager:draw(g2d)
	g2d.push('all')
	g2d.scale(2)
	local y = (GAME.windowH / 2 - self.slotSize) - 4 
	local x = self.slotSize
	
	local w = x * 4 - x
	g2d.setColor(0.3, 0.3, 0.3, 0.7)
	g2d.rectangle('fill', self.slotSize, y, w, self.slotSize + 2)
	
	g2d.setColor(1, 1, 1, 1)
	for k, v in pairs(self.items) do
		local spr, sx, sy = AssetRegistry:getSprInv(
				{ID = k, w = self.slotSize, h = self.slotSize})
		g2d.draw(spr, x, y, 0, sx, sy)
		g2d.print(v, x, y)
		x = x + self.slotSize
	end
	
	
	
	g2d.pop()
end
------------------------------ API ------------------------------
function InventoryManager:addItem(id, amount)
	self.items[id] = self.items[id] + 1
end
------------------------------ Getters / Setters ------------------------------

return InventoryManager