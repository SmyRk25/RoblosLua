local function genSoundOnPart(part: Part)
	return {
	    ["volume_adjust"] = math.huge,
	    ["directory"] = {
		[1] = "terrors",
		[2] = "bloom",
		--[3] = "Laugh"
	    },
	    ["pitch_adjust"] = 99,
	    ["location"] = part,
	    ["soundfile"] = "screech",
	    ["pitchvariation"] = 99,
	}
end


while task.wait(0.25) do
    pcall(function()
    	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    		workspace.mainGame.remotes.audio_relay:FireServer(genSoundOnPart(v.Character.HumanoidRootPart))
    	end
	end)
end
