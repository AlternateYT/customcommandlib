local MainGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Shading = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local SearchBar = Instance.new("TextBox")
local UIPadding_2 = Instance.new("UIPadding")
local CommandList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Command = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")

MainGui.Name = ""
MainGui.Parent = game:GetService("CoreGui")
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.423645318, 0, 0.253583252, 0)
MainFrame.Size = UDim2.new(0, 340, 0, 447)

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(170, 255, 255)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 340, 0, 53)

Shading.Name = "Shading"
Shading.Parent = TopBar
Shading.BackgroundColor3 = Color3.fromRGB(130, 215, 215)
Shading.BorderSizePixel = 0
Shading.Position = UDim2.new(0, 0, 0.620995283, 0)
Shading.Size = UDim2.new(0, 340, 0, 20)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(0, 340, 0, 52)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Custom Commands v1.00"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UIPadding.Parent = Title
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)

SearchBar.Name = "SearchBar"
SearchBar.Parent = MainFrame
SearchBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SearchBar.BorderSizePixel = 0
SearchBar.Position = UDim2.new(0, 0, 0.118568234, 0)
SearchBar.Size = UDim2.new(0, 340, 0, 37)
SearchBar.Font = Enum.Font.SourceSansBold
SearchBar.PlaceholderText = "Search..."
SearchBar.Text = ""
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.TextScaled = true
SearchBar.TextSize = 14.000
SearchBar.TextWrapped = true
SearchBar.TextXAlignment = Enum.TextXAlignment.Left

UIPadding_2.Parent = SearchBar
UIPadding_2.PaddingBottom = UDim.new(0, 5)
UIPadding_2.PaddingLeft = UDim.new(0, 5)
UIPadding_2.PaddingRight = UDim.new(0, 5)
UIPadding_2.PaddingTop = UDim.new(0, 5)

CommandList.Name = "CommandList"
CommandList.Parent = MainFrame
CommandList.Active = true
CommandList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CommandList.BackgroundTransparency = 1.000
CommandList.BorderSizePixel = 0
CommandList.Position = UDim2.new(0, 0, 0.201342285, 0)
CommandList.Size = UDim2.new(0, 340, 0, 357)
CommandList.CanvasSize = UDim2.new(0, 0, 0, 0)

UIListLayout.Parent = CommandList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Command.Name = "Command"
Command.Parent = script
Command.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Command.BackgroundTransparency = 1.000
Command.Size = UDim2.new(0, 340, 0, 35)
Command.Font = Enum.Font.SourceSansSemibold
Command.Text = ":template - Command template"
Command.TextColor3 = Color3.fromRGB(255, 255, 255)
Command.TextScaled = true
Command.TextSize = 14.000
Command.TextWrapped = true

UIPadding_3.Parent = Command
UIPadding_3.PaddingBottom = UDim.new(0, 5)
UIPadding_3.PaddingLeft = UDim.new(0, 5)
UIPadding_3.PaddingRight = UDim.new(0, 5)
UIPadding_3.PaddingTop = UDim.new(0, 5)

local lib = {}
lib.currentPrefix = ":"

lib.setPrefix = function(prefix)
	local success, response = pcall(function()
		lib.currentPrefix = tostring(prefix)
		return tostring(lib.currentPrefix)
	end)
	if not success then
		error("lib.setPrefix failed: "..response)
	end
end

lib.createCommand = function(name, description)
	local success, response = pcall(function()
		
		if not string.match(tostring(name), "^%s*$") then
		
			local cmdName = (tostring(lib.currentPrefix)..tostring(name).." - "..tostring(description))
			local splitCmdName = string.split(cmdName, " - ") -- [1] = cmd, [2] = desc 
			
			local newCommand = Command:Clone()
			newCommand.Name = splitCmdName[1]:gsub(" ", "")
			newCommand.Text = cmdName
			newCommand.Parent = CommandList
			
			return newCommand
			
		end

	end)
	if not success then
		error("lib.createCommand failed: "..response)
	end
end

lib.getCommands = function()
	local success, response = pcall(function()
		
		local children = {}
		
		for _, cmd in pairs(CommandList:GetChildren()) do
			if cmd:IsA("TextLabel") then
				children[#children+1] = cmd
			end
		end
		
		return children
		
	end)
	if not success then
		error("lib.returnCommands failed: "..response)
	end
end

return lib
