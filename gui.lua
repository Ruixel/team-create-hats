-- handles all guis
local Guis = {}

-- these guis are part of studio
Guis.Toolbar = _G.plugin_990908723:CreateToolbar("Team Create Hats")
Guis.ToggleWindow = Guis.Toolbar:CreateButton("Change Hat", "change hat properties", "rbxassetid://692849427")
Guis.Docket = _G.plugin_990908723:CreateDockWidgetPluginGui(
    "Team Create Hats", 
    DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 200, 150)
)
Guis.Docket.Title = "Team Create Hat Properties"
Guis.ToggleWindow:SetActive(Guis.Docket.Enabled)

Guis.ToggleWindow.Click:Connect(function()
    Guis.Docket.Enabled = not Guis.Docket.Enabled
    Guis.ToggleWindow:SetActive(Guis.Docket.Enabled)
end)

-- these guis are within the docket window
local studioWidgets = require(1638103268)

local LabeledCheckbox = studioWidgets.LabeledCheckbox
local LabeledTextInput = studioWidgets.LabeledTextInput
local CollapsibleTitledSectionClass = studioWidgets.CollapsibleTitledSection
local GuiUtil = studioWidgets.GuiUtilities

local MainSection = CollapsibleTitledSectionClass.new("HatProperties", "Hat Properties", true, true)
MainSection:GetSectionFrame().Parent = Guis.Docket

local Settings = require(script.Parent.settings)

Guis.TextboxHatID         = LabeledTextInput.new("HatID",       "AccessoryId",  tostring(Settings.GetHatId())          )
Guis.TextboxHeight        = LabeledTextInput.new("Height",      "Height",       tostring(Settings.GetHeight())         )
Guis.CheckboxTransparency = LabeledCheckbox.new ("Transparent", "VisibleLocal", (Settings.GetTransparency() == 0), true)
Guis.CheckboxEnabled      = LabeledCheckbox.new ("Enabled",     "Enabled",      Settings.GetEnabled(),             true)

local function SetGuisInSection(objs, section)
	local background = Instance.new("Frame")
	background.BackgroundColor3 = objs[1]:GetFrame().BackgroundColor3
	background.Size = UDim2.new(1, 0, 1, 0)
	background.ZIndex = -10
	background.Parent = Guis.Docket
	GuiUtil.syncGuiElementBackgroundColor(background)

	for i, obj in pairs(objs)do
		local Frame = obj:GetFrame()
		Frame.Position = UDim2.new(0, 0, 0, 30 * (i - 1))
		Frame.Parent = section:GetContentsFrame()
	end
end

SetGuisInSection({Guis.TextboxHatID, Guis.TextboxHeight, Guis.CheckboxTransparency, Guis.CheckboxEnabled}, MainSection)

-- removes everything that isn't a number from a string
function Guis.FilterToWholeNumber(textbox, value)
	textbox:SetValue(value:gsub('%D',''))
end

-- removes everything that isn't a number, -, or . from the string (- is removed if it occurs anywhere other than the beginning)
function Guis.FilterToNumber(textbox, value)
	local NumericString = value:match("%d[%d.]*") or ""
	if value:sub(1,1) == "-" then
		NumericString = "-" .. NumericString
	end
	textbox:SetValue(NumericString)
end

Guis.TextboxHatID:SetValueChangedFunction(function(value)
    Guis.FilterToWholeNumber(Guis.TextboxHatID, value)
end)

Guis.TextboxHeight:SetValueChangedFunction(function(value)
    Guis.FilterToNumber(Guis.TextboxHeight, value)
end)

return Guis