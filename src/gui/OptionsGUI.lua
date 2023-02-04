local middleclass = require "libs.middleclass"
local AGuiManager = require "gui.AGuiManager"

------------------------------ Helpers ------------------------------
local function centerRectOnScreen(w, h)
    local x = math.floor((love.graphics.getWidth() - w) / 2)
    local y = math.floor((love.graphics.getHeight() - h) / 2)
    return x, y
end


------------------------------ Constructor ------------------------------
local GuiTest = middleclass("OptionsGUI", AGuiManager)
function GuiTest:initialize(...)
    AGuiManager.initialize(self, ...)
    local w, h = 400, 100  -- pick arbitrary UI size
    local x, y = centerRectOnScreen(w, h)
    y = 60

    local Ui = self.yui.Ui
    local Rows = self.yui.Rows
    local Button, Label, Slider, Columns = self.yui.Button, self.yui.Label, self.yui.Slider, self.yui.Columns

    print("gui ", self.gui)
    self.gui = self.yui.Ui:new {
        x = x, y = y,
    
        Rows {
            padding = 5,
            Columns {
                padding = 4,
    
                Label {
                    w = w, h = h,
                    text = "Music"
                },
                Slider {
                    min = 0, max = 100,
                    value = 0,
    
                    onChange = function(_, value) print(value)  end
                }
            },
            Button {
                text = "Back",
                onHit = function() GAME:goTo(GAME.MAIN_MENU_SCENE_ID)  end
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