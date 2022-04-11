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
local plr = game:GetService("Players").LocalPlayer

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

local destroyGui = Command:Clone()
destroyGui.Name = "!destroygui"
destroyGui.Text = "!destroygui - Destroy's the gui"
destroyGui.Parent = CommandList

UIPadding_3.Parent = Command
UIPadding_3.PaddingBottom = UDim.new(0, 5)
UIPadding_3.PaddingLeft = UDim.new(0, 5)
UIPadding_3.PaddingRight = UDim.new(0, 5)
UIPadding_3.PaddingTop = UDim.new(0, 5)

local lib = {}
lib.currentPrefix = ":"
lib.mainGui = MainGui

lib.commands = {}

CommandList.ChildAdded:Connect(function()
	for _, cmd in pairs(CommandList:GetChildren()) do
		if cmd:IsA("TextLabel") then
			if not table.find(lib.commands, cmd) then
				lib.commands[#lib.commands+1] = cmd
			end
		end
	end
end)

CommandList.ChildRemoved:Connect(function(obj)
	if obj == destroyGui then
		local destroyGui = Command:Clone()
		destroyGui.Name = "!destroygui"
		destroyGui.Text = "!destroygui - Destroy's the gui"
		destroyGui.Parent = CommandList
	end
end)

lib.setTitle = function(titleText)
	local success, response = pcall(function()
		Title.Text = tostring(titleText)
	end)
	if not success then
		print("lib.setTitle failed: "..response)
	end
end

lib.setPrefix = function(prefix)
	local success, response = pcall(function()
		lib.currentPrefix = tostring(prefix)
	end)
	if not success then
		error("lib.setPrefix failed: "..response)
	end
end

lib.createCommand = function(name, description)
	local success, response = pcall(function()
		
		if not string.match(tostring(name), "^%s*$") and tostring(name) ~= "destroygui" then
		
			local cmdName = (tostring(lib.currentPrefix)..tostring(name).." - "..tostring(description))
			local splitCmdName = string.split(cmdName, " - ") -- [1] = cmd, [2] = desc 
			
			local newCommand = Command:Clone()
			newCommand.Name = splitCmdName[1]:gsub(" ", "")
			newCommand.Text = cmdName
			newCommand.Parent = CommandList
			
		end

	end)
	if not success then
		error("lib.createCommand failed: "..response)
	end
end

local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService"));

local gui = MainFrame

local dragging
local dragInput
local dragStart
local startPos

function Lerp(a, b, m)
	return a + (b - a) * m
end;

local lastMousePos
local lastGoalPos
local DRAG_SPEED = (8);
function Update(dt)
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end;

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = TopBar.Position --gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)

UserInputService.InputBegan:Connect(function(input, typing)
	if input.KeyCode == Enum.KeyCode.RightShift and not typing then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

function UpdateResults()
	local search = string.lower(SearchBar.Text)
	for i, v in	 pairs(CommandList:GetChildren()) do
		if v:IsA("TextLabel") then
			if not string.match(tostring(SearchBar.Text), "^%s*$") and not string.match(tostring(v.Text), "^%s*$") then
				local item = string.lower(v.Text)
				if string.find(item, search) then
					v.Visible = true
				else
					v.Visible = false
				end
			else
				v.Visible = true
			end
		end
	end
end

SearchBar.Changed:Connect(UpdateResults)

plr.Chatted:Connect(function(msg)
	local cmds = lib.commands
	local prefix = lib.currentPrefix
	for _, cmd in pairs(cmds) do
		cmd = cmd.Name
		local cleanMsg = msg:gsub(' ', '')
		if cleanMsg == cmd then
			if cmd == '!destroygui' then
				MainGui:Destroy()
			end
		end
	end
end)

return lib
