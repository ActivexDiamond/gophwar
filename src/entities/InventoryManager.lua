local middleclass = require "libs.middleclass"
local Object = require "core.Object"

local AssetRegistry = require "core.AssetRegistry"
local Button = require "entities.Button"
local EvMousePress = require "cat-paw.core.patterns.event.mouse.EvMousePress"
local WorldObject = require "core.WorldObject"

local Gopher = require "entities.Gopher"

local brinevector = require "libs.brinevector"
local Spike = require "entities.Spike"
------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local InventoryManager = middleclass("InventoryManager", Object)
function InventoryManager:initialize(scene)
	Object.initialize(self, "inventory_manager")
	self.scene = scene
	self.depth = 100
	self.items = {
		essence_base = 0,
		essence_chonky = 0,
		wood_stick = 0,
	}

	local y = (GAME.windowH - self.slotSize) - 4 
	local x = self.slotSize * 16
		
	self.scene:addObject(Button("spikes_tier1", self.scene, x, y, {
		essence_base = 2,
		essence_chonky = 0,
		wood_stick = 5,
		result = "spikes_tier1",
		amount = 5,
	}))
	
	x = self.slotSize * 17
	self.scene:addObject(Button("spikes_tier2", self.scene, x, y, {
		essence_base = 0,
		essence_chonky = 2,
		wood_stick = 5,
		result = "spikes_tier2",
		amount = 5,
	}))
	local bTurret1
	local bTurret2
	
end

------------------------------ Core API ------------------------------

function InventoryManager:draw(g2d)
	g2d.push('all')
	g2d.scale(2)
	local x = self.slotSize
	local y = (GAME.windowH / 2 - self.slotSize) - 4 
	
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
	if MOUSE_ITEM then
		local x, y = love.mouse.getPosition()
		local spr, sx, sy = AssetRegistry:getSprObj({ID = MOUSE_ITEM, w = 32, h = 32})
		g2d.draw(spr, x, y, 0, sx, sy)
		g2d.print(MOUSE_ITEM_COUNT, x+10, y+10)
	end
end
------------------------------ API ------------------------------
function InventoryManager:addItem(id, amount)
	self.items[id] = self.items[id] + 1
end

local lastPlace = love.timer.getTime()
function InventoryManager:update(dt)
	Object.update(self, dt)
	if not love.mouse.isDown(2) then return end
	if love.timer.getTime() - lastPlace > 0.5 then
		if not MOUSE_ITEM then return end
		local x, y = love.mouse.getPosition()
		local obj = Spike(MOUSE_ITEM, self.scene, x, y)
		self.scene:addObject(obj)
		MOUSE_ITEM_COUNT = MOUSE_ITEM_COUNT - 1
		if MOUSE_ITEM_COUNT <= 0 then
			MOUSE_ITEM = nil
		end
		lastPlace = love.timer.getTime()
	end
end

------------------------------ Getters / Setters ------------------------------

return InventoryManager