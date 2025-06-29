local old = nil
local UIS:UserInputService = game:GetService("UserInputService");
local RunService:RunService = game:GetService("RunService");
local a:RBXScriptSignal = nil;
local Workspace:Workspace = game:GetService("Workspace")
local loop:Folder = Workspace.mainGame.active_anomaly;
local camera:Camera = Workspace.CurrentCamera
local FinalTarget:Part? = nil

local function target() :Part
    local closest:number = 99999;
    local target:Part = nil
    for i, v in pairs(loop:GetChildren()) do
        if not v:FindFirstChild("Humanoid") then continue end;
        if v.Humanoid.Health <= 0 then continue end;
        if not v:FindFirstChild("Head") then continue end;
        local Vect, onScreen = camera:WorldToViewportPoint(v.Head.Position)
        local Test:Vector2 = Vector2.new(Vect.X, Vect.Y)
        if not onScreen then continue end;
        local MousePoint:Vector2 = Vector2.new(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y);
        local dist:number = (MousePoint - Test).Magnitude
        if dist < closest then
            closest = dist
            target = v.Head;
        end;
    end
    return target
end;

task.spawn(function()
    while task.wait(0.1) do
        FinalTarget = target()
    end
end)

old = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local namecallmethod = getnamecallmethod()
    
    if not checkcaller() and Self == Workspace and namecallmethod == "FindPartOnRayWithIgnoreList" then
        local oldray = Args[1];
        local newray = Ray.new(oldray.Origin, (oldray.Direction))
        if not FinalTarget then return old(Self,unpack(Args)) end
        newray = Ray.new(oldray.Origin, (FinalTarget.Position - oldray.Origin))

        Args[1] = newray;
    end
    return old(Self, unpack(Args))
end)

print("worked")