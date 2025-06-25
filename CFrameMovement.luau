local UIS:UserInputService = game:GetService("UserInputService");
local Player:Players = game:GetService("Players");
local SpeedIncrease:number = 1;


print("ran1")


function round(n)
	return math.floor(n * 10) / 10
end

local function sendNotif()
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "SpeedIncreaseValue", -- Required
		Text = ("SpeedIncrease " .. round(SpeedIncrease)), -- Required
	})
	--print("ran2");
end


UIS.InputBegan:Connect(function(input:InputObject, processed:boolean)
	if(processed)then
		return
	end
	
	--print(input.KeyCode)
	if(input.KeyCode == Enum.KeyCode.Equals)then
		SpeedIncrease += 0.1;
		if(SpeedIncrease > 1)then
			SpeedIncrease = 1;
		end
		sendNotif();
	end
	
	if(input.KeyCode == Enum.KeyCode.Minus)then
		SpeedIncrease -= 0.1;
		if(SpeedIncrease<0)then
			SpeedIncrease = 0;
		end
		sendNotif();
	end
end)

--pcall(function()
pcall(function()
	while task.wait() do
		if Player.LocalPlayer.Character then
		local HumanoidRootPart = Player.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		print("running");
			if(UIS:IsKeyDown(Enum.KeyCode.LeftShift)) then
				if(UIS:IsKeyDown(Enum.KeyCode.W))then
					HumanoidRootPart.CFrame *= CFrame.new(0,0,-(SpeedIncrease));
					--print("ForwardRunning");
				end
				if(UIS:IsKeyDown(Enum.KeyCode.S))then
					HumanoidRootPart.CFrame *= CFrame.new(0,0,(SpeedIncrease));
					--print("BackwardRunning");
				end
				if(UIS:IsKeyDown(Enum.KeyCode.A)) then
					HumanoidRootPart.CFrame *= CFrame.new(-(SpeedIncrease),0,0);
					--print("StrafingLeft");
				end
				if(UIS:IsKeyDown(Enum.KeyCode.D))then
					HumanoidRootPart.CFrame *= CFrame.new((SpeedIncrease),0,0);
					--print("StrafingRight");
				end
			end
		end
	end
end)