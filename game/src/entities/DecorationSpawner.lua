local middleclass = require "libs.middleclass"
local Object = require "core.Object"
local brinevector = require "libs.brinevector"
local Gopher = require "entities.Gopher"
local WorldObject = require "core.WorldObject"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DecorationSpawner = middleclass("DecorationSpawner", Object)
function DecorationSpawner:initialize(scene)
	Object.initialize(self, "decoration_spawner")
	self.scene = scene
	self:_spawnTrees()
end

------------------------------ Core API ------------------------------
function DecorationSpawner:update(dt)
	Object.update(self, dt)
end

function DecorationSpawner:draw(g2d)
	Object.draw(self, g2d)
end

------------------------------ Internals ------------------------------
function DecorationSpawner:_spawnTrees()
	local count = math.random(self.treeCountMin, self.treeCountMax)
	print("Will spawn " .. count .. " trees.")
	self.trees = {}
	local attempts = 0
	local maxAttempts = 3000
	repeat
		local x = math.random(32, GAME.windowW - 32)
		local y = math.random(32, GAME.windowH - 32)
		if x < 700 or x > 1200 or y < 300 or y > 700 then
			local tree = WorldObject("tree", self.scene, x, y)
			local canSpawn = true
			for _, t in ipairs(self.trees) do
				local dist = (tree:getCenter() - t:getCenter()):getLength()
				if dist <= tree.w then
					canSpawn = false
					break
				end
			end
			if canSpawn then
				table.insert(self.trees, tree)
				self.scene:addObject(tree)
				count = count - 1
			end
		end
		attempts = attempts + 1
	until count <= 0 or attempts > maxAttempts
end

------------------------------ Getters / Setters ------------------------------

return DecorationSpawner