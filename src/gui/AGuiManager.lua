local middleclass = require "libs.middleclass"

local yui = require "libs.yui"

local EventSystem = require "cat-paw.core.patterns.event.EventSystem"

local EvKeyPress = require "cat-paw.core.patterns.event.keyboard.EvKeyPress"
local EvKeyRelease = require "cat-paw.core.patterns.event.keyboard.EvKeyRelease"
local EvTextInput = require "cat-paw.core.patterns.event.keyboard.EvTextInput"
local EvTextEdit = require "cat-paw.core.patterns.event.keyboard.EvTextEdit"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local AGuiManager = middleclass("AGuiManager")
function AGuiManager:initialize()
	assert(self.class ~= AGuiManager, "Cannot init abstract class.")
	GAME:getEventSystem():attach(self, EventSystem.ATTACH_TO_ALL)
	self.yui = yui
end

------------------------------ Core API ------------------------------
function AGuiManager:update(dt)
	self.gui:update(dt)
end

function AGuiManager:draw(g2d)
	self.gui:draw()
end

------------------------------ API ------------------------------

------------------------------ Callbacks ------------------------------
AGuiManager[EvKeyPress] = function(self, e)
	self.gui:keypressed(e.key, e.scancode, e.isrepeat)
end

AGuiManager[EvKeyRelease] = function(self, e)
	self.gui:keyreleased(e.key, e.scancode)
end

AGuiManager[EvTextInput] = function(self, e)
	self.gui:textinput(e.char)
end

AGuiManager[EvTextEdit] = function(self, e)
	self.gui:textinput(e.text, e.start, e.length)
end


return AGuiManager