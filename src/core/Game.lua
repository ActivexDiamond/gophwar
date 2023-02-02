local middleclass = require "libs.middleclass"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local Game = middleclass("Game")
function Game:initialize(title, targetWindowW, targetWindowH)
	self.TITLE = title
	self.WINDOW_W, self.WINDOW_H = love.window.setMode(targetWindowW,
			targetWindowH)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return Game