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
    local W, H = 400, 100  -- pick arbitrary UI size
    local x, y = centerRectOnScreen(W, H)
    y = 60

	local Ui = self.yui.Ui
	local Rows = self.yui.Rows
	local Button, Label = self.yui.Button, self.yui.Label
    print("gui ", self.gui)
    self.gui = self.yui.Ui:new {
        x = x, y = y,

        Rows {
            padding = 5,
            Label {
                w = W, h = H,
                text = "GophWar",
            },
            Button {
                h = 60,
                text = "Start",
                onHit = function () GAME:goTo(GAME.IN_GAME_SCENE_ID) end
            },
            Button {
                text = "Options",
                onHit = function () GAME:goTo(GAME.OPTIONS_MENU_SCENE_ID) end
            },
            Button {
                text = "Credit",
                onHit = function () GAME:goTo(GAME.CREDIT_MENU_SCENE_ID) end
            },
            Button {
                text = "Tutorial",
                onHit = function () GAME:goTo(GAME.TUTORIAL_MENU_SCENE_ID) end
            },
            Button {
                text = "Test",
                onHit = function () print("Pressed!") end
            },
            Button {
                text = "Exit",
                onHit = function () love.event.quit() end
            },
            Label {
                text = "The UI Might not work sometimes, so you have to press the button multiple times",
            },
        }
    }	
    print("gui ", self.gui)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GuiTest