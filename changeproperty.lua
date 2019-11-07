local ChangeProperty = {}

local function ChangeHat()
	--[
	local HatID = TextboxHatID:GetValue()
	if HatID ~= "" then
		local success,Hat = pcall(function()
			local Hat = InsertService:LoadAsset(tonumber(HatID)):FindFirstChildOfClass("Accessory")
			return Hat
		end)
		if success then
			if CurrentHat then
				CurrentHat:Destroy()
			end
			
			CurrentHat = Hat
			CurrentHat.Archivable = false
			CurrentHat.Handle.Locked = true
			CurrentHat.Parent = Folder
			plugin:SetSetting("HatID",HatID)
			CurrentHat.Handle.CFrame = workspace.CurrentCamera.CFrame + Vector3.new(0, plugin:GetSetting("Height"), 0)
			CurrentHat.Handle.LocalTransparencyModifier = plugin:GetSetting("Transparency")
			if CurrentHat.Handle:FindFirstChildOfClass("Attachment") then
				CurrentHat.Handle:FindFirstChildOfClass("Attachment"):Destroy()
			end
		else
			TextboxHatID:SetValue(plugin:GetSetting("HatID"))
		end
	else
		TextboxHatID:SetValue(plugin:GetSetting("HatID"))
	end
	--]]
end

local function ChangeHeight()
	local h = TextboxHeight:GetValue()
	if tonumber(h) and (h ~= "") then
		plugin:SetSetting("Height",TextboxHeight:GetValue())
	else
		TextboxHeight:SetValue(plugin:GetSetting("Height"))
	end
end

local function ChangeTransparency(visible)
	local transparency = visible and 0 or 1
	plugin:SetSetting("Transparency",transparency)
end

return ChangeProperty