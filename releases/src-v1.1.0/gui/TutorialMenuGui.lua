 middleclass = require "libs.middleclass"
local AGuiManager = require "gui.AGuiManager"

------------------------------ Helpers ------------------------------
local function centerRectOnScreen(w, h)
    local x = math.floor((love.graphics.getWidth() - w) / 2)
    local y = math.floor((love.graphics.getHeight() - h) / 2)
    return x, y
end

------------------------------ Constructor ------------------------------
local TutorialMenuGui = middleclass("TutorialMenuGui", AGuiManager)
function TutorialMenuGui:initialize(...)
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
            padding = 600,
            Rows {
                Label {
                    w = w, h = 60,
                    text = [[The cute chubby gophers are endangering our precious roots. 
                    You as the dryad need to protect our roots from the evil gophers.
                    
                    Left click to shoort arrows.
                    Golpher's drop sticks and essence upon death. Click on the items to pick them up.
                    You inventory is in the bottom right.
                    Your stats are in the bottom left.
                    
                    Next to your inventory is your crafting menu.
                    Right-click on those buttons (with enough resources in inventory) to craft the shown item.
                    You will gain an amount attached to your mouse, right click to place one trap at a time.
                    
                    (the left slot)  Spikes Tier 1: Base Essence x2 + Stick x5
                    (the right slot) Spikes Tier 2: Chonky Essence x2 + Stick x5
                    
                    There are two enemies:
                    Gopher: Average stats. Drops normal essence.
                    Chonky Gopher: Slower, has more health, does more damage. Drops chonky essence.
                    ]]
                },
            },

            Button {
                w = w, h = 60,
                text = "Back",
                onHit = function()
                    GAME:goTo(GAME.MAIN_MENU_SCENE_ID)
                end
            },
        }
    }
    print("gui ", self.gui)
end

------------------------------ Core API ------------------------------

------------------------------ API ------------------------------

------------------------------ Getters / Setters ------------------------------

return TutorialMenuGui