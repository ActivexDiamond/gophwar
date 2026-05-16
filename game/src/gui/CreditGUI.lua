local middleclass = require "libs.middleclass"
local AGuiManager = require "gui.AGuiManager"

------------------------------ Helpers ------------------------------
local function centerRectOnScreen(w, h)
    local x = math.floor((love.graphics.getWidth() - w) / 2)
    local y = math.floor((love.graphics.getHeight() - h) / 2)
    return x, y
end

------------------------------ Constructor ------------------------------
local GuiTest = middleclass("GuiCredit", AGuiManager)
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
                w = w, h = 60,
                text = "GophWar",
            },
            Rows {
                Label {
                    w = w, h = 60,
                    text = "Game Design"
                },
                Columns {
                    padding = 4,
                    Label {
                        w = 133, h = 60,
                        text = "Dulfiqar 'Active Diamond' H. Al-Safi"
                    },
                    Label {
                        w = 133, h = 60,
                        text = "Thatvampigoddess (aka Joker)"
                    },
                    Label {
                        w = 133, h = 60,
                        text = "Mouamle H. Hameed"
                    }
                },
                Label {
                    w = w, h = 60,
                    text = "Development"
                },
                Columns {
                    padding = 4,
                    Label {
                        w = 200, h = 60,
                        text = "Dulfiqar 'Active Diamond' H. Al-Safi"
                    },
                    Label {
                        w = 200, h = 60,
                        text = "Mouamle H. Hameed"
                    }
                },
                Label {
                    w = w, h = 60,
                    text = "Art & Sound Design"
                },
                Columns {
                    padding = 4,
                    Label {
                        w = 400, h = 60,
                        text = "Thatvampigoddess (aka Joker)"
                    },
                },
                Label {
                    w = w, h = 60,
                    text = "Testing"
                },
                Columns {
                    padding = 4,
                    Label {
                        w = 400, h = 60,
                        text = "Saffi"
                    },
                }
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

return GuiTest