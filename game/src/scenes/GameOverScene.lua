local middleclass = require "libs.middleclass"
local Scene = require "cat-paw-mods.Scene"

local GameOverGUI = require "gui.GameOverGUI"

------------------------------ Helpers ------------------------------

------------------------------ Constructor ------------------------------
local GameOverScene = middleclass("GameOverScreen", Scene)
function GameOverScene:initialize(...)
    Scene.initialize(self, ...)
    self:addObject(GameOverGUI())
end

------------------------------ Core API ------------------------------

function GameOverScene:draw(g2d)
    Scene.draw(self, g2d)

    g2d.push()
    g2d.scale(2)
    g2d.print("Game Over", 100, 100)
    g2d.print("No Time To Center It :c", 100, 120)
    g2d.print("But yes time to restart c:", 100, 140)
    g2d.pop()


end

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GameOverScene