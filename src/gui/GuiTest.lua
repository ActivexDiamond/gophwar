local middleclass = require "libs.middleclass"
local AGuiManager = require "gui.AGuiManager"

------------------------------ Helpers ------------------------------
local function centerRectOnScreen(w, h)
    local x = math.floor((love.graphics.getWidth() - w) / 2)
    local y = math.floor((love.graphics.getHeight() - h) / 2)
    return x, y
end

    
------------------------------ Constructor ------------------------------
local GuiTest = middleclass("GuiTest", AGuiManager)
function GuiTest:initialize(...)
	AGuiManager.initialize(self, ...)
    local W, H = 400, 80  -- pick arbitrary UI size
    local x, y = centerRectOnScreen(W, H)
    
	local Ui = self.yui.Ui
	local Rows = self.yui.Rows
	local Button, Label = self.yui.Button, self.yui.Label
    print("gui ", self.gui)
    self.gui = self.yui.Ui:new {
        x = x, y = y,

        Rows {
            Label {
                w = W, h = H,

                text = "Hello, World!"
            },
            Button {
                text = "OBEY",
                onHit = function () love.event.quit() end
            }
        }
    }	
    print("gui ", self.gui)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GuiTest