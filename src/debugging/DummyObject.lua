local middleclass = require "libs.middleclass"

local Event = require "cat-paw.core.patterns.event.Event"
local EvMouse = require "cat-paw.core.patterns.event.mouse.EvMouse"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local DummyObject = middleclass("DummyObject")
function DummyObject:initialize()
	--Not specifying which events will slow down the EventSystem as a whole,
	--but not by a lot.
	GAME:getEventSystem():attach(self, {Event})
end

------------------------------ Core API ------------------------------
function DummyObject:update(dt)
	if love.keyboard.isDown("d") then
		print("dummyObject getting update " .. dt)
	end
end

function DummyObject:draw(g2d)
	if love.keyboard.isDown("d") then
		print("dummyObject getting draw ")
	end
end

------------------------------ API ------------------------------

------------------------------ Callbacks ------------------------------
DummyObject[Event] = function(self, e)
	if tostring(e) == "instance of class EvMouseMove" then return end
	print("Got event: " .. tostring(e))
end

------------------------------ Getters / Setters ------------------------------

return DummyObject