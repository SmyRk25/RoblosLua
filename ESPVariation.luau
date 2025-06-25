local Players:Players = game:GetService("Players")
local LocalPlayer:Player = Players.LocalPlayer

local function isAlive(v:Player):boolean
    local char:Model? = v.Character
    if v and char and char:FindFirstChild("Humanoid") then
        local Humanoid:Humanoid? = char:FindFirstChild("Humanoid") ::Humanoid?
        if Humanoid and Humanoid.Health > 0 then
            return true;
        end;
    end
    return false;
end;

local function sameTeam(v:Player):boolean
    if v.Team == LocalPlayer.Team then
        return true
    end;
    return false;
end;

local function addHighlight(v:Player)
    local char:Model? = v.Character ::Model?;
    if char then
	local highlight:Highlight = Instance.new("Highlight", char)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
	print("Highlight Added")
    end;
end

local function addSubjectGUI(v:Player)
    local char:Model? = v.Character;
    if char then
	local Head:Instance? = char:FindFirstChild("Head")
	local GUI:BillboardGui = Instance.new("BillboardGui", Head)
	local Text:TextLabel = Instance.new("TextLabel", GUI)
	GUI.AlwaysOnTop = true;
	GUI.Size = UDim2.new(10,0,2.5,0)
	GUI.StudsOffset = Vector3.new(0,2,0)
	Text.Text = v.Name;
	Text.Size = UDim2.new(1,0,1,0);
	Text.TextColor3 = Color3.new(0,255,0);
	Text.TextSize = 50;
	Text.BackgroundTransparency = 1;
	Text.TextScaled = true;
	Text.TextWrapped = true;
	Text.BackgroundTransparency = 1;
    end;
end

local function addEsp(v:Player)
    if not v then return end;
    if v == LocalPlayer then return end;
    if not isAlive(v) then return end;
    if sameTeam(v) then return end;
    if not v.Character then return end;
    if not v.Character:FindFirstChild("Head") then return end;
    local Head = v.Character:FindFirstChild("Head");
    if not Head:FindFirstChild("BillboardGui") then return end;
    local Highlight = v.Character:FindFirstChild("Highlight");
    if not Highlight then return end;
    addHighlight(v)
    addSubjectGUI(v)
end

for i, v in pairs(Players:GetPlayers()) do
    addEsp(v)
end

for i, v in pairs(Players:GetPlayers()) do
    v.CharacterAdded:Connect(function()
        addEsp(v);
    end)
    v.CharacterRemoving:Connect(function()
        addEsp(v);
    end)
end

Players.PlayerAdded:Connect(function(Plr:Player)
    Plr.CharacterAdded:Connect(function()  
        addEsp(Plr);
    end)
    Plr.CharacterRemoving:Connect(function()  
        addEsp(Plr);
    end)
end)