local Player:Players = game:GetService("Players");
local LocalPlayer:Player = Player.LocalPlayer;
local PlayerTarget:Player? = nil;
local teamcheck:boolean = true;
local UIS:UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace")
local Camera:Camera = Workspace.Camera
local RunService = game:GetService("RunService");
local a:RBXScriptConnection;

local function target(): Player?
    local closest_dist: number = math.huge
    local closest: Player? = nil;

	for i, v in pairs(Player:GetChildren()) do
		if v == LocalPlayer then continue end;
		if not v.Character then continue end; --checks if character is in game;
		if not (v.Character:WaitForChild("Humanoid").Health > 0) then continue end; --alive check;
		if teamcheck and v.Team == LocalPlayer.Team then continue end; --team check;
        local HRP:BasePart? = v.Character:FindFirstChild("HumanoidRootPart");
        if not HRP then continue end;
		local Vect, onScreen = Camera:WorldToViewportPoint(HRP.Position);
        if not onScreen then continue end;
		local Test:Vector2 = Vector2.new(Vect.X, Vect.Y);
		local MousePoint:Vector2 = Vector2.new(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y);
		if (MousePoint - Test).Magnitude < closest_dist then
            closest_dist = (MousePoint - Test).Magnitude;
			closest = v;
		end
	end
    return closest;
end

task.spawn(function()
	while wait(1/16) do
		PlayerTarget = target();
	end;
end);

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		if PlayerTarget and PlayerTarget.Character and PlayerTarget.Character:FindFirstChild("Head") then
			a = RunService.RenderStepped:Connect(function(deltaTime: number) 
                local head = PlayerTarget.Character:FindFirstChild("Head") ::BasePart?
				if head then
				Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position)
				end
			end)
		else if PlayerTarget and PlayerTarget.Character then
			a = RunService.RenderStepped:Connect(function(deltaTime: number) 
                local HRP:BasePart? = PlayerTarget.Character:FindFirstChild("HumanoidRootPart") ::BasePart?
				if HRP then
					Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, HRP.Position)
				end
			end)
		end;
		end;
	end;
end);

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		if a then
		a:Disconnect();
		end;
	end;
end);