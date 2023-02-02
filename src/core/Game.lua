local middleclass = require "libs.middleclass"
local AbstractGame = require "core.AbstractGame"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Game = middleclass("Game")
function Game:initialize(...)
	AbstractGame.initialize(self, ...)
	
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Game