local Players = game:GetService("Players")

local function genSoundOnPart(part: Part)
    return {
        ["volume_adjust"] = 8,
        ["directory"] = {
            [1] = "voices",
            --[2] = "atgrenade"
        },
        ["location"] = part,
        ["soundfile"] = "f_rare8",
        ["pitchvariation"] = 0.1,
        }
end


while task.wait() do
    for i,v in pairs(Players:GetPlayers()) do
        if v == Players.LocalPlayer then continue end
        pcall(function()

            workspace.remotes.audio_relay:FireServer(genSoundOnPart(v.Character.HumanoidRootPart))
        end)
        task.wait(0.05)
    end
end