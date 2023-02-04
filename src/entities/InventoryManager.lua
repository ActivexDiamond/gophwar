local middleclass = require "libs.middleclass"
local Object = require "path.Object"

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

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return InventoryManager