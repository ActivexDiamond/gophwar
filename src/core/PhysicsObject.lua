local middleclass = require "libs.middleclass"
local WorldObject = require "core.WorldObject"

local AssetRegistry = require "core.AssetRegistry"

local brinevector = require "libs.brinevector"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local PhysicsObject = middleclass("PhysicsObject", WorldObject)
function PhysicsObject:initialize(id, scene, x, y)
	WorldObject.initialize(self, id, scene, x, y)
	self.vel = brinevector(0, 0)
end

------------------------------ Constants ------------------------------

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Phyiscs ------------------------------

------------------------------ Getters / Setters ------------------------------

return PhysicsObject