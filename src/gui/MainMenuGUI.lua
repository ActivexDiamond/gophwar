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
    local w, h = 400, 100  -- pick arbitrary UI size
    local x, y = centerRectOnScreen(w, h)
    y = 60

	local Ui = self.yui.Ui
	local Rows = self.yui.Rows
	local Button, Label, Columns, Checkbox = self.yui.Button, self.yui.Label, self.yui.Columns, self.yui.Checkbox
    print("gui ", self.gui)
    self.gui = self.yui.Ui:new {
        x = x, y = y,

        Rows {
            padding = 5,
            Label {
                w = w, h = h,
                text = "GophWar",
            },
            Button {
                h = 60,
                text = "Start",
                onHit = function ()
                	GAME:remove(GAME.IN_GAME_SCENE_ID) 
                	GAME:add(GAME.IN_GAME_SCENE_ID, InGameScene())
                	GAME:goTo(GAME.IN_GAME_SCENE_ID)
                end
            },
            Button {
                text = "Credit",
                onHit = function () GAME:goTo(GAME.CREDIT_MENU_SCENE_ID) end
            },
            Button {
                text = "Tutorial",
                onHit = function () GAME:goTo(GAME.TUTORIAL_MENU_SCENE_ID) end
            },
            Columns {
                padding = 4,

                Label {
                    w = 300, h = 60,
                    text = "Music"
                },
                Checkbox {
                    w = 100,
                    checked = true,

                    onChange = function(_, checked) print("Checked to " .. tostring(checked)) end
                }
            },
            Button {
                text = "Exit",
                onHit = function () love.event.quit() end
            },
        }
    }	
    print("gui ", self.gui)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return GuiTest