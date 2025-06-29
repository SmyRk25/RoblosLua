-- Decompiled with Velocity Script Decompiler
local v_u_1 = workspace
local v_u_2 = game
local v_u_3 = require
local v4 = script
local v_u_5 = v_u_2.Players.LocalPlayer
local _ = v_u_5.Character
local v_u_6 = v_u_2:GetService("RunService").RenderStepped
repeat
    local v_u_7 = v_u_5.Character
    v_u_6:wait()
until v_u_7 ~= nil
local v_u_8 = v_u_1.mainGame.remotes
local v_u_9 = v4.Parent.weapon_assigned.Value
local v_u_10 = v_u_1.CurrentCamera
local v_u_11 = v_u_3(v_u_2.ReplicatedStorage.shared_modules.bFunctions)
local v_u_12 = v_u_3(v_u_2.ReplicatedStorage.shared_modules.baseValues).human
local v_u_13 = v_u_3(v_u_2.ReplicatedStorage.shared_modules.visualEffects)
local v_u_14 = v_u_7:WaitForChild("Humanoid")
local v_u_15 = v_u_2:GetService("UserInputService")
local v_u_16 = v_u_2:GetService("Debris")
local v_u_17 = false
local v_u_18 = v4.Parent
local v19 = Instance.new("BindableEvent")
v19.Name = "refill_ammo"
v19.Parent = v4.Parent
local v_u_20 = Instance.new("BoolValue")
v_u_20.Name = "maxed_ammo"
v_u_20.Value = true
v_u_20.Parent = v19
local v_u_21 = v_u_3(v_u_2.ReplicatedStorage.shared_modules.weaponVisuals)
local v_u_22 = v_u_7:WaitForChild("character_role").Value
local v_u_23 = v_u_5.PlayerGui:WaitForChild("mainGui")
local v_u_24 = v_u_23:FindFirstChild(v_u_22 .. "_frame")
local v25 = v_u_7:WaitForChild("weapons_folder")
v_u_5:GetMouse()
local v_u_26 = v_u_2.ReplicatedStorage.weapon_modules:FindFirstChild(v_u_9) or (v_u_2.ReplicatedStorage.weapon_variants:FindFirstChild(v_u_9) or v_u_2.ReplicatedStorage.weapon_specials:FindFirstChild(v_u_9))
local v_u_27 = v_u_3(v_u_26)
local v_u_28 = {}
local v_u_29 = nil
v_u_8.weapon_handler:FireServer(v_u_9, "spawn")
if v_u_29 == nil then
    local v30 = tick()
    while true do
        v_u_29 = v_u_7:FindFirstChild(v_u_9 .. "_model")
        if tick() - v30 >= 8 and v_u_29 == nil then
            v30 = tick()
            v_u_8.weapon_handler:FireServer(v_u_9, "spawn")
        end
        v_u_6:wait()
        if v_u_29 ~= nil then
            for _, v31 in ipairs(v_u_29:GetDescendants()) do
                if v31:IsA("BasePart") then
                    v_u_11:localizeTransparency(v31)
                end
            end
            goto l8
        end
    end
else
    ::l8::
    local v_u_32 = {}
    if v_u_5.Character:FindFirstChild("player_skills") then
        for _, v33 in ipairs(v_u_5.Character.player_skills:GetChildren()) do
            v_u_32[v33.Name] = v33.Value
        end
    end
    local v_u_34 = {}
    if v_u_5.Character:FindFirstChild("player_specs") then
        for _, v35 in ipairs(v_u_5.Character.player_specs:GetChildren()) do
            v_u_34[v35.Name] = v35.Value
        end
    end
    local v_u_36 = {
        ["spread"] = 0,
        ["recoil"] = 0
    }
    if v_u_32.gun_spread then
        v_u_36.spread = v_u_36.spread + v_u_27.spread * (v_u_32.gun_spread / 100)
    end
    if v_u_32.gun_recoil then
        v_u_36.recoil = v_u_36.recoil + v_u_27.base_recoil * (v_u_32.gun_recoil / 100)
    end
    if v_u_32.pistol_spread and v_u_27.large == false then
        v_u_36.spread = v_u_36.spread + v_u_27.spread * (v_u_32.pistol_spread / 100)
    end
    if v_u_32.pistol_recoil and v_u_27.large == false then
        v_u_36.recoil = v_u_36.recoil + v_u_27.base_recoil * (v_u_32.pistol_recoil / 100)
    end
    local v_u_37 = {}
    local v_u_38 = {}
    local v_u_39 = false
    local v_u_40 = v_u_2:GetService("SoundService").mainSoundGroup
    if v_u_27.large == true then
        local v41 = Instance.new("BoolValue")
        v41.Name = "large"
        v41.Parent = v_u_18
    end
    if v_u_27.equipment == true then
        local v42 = Instance.new("BoolValue")
        v42.Name = "equipment"
        v42.Parent = v_u_18
        if v_u_27.special_attributes.regen == nil then
            local v43 = Instance.new("BoolValue")
            v43.Name = "consumable"
            v43.Parent = v_u_18
        else
            local v44 = Instance.new("BoolValue")
            v44.Name = "tactical"
            v44.Parent = v_u_18
        end
    end
    if v_u_27.special == "melee" then
        local v45 = Instance.new("BoolValue")
        v45.Name = "melee"
        v45.Parent = v_u_18
    end
    if v_u_27.special_attributes.scoped == true then
        local v46 = Instance.new("BoolValue")
        v46.Name = "scope"
        v46.Parent = v_u_18
    end
    local v_u_47 = {
        ["can_deploy"] = true,
        ["deployable"] = false,
        ["pos_deploy"] = CFrame.new(0, 0, 0),
        ["pause_point"] = false,
        ["alt_tick"] = tick()
    }
    function v_u_38.get_current_ui()
        -- upvalues: (ref) v_u_27, (copy) v_u_38, (copy) v_u_24, (copy) v_u_6
        if v_u_27.special_equipment == true then
            return
        elseif v_u_38.inv_gui == nil then
            local v48 = nil
            while true do
                for _, v49 in ipairs(v_u_24.inv:GetChildren()) do
                    if v49:FindFirstChild("assigned") and v49.assigned.Value == v_u_27.name then
                        v48 = v49
                    end
                end
                v_u_6:wait()
                if v48 ~= nil then
                    v_u_38.inv_gui = v48
                    return v48
                end
            end
        else
            return v_u_38.inv_gui
        end
    end
    function v_u_38.update_melee_stam()
        -- upvalues: (copy) v_u_18, (copy) v_u_38
        local v50 = v_u_18:WaitForChild("stamina", 5)
        v_u_38.ammo_frame.stam_reserve.Text = v50.max.Value
        v_u_38.ammo_frame.stam_num.Text = v50.Value .. "/"
        if v_u_18.stamina.Value > 0 then
            local v51 = v50.Value / v50.max.Value
            local v52 = v51 < 0.5 and 0 or -8
            v_u_38.ammo_frame.stambar.bar.Size = UDim2.new(v51, v52, 0, 22)
        else
            v_u_38.ammo_frame.stambar.bar.Size = UDim2.new(0, 0, 0, 22)
        end
    end
    v_u_38.ammo_frame = v_u_24.lower_right.ammo_frame
    if v_u_27.equipment == true then
        v_u_38.ammo_frame = v_u_24.lower_right.usesframe
    end
    if v_u_27.special == "melee" then
        v_u_38.ammo_frame = v_u_24.lower_right.melee_frame
        local v53 = v_u_27.melee_stamina > 0 and v_u_18:WaitForChild("stamina", 5)
        if v53 then
            v53.Changed:Connect(function(_)
                -- upvalues: (ref) v_u_17, (copy) v_u_38
                if v_u_17 == true then
                    v_u_38.update_melee_stam()
                end
            end)
        end
    end
    local function v_u_54()
        -- upvalues: (ref) v_u_29, (copy) v_u_9, (copy) v_u_37, (ref) v_u_7, (copy) v_u_10
        return {
            ["source"] = v_u_29.model:FindFirstChild("parts"),
            ["wep"] = v_u_9,
            ["wep_handler"] = v_u_37,
            ["char"] = v_u_7,
            ["body"] = v_u_29:FindFirstChild("weld"),
            ["campoint"] = v_u_10.CFrame
        }
    end
    local v_u_55 = 0
    local v_u_56 = 1
    local v_u_57 = 1
    for _, v58 in ipairs(v_u_2.ReplicatedStorage.animation_sets:FindFirstChild(v_u_27.animation):GetChildren()) do
        local v59
        if v58:IsA("ObjectValue") then
            v59 = v58.Value
        else
            v59 = v58
        end
        v_u_28[v58.Name] = v_u_14:LoadAnimation(v59)
        v_u_28[v58.Name].KeyframeReached:connect(function(p60)
            -- upvalues: (copy) v_u_28, (copy) v_u_11, (ref) v_u_7, (ref) v_u_29, (copy) v_u_21, (copy) v_u_54
            if p60 == "Stop" then
                v_u_28.equip:AdjustSpeed(0)
            elseif string.sub(p60, 1, 3) == "sfx" then
                v_u_11:soundHandler({
                    ["directory"] = { "weapon_manips" },
                    ["soundfile"] = string.sub(p60, 5, 100),
                    ["location"] = v_u_7.HumanoidRootPart
                })
                if string.sub(p60, 5, 100) == "shell" then
                    v_u_11:soundHandler({
                        ["directory"] = { "weapon_manips" },
                        ["soundfile"] = "shell" .. math.random(1, 4),
                        ["location"] = v_u_7.HumanoidRootPart
                    })
                    return
                end
            elseif string.sub(p60, 1, 3) == "vfx" and v_u_29.model:FindFirstChild("parts") then
                v_u_21.vfx(string.sub(p60, 5, 100), (v_u_54()))
            end
        end)
    end
    if v_u_28.swing1 then
        v_u_28.swing1.Priority = Enum.AnimationPriority.Action2
    end
    if v_u_28.swing2 then
        v_u_28.swing2.Priority = Enum.AnimationPriority.Action2
    end
    for _, v61 in ipairs(v_u_2.ReplicatedStorage.animation_sets.melee_anims:GetChildren()) do
        v_u_28[v61.Name] = v_u_14:LoadAnimation(v61)
    end
    for _, v62 in ipairs(v_u_2.ReplicatedStorage.animation_sets.inspect_anims:GetChildren()) do
        v_u_28[v62.Name] = v_u_14:LoadAnimation(v62)
        v_u_28[v62.Name].KeyframeReached:connect(function(p63)
            -- upvalues: (copy) v_u_11, (ref) v_u_7
            if string.sub(p63, 1, 3) == "sfx" then
                v_u_11:soundHandler({
                    ["directory"] = { "weapon_manips" },
                    ["soundfile"] = string.sub(p63, 5, 100),
                    ["location"] = v_u_7.HumanoidRootPart
                })
            end
        end)
    end
    local v_u_64 = v_u_21.get_info(v_u_9)
    if v_u_27.equipment == true and v_u_27.special_attributes.place_deployable == true then
        v_u_47.deployable = true
        v_u_47.can_deploy = false
        v_u_47.holo_obj = nil
        function v_u_47.create_holo()
            -- upvalues: (copy) v_u_47, (copy) v_u_2, (copy) v_u_9, (copy) v_u_10, (copy) v_u_1, (copy) v_u_11, (ref) v_u_7, (copy) v_u_6, (ref) v_u_17, (copy) v_u_14
            v_u_47.pos_deploy = CFrame.new(0, 0, 0)
            v_u_47.pause_point = false
            local v65 = v_u_2.ReplicatedStorage.deployables:FindFirstChild(v_u_9)
            if v65 then
                v_u_47.holo_obj = v65:Clone()
                v_u_47.holo_obj.Parent = v_u_10
                if v_u_47.holo_obj:FindFirstChild("place") then
                    v_u_47.holo_obj.PrimaryPart = v_u_47.holo_obj.place
                end
                local v_u_66 = {
                    v_u_47.holo_obj,
                    v_u_1.mainGame.noTarget,
                    v_u_1.mainGame.active_anomaly,
                    v_u_1.mainGame.active_humans,
                    v_u_1.mainGame.active_squads,
                    v_u_1.mainGame.active_bodies,
                    v_u_1.mainGame.active_equipments
                }
                for _, v67 in ipairs(v_u_47.holo_obj:GetDescendants()) do
                    if v67:IsA("BasePart") and v67.Transparency ~= 1 then
                        v67.Material = "Neon"
                        v67.Transparency = 0.5
                        v67.CanCollide = false
                        v67.Anchored = true
                        v67.BrickColor = BrickColor.new("Crimson")
                    elseif v67 ~= v_u_47.holo_obj.PrimaryPart and not v67:IsA("Model") then
                        v67:Destroy()
                    end
                end
                v_u_11:fast_spawn(function()
                    -- upvalues: (ref) v_u_47, (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (copy) v_u_66, (ref) v_u_7, (ref) v_u_6, (ref) v_u_17, (ref) v_u_14
                    while true do
                        v_u_47.can_deploy = false
                        if v_u_9 == "mine" or v_u_9 == "camera" then
                            local v68, v69, v70 = v_u_11:raycastline({
                                ["point"] = v_u_10.CFrame.p,
                                ["destination"] = v_u_10.CFrame.LookVector,
                                ["range"] = 7,
                                ["layermask"] = v_u_66
                            })
                            if v68 then
                                v_u_47.pos_deploy = CFrame.new(v69, v69 + v70)
                                v_u_47.can_deploy = true
                            else
                                v_u_47.pos_deploy = CFrame.new(v69)
                            end
                        elseif v_u_9 == "sentry" or (v_u_9 == "plate" or (v_u_9 == "ammocrate" or v_u_9 == "medcrate")) then
                            local v71 = v_u_11:raycastline({
                                ["point"] = v_u_7.HumanoidRootPart.Position + v_u_7.HumanoidRootPart.CFrame.lookVector * 3,
                                ["destination"] = -v_u_7.HumanoidRootPart.CFrame.upVector,
                                ["range"] = 4,
                                ["layermask"] = v_u_66
                            })
                            local v72 = v_u_11:raycastline({
                                ["point"] = v_u_7.HumanoidRootPart.Position,
                                ["destination"] = v_u_7.HumanoidRootPart.CFrame.lookVector,
                                ["range"] = 3,
                                ["layermask"] = v_u_66
                            })
                            v_u_47.pos_deploy = v_u_7.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) + v_u_7.HumanoidRootPart.CFrame.lookVector * 3
                            if v71 and v72 == nil then
                                v_u_47.can_deploy = true
                            end
                        end
                        if v_u_47.holo_obj then
                            for _, v73 in ipairs(v_u_47.holo_obj:GetDescendants()) do
                                if v73:IsA("BasePart") then
                                    if v_u_47.can_deploy == true or v_u_47.pause_point == true then
                                        v73.BrickColor = BrickColor.new("Bright green")
                                    else
                                        v73.BrickColor = BrickColor.new("Crimson")
                                    end
                                end
                            end
                            if v_u_47.pause_point == false and (v_u_47.holo_obj and v_u_47.holo_obj.PrimaryPart) then
                                v_u_47.holo_obj:SetPrimaryPartCFrame(v_u_47.pos_deploy)
                            end
                        end
                        v_u_6:wait()
                        if v_u_17 == false or v_u_14.Health <= 0 then
                            if v_u_47.holo_obj then
                                v_u_47.holo_obj:Destroy()
                            end
                            return
                        end
                    end
                end)
            end
        end
    end
    v_u_47.alt_equipment = {
        ["medic"] = function()
            -- upvalues: (ref) v_u_7, (copy) v_u_37, (copy) v_u_14, (copy) v_u_28, (ref) v_u_27, (copy) v_u_11, (copy) v_u_6, (ref) v_u_17, (copy) v_u_13, (ref) v_u_29, (copy) v_u_8, (copy) v_u_34, (copy) v_u_38
            if v_u_7.actionBlock.Value == true or v_u_37.current_magazine <= 0 then
                return
            end
            if v_u_7.reloadBlock.Value == true then
                return
            end
            if v_u_7:FindFirstChild("Torso") and v_u_7.Torso:FindFirstChild("sword_buff") then
                return
            end
            if v_u_14.Health == v_u_14.MaxHealth then
                return
            end
            v_u_7.actionBlock.Value = true
            v_u_28.self_inject:Play(0.05, 1, 1)
            local v74 = tick()
            delay(0.1, function()
                -- upvalues: (ref) v_u_27, (ref) v_u_11, (ref) v_u_7
                if v_u_27.special_attributes.quiet_equipment == nil then
                    v_u_11:soundHandler({
                        ["directory"] = { "weapons", v_u_27.firing_sound },
                        ["soundfile"] = "use",
                        ["location"] = v_u_7.Head
                    })
                end
            end)
            local v75 = true
            while true do
                v_u_6:wait()
                if v_u_17 == false then
                    v_u_7.actionBlock.Value = false
                    v75 = false
                    break
                end
                if tick() - v74 >= 0.8 then
                    break
                end
            end
            if v75 == true then
                v_u_13("muzzle_flash_general", {
                    ["source"] = v_u_29.model.smoke.Position,
                    ["suppressed"] = true,
                    ["caliber"] = "large"
                })
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "done",
                    ["location"] = v_u_7.Head
                })
                if v_u_14.Health < v_u_14.MaxHealth then
                    v_u_8.game_handler:FireServer("medic_selfheal")
                    v_u_37.current_magazine = v_u_37.current_magazine - 1
                    if v_u_34.medic_selfhealmovement then
                        if v_u_7.player_skills:FindFirstChild("medic_movementbuff") then
                            v_u_7.player_skills.medic_movementbuff.Value = true
                        else
                            local v_u_76 = Instance.new("BoolValue")
                            v_u_76.Name = "medic_movementbuff"
                            v_u_76.Value = false
                            v_u_76.Parent = v_u_7.player_skills
                            v_u_14.WalkSpeed = v_u_14.WalkSpeed + v_u_34.medic_selfhealmovement
                            local v_u_77 = tick()
                            spawn(function()
                                -- upvalues: (ref) v_u_6, (copy) v_u_76, (ref) v_u_14, (ref) v_u_77, (ref) v_u_34
                                while true do
                                    v_u_6:wait()
                                    if v_u_76 == nil then
                                        break
                                    end
                                    if v_u_14.Health <= 0 then
                                        return
                                    end
                                    if v_u_76.Value == true then
                                        v_u_76.Value = false
                                        v_u_77 = tick()
                                    end
                                    if tick() - v_u_77 >= 10 then
                                        v_u_76:Destroy()
                                        v_u_14.WalkSpeed = v_u_14.WalkSpeed - v_u_34.medic_selfhealmovement
                                        return
                                    end
                                end
                            end)
                        end
                    end
                end
                local v78 = v_u_38.ammo_frame.main
                local v79 = v_u_37.current_magazine
                v78.Text = tostring(v79)
                if v_u_37.current_magazine <= 0 and v_u_27.special_equipment ~= true then
                    v_u_38.get_current_ui().item.TextColor3 = Color3.new(1, 0, 0)
                end
                local v80 = tick()
                while true do
                    v_u_6:wait()
                    if v_u_17 == false then
                        v_u_7.actionBlock.Value = false
                        break
                    end
                    if tick() - v80 >= 2 or v_u_28.self_inject.isPlaying == false then
                        break
                    end
                end
                v_u_37.handle_equipment_swap()
                v_u_7.actionBlock.Value = false
                v_u_28.self_inject:Stop(0.4, 1, 1)
            end
        end,
        ["sword"] = function()
            -- upvalues: (ref) v_u_7, (copy) v_u_8, (copy) v_u_9, (ref) v_u_27
            if v_u_7:FindFirstChild("Torso") and (v_u_7:FindFirstChild("Torso"):FindFirstChild("sword_buff") == nil and v_u_7:FindFirstChild("Head"):FindFirstChild("sword_buff") == nil) then
                v_u_8.client_effect:Fire(v_u_9, v_u_27)
            end
        end
    }
    local v_u_81 = {
        v_u_1.mainGame.noTarget,
        v_u_7,
        v_u_1.mainGame.active_equipments,
        v_u_1.mainGame.active_bodies
    }
    local v_u_82 = v_u_27.fire_rate
    v_u_37.weapon_max_magazine = v_u_27.magazine
    v_u_37.current_magazine = v_u_37.weapon_max_magazine
    local v83 = v25.spares.Value
    if v_u_27.equipment == false and v_u_27.large == false then
        v83 = v83 + 1
    end
    if v_u_27.special_attributes.spare_modifier then
        v83 = v83 + v_u_27.special_attributes.spare_modifier
    end
    if v_u_32.pistol_sparemags and (v_u_27.large == false and v_u_27.special ~= "melee") then
        v83 = v83 + v_u_32.pistol_sparemags
    end
    local v84 = math.clamp(v83, 0, 100)
    v_u_37.weapon_reserve_max = 1 * v84
    if v_u_27.single_load == true then
        v_u_37.weapon_reserve_max = v_u_27.magazine * v84
    end
    v_u_37.reserve_ammo = v_u_37.weapon_reserve_max
    if v_u_27.equipment == true then
        local v85 = v25:WaitForChild(v_u_9)
        v_u_37.weapon_reserve_max = v85.max.Value
        v_u_37.current_magazine = v85.Value
        local v86 = v_u_38.ammo_frame.main
        local v87 = v_u_37.current_magazine
        v86.Text = tostring(v87)
        v85.Changed:Connect(function(p88)
            -- upvalues: (copy) v_u_37, (copy) v_u_38, (ref) v_u_27, (copy) v_u_22
            v_u_37.current_magazine = p88
            local v89 = v_u_38.ammo_frame.main
            local v90 = v_u_37.current_magazine
            v89.Text = tostring(v90)
            if v_u_27.special_equipment ~= true then
                if v_u_37.current_magazine > 0 then
                    v_u_38.get_current_ui().item.TextColor3 = Color3.new(1, 1, 1)
                    if v_u_22 == "anomaly" then
                        v_u_38.get_current_ui().item.TextColor3 = Color3.new(0, 0, 0)
                        return
                    end
                else
                    v_u_38.get_current_ui().item.TextColor3 = Color3.new(1, 0, 0)
                end
            end
        end)
        v85.max.Changed:Connect(function(p91)
            -- upvalues: (copy) v_u_37
            v_u_37.weapon_reserve_max = p91
        end)
    elseif v_u_38.ammo_frame:FindFirstChild("reserve") then
        local v92 = v_u_38.ammo_frame.reserve
        local v93 = v_u_37.reserve_ammo
        v92.Text = tostring(v93)
    end
    local v_u_94 = v_u_7:WaitForChild("actionBlock")
    local v_u_95 = v_u_7:WaitForChild("sprintBlock")
    local v_u_96 = v_u_95:WaitForChild("passer")
    local v_u_97 = v_u_7:WaitForChild("reloadBlock")
    local v_u_98 = v_u_7:WaitForChild("braceBlock")
    local v_u_99 = v_u_7:WaitForChild("aimTimer")
    local v_u_100 = 0
    local function v_u_109(p101, p102, p103)
        -- upvalues: (ref) v_u_7, (copy) v_u_13, (copy) v_u_5, (copy) v_u_98, (copy) v_u_11, (ref) v_u_27, (copy) v_u_8, (copy) v_u_26
        local v104 = p101.Parent == v_u_7.Parent and true or p101:FindFirstChild("invuln")
        if p102 ~= nil and (tick() - 0 > 0.1 and p101:FindFirstChild("invuln") == nil) then
            v_u_13("blood", {
                ["position"] = p102
            })
        end
        if not v104 then
            local v105 = (v_u_5.Character.HumanoidRootPart.Position - p101.HumanoidRootPart.Position).magnitude
            if p103 == nil then
                p103 = {
                    ["distance"] = v105,
                    ["aiming"] = v_u_98.Value
                }
            else
                p103.distance = v105
                p103.aiming = v_u_98.Value
            end
            local v106, v107 = v_u_11:get_damage_total(v_u_7, v_u_27, p103, p101)
            local v108 = (v106 == v_u_27.falloff_damage or v107 == true) and "falloff" or nil
            v_u_8.damage_handler:FireServer(p101, v_u_26, p103, v_u_27)
            if p101.Humanoid:FindFirstChild("effectiveHP") and (p101.Humanoid.effectiveHP.Value > 0 and (p101.Humanoid:FindFirstChild("boss") == nil and p101:FindFirstChild("invuln") == nil)) then
                if p101.Humanoid.effectiveHP.Value - v106 <= 0 then
                    _G.hitmarker("kill", p101.Name)
                    v_u_13("enemy_death", {
                        ["char"] = p101
                    }, true)
                else
                    p101.Humanoid.effectiveHP.Value = p101.Humanoid.effectiveHP.Value - v106
                    _G.hitmarker(v108)
                end
            end
            _G.hitmarker(v108)
        end
    end
    local function v_u_127(p110, p_u_111)
        -- upvalues: (ref) v_u_27, (copy) v_u_36, (copy) v_u_98, (copy) v_u_99, (copy) v_u_32, (copy) v_u_11, (copy) v_u_81, (ref) v_u_7, (copy) v_u_13, (copy) v_u_109
        local v112 = v_u_27.pellets > 2 and 0 or v_u_36.spread
        local v113 = v_u_27.spread - v112
        local v114 = math.clamp(v113, 1, 100) / 5
        if v_u_98.Value == true then
            if v_u_27.special_attributes.full_acc_aimed == true then
                v114 = ((not v_u_27.special_attributes.aimed_acc_wait or tick() - v_u_99.Value >= v_u_27.special_attributes.aimed_acc_wait) and true or false) == true and 0 or v114
            end
            v114 = v_u_32.pinpoint_aiming and v_u_27.pellets == 1 and 0 or v114
        end
        local v115 = math.random(-v114, v114)
        local v116 = math.rad(v115)
        local v117 = math.random(-v114, v114)
        local v118 = math.rad(v117)
        local v119 = math.random(-v114, v114)
        local v120 = math.rad(v119)
        local v121 = Vector3.new(v116, v118, v120)
        local v_u_122, v_u_123 = v_u_11:raycastline({
            ["point"] = p110.p,
            ["destination"] = p110.LookVector + v121,
            ["range"] = 100000,
            ["layermask"] = v_u_81
        })
        v_u_11:fast_spawn(function()
            -- upvalues: (ref) v_u_27, (ref) v_u_7, (ref) v_u_13, (copy) p_u_111, (copy) v_u_123
            local v124 = v_u_27.special
            local v125 = v_u_7.player_skills:FindFirstChild("incendiary_bullets") and "incendiary" or v124
            v_u_13("bullet_trail", {
                ["source"] = p_u_111.model.parts.muzzle.Position,
                ["damage"] = v_u_27.damage,
                ["endpoint"] = v_u_123,
                ["char"] = v_u_7,
                ["suppressed"] = v125
            })
        end)
        local v126
        if v_u_27.special_attributes and v_u_27.special_attributes.pepperball == true then
            v126 = false
            v_u_11:fast_spawn(function()
                -- upvalues: (ref) v_u_13, (copy) p_u_111, (copy) v_u_123
                v_u_13("pepper_trail", {
                    ["source"] = p_u_111.model.parts.muzzle.Position,
                    ["endpoint"] = v_u_123
                })
            end)
            if v_u_7.player_skills:FindFirstChild("fire_pepperballs") then
                v_u_13("impact_incendiary", {
                    ["impactpoint"] = v_u_123
                })
            end
        else
            v126 = true
        end
        if v_u_122 then
            if v_u_122.Name == "Handle" then
                v_u_122 = v_u_122.Parent
            end
            if v_u_122.Name ~= "armour" and (v_u_122.Parent and v_u_122.Parent.Name == "piece") then
                v_u_122 = v_u_122.Parent.Parent
            end
            if v_u_122.Name == "piece" then
                v_u_122 = v_u_122.Parent
            end
            if v_u_7.player_skills:FindFirstChild("ap_rounds") and (v_u_122.Name == "armour" and (v_u_122.Parent and v_u_122.Parent.Name == "piece")) then
                v_u_13("impact_wall_bullet", {
                    ["impactpoint"] = v_u_123,
                    ["weapon_used"] = v_u_27.animation
                })
                v_u_122 = v_u_122.Parent.Parent
            end
            if v_u_122.Parent:FindFirstChild("Humanoid") and (v_u_122.Parent:FindFirstChild("HumanoidRootPart") and v_u_122.Parent:FindFirstChild("Humanoid").Health > 0) then
                v_u_109(v_u_122.Parent, v_u_123, {
                    ["spread_of_shot"] = v114,
                    ["part_that_hit"] = v_u_122
                })
            elseif v126 == true then
                v_u_11:fast_spawn(function()
                    -- upvalues: (ref) v_u_7, (ref) v_u_13, (copy) v_u_123, (ref) v_u_27, (ref) v_u_122
                    if v_u_7.player_skills:FindFirstChild("incendiary_bullets") then
                        v_u_13("impact_incendiary", {
                            ["impactpoint"] = v_u_123
                        })
                    end
                    v_u_13("impact_wall_bullet", {
                        ["impactpoint"] = v_u_123,
                        ["weapon_used"] = v_u_27.animation
                    })
                    if v_u_122.Name == "armour" then
                        v_u_13("impact_ricochet", {
                            ["impactpoint"] = v_u_123,
                            ["weapon_used"] = v_u_27.animation
                        })
                        _G.hitmarker("armour")
                    end
                end)
            end
        end
    end
    local function v_u_142(p128)
        -- upvalues: (copy) v_u_94, (ref) v_u_27, (copy) v_u_10, (copy) v_u_1, (ref) v_u_7, (copy) v_u_11, (copy) v_u_8, (copy) v_u_22, (copy) v_u_109, (copy) v_u_18, (copy) v_u_9
        if v_u_94.Value == true then
            return
        end
        local v129 = v_u_27.melee_range
        local v130 = v_u_10.CFrame + v_u_10.CFrame.lookVector * v129
        if v_u_27.special_attributes.hidden == true then
            local v131 = { v_u_1.mainGame.noTarget, v_u_7, v_u_1.mainGame.active_equipments }
            local v132, _ = v_u_11:raycastline({
                ["point"] = v_u_10.CFrame.p,
                ["destination"] = v_u_10.CFrame.LookVector,
                ["range"] = 8,
                ["layermask"] = v131
            })
            if v132 and (v132.Parent and (v132.Parent.Name == "body" and v132.Parent.Parent == v_u_1.mainGame.active_bodies)) then
                v_u_11:soundHandler({
                    ["directory"] = { "anomaly_sounds" },
                    ["soundfile"] = "eat",
                    ["location"] = v_u_7.Head
                }, true)
                v_u_8.game_handler:FireServer("eat_body", {
                    ["body"] = v132.Parent
                })
            end
        end
        local v133 = nil
        local v134 = v_u_1.mainGame.active_humans:GetChildren()
        if v_u_22 == "human" then
            v134 = v_u_1.mainGame.active_anomaly:GetChildren()
        end
        for _, v135 in ipairs(v_u_1.mainGame.active_squads:GetChildren()) do
            table.insert(v134, v135)
        end
        for _, v136 in ipairs(v134) do
            if v136:FindFirstChild("HumanoidRootPart") and (v136:FindFirstChild("Humanoid") and (v136 ~= v_u_7 and (v136.HumanoidRootPart.Position - v130.p).magnitude <= v129)) then
                v133 = v136
                break
            end
        end
        if v133 and v133:FindFirstChild("invis") then
            v133 = nil
        end
        local v137 = { v_u_7, v_u_1.mainGame }
        if v_u_11:raycastline({
            ["point"] = v_u_10.CFrame.p,
            ["destination"] = v_u_10.CFrame.LookVector,
            ["range"] = 5,
            ["layermask"] = v137
        }) then
            v133 = nil
        end
        local v138
        if v133 and (v133:FindFirstChild("Humanoid") and (v133:FindFirstChild("HumanoidRootPart") and v133:FindFirstChild("Humanoid").Health > 0)) then
            v_u_109(v133, v133.Torso.Position, {
                ["melee_heavied"] = p128
            })
            v138 = true
        else
            v138 = false
        end
        if v138 == false and p128 == true then
            local v139 = v_u_18:FindFirstChild("stamina")
            if v_u_9 ~= "fists" and v139 then
                local v140 = v139.max.Value * 0.15
                local v141 = {
                    ["stamina"] = math.ceil(v140)
                }
                v_u_8.game_handler:FireServer("melee_drain_stamina", v141)
            end
        end
    end
    local v_u_143 = tick()
    function v_u_37.melee_bash()
        -- upvalues: (ref) v_u_55, (copy) v_u_94, (copy) v_u_97, (copy) v_u_96, (ref) v_u_143, (copy) v_u_28, (copy) v_u_2, (ref) v_u_27, (copy) v_u_9, (copy) v_u_5, (copy) v_u_13, (ref) v_u_7, (copy) v_u_11, (copy) v_u_10, (copy) v_u_1, (copy) v_u_8, (copy) v_u_6, (ref) v_u_17
        if tick() - v_u_55 <= 0.5 then
            return
        end
        if v_u_94.Value == true then
            return
        end
        if v_u_97.Value == true then
            return
        end
        v_u_94.Value = true
        v_u_96.Value = true
        v_u_143 = tick()
        if v_u_28.shoot then
            v_u_28.shoot:Stop(0)
        end
        for _, v144 in ipairs(v_u_2.ReplicatedStorage.animation_sets.melee_anims:GetChildren()) do
            if v_u_28[v144.Name] then
                v_u_28[v144.Name]:Stop(0)
            end
        end
        local v145 = v_u_27.equipment == false and v_u_27.special ~= "melee" and (v_u_27.large == false and "melee_small" or "melee_large") or "melee_normal"
        local v146 = v_u_9 == "glauncher" and "melee_large" or v145
        local v147 = v146 .. math.random(1, 2)
        if v_u_9 == "throwaxe" then
            v147 = "melee_small" .. math.random(1, 2)
            v146 = "melee_axe"
        end
        if v_u_5.Backpack:FindFirstChild("K2 Combat Blade") or v_u_9 == "knife" then
            v147 = "melee_knife" .. math.random(1, 2)
            if v_u_9 == "knife" then
                v147 = "melee_small" .. math.random(1, 2)
            else
                v_u_13("quick_knife_melee", {
                    ["character"] = v_u_7
                })
            end
            v146 = "melee_knife"
        end
        if v_u_5.Backpack:FindFirstChild("M2 Stun Baton") or v_u_9 == "baton" then
            v147 = "melee_baton" .. math.random(1, 2)
            if v_u_9 == "baton" then
                v147 = "melee_small" .. math.random(1, 2)
            else
                v_u_13("quick_knife_melee", {
                    ["character"] = v_u_7,
                    ["baton"] = true
                })
            end
            v146 = "melee_baton"
        end
        v_u_28[v147]:Play(0, 1, 1.2)
        local v148 = tick()
        tick()
        v_u_11:soundHandler({
            ["directory"] = { "bash_sounds", "swing" },
            ["soundfile"] = v146 .. math.random(1, 3),
            ["pitchvariation"] = 0.05,
            ["location"] = v_u_7.HumanoidRootPart
        })
        local v149 = false
        while true do
            if tick() - v148 >= 0.1 and v149 == false then
                local v150 = 4
                local v151 = v_u_10.CFrame + v_u_10.CFrame.LookVector * v150
                local v152 = nil
                v149 = true
                for _, v153 in ipairs(v_u_1.mainGame.active_anomaly:GetChildren()) do
                    if v153:FindFirstChild("Torso") and (v153:FindFirstChild("Humanoid") and (v153.Humanoid.Health > 0 and (v151.Position - v153.Torso.Position).magnitude <= v150)) then
                        v150 = (v_u_7.HumanoidRootPart.Position - v153.Torso.Position).magnitude
                        v152 = v153
                    end
                end
                if v152 then
                    v_u_11:soundHandler({
                        ["directory"] = { "bash_sounds", "impact" },
                        ["soundfile"] = v146 .. math.random(1, 3),
                        ["pitchvariation"] = 0.05,
                        ["location"] = v_u_7.HumanoidRootPart
                    })
                    v_u_13("blood", {
                        ["position"] = v152.Head.Position
                    })
                    local v154 = {
                        ["target"] = v152,
                        ["wep"] = v_u_9,
                        ["module"] = v_u_27
                    }
                    v_u_8.game_handler:FireServer("melee_bash", v154)
                    v_u_143 = v_u_143 - 0.2
                end
            end
            v_u_6:wait()
            if tick() - v_u_143 >= 0.75 or v_u_17 == false then
                v_u_96.Value = false
                v_u_94.Value = false
                return
            end
        end
    end
    local v_u_155 = false
    function v_u_37.inspect_anim()
        -- upvalues: (copy) v_u_94, (copy) v_u_97, (ref) v_u_155, (copy) v_u_28, (ref) v_u_27, (copy) v_u_9, (copy) v_u_6, (ref) v_u_17, (copy) v_u_95
        if v_u_94.Value == true then
            return
        elseif v_u_97.Value ~= true and v_u_155 ~= true then
            if v_u_28.shoot then
                v_u_28.shoot:Stop(0)
            end
            v_u_155 = true
            local v156 = v_u_27.equipment == false and v_u_27.special ~= "melee" and (v_u_27.large == false and "inspect_small" or "inspect_large") or "inspect_generic"
            local v157 = (v_u_9 == "plate" or (v_u_9 == "ammobox" or v_u_9 == "ammocrate")) and "inspect_box" or v156
            local v158 = v_u_9 == "glauncher" and "inspect_large" or v157
            local v159 = v_u_9 == "fists" and "inspect_fists" or v158
            v_u_28[v159]:Stop(0)
            v_u_28[v159]:Play(0.3, 1, 1.5)
            repeat
                v_u_6:wait()
            until v_u_28[v159].isPlaying == false or (v_u_17 == false or (v_u_94.Value == true or (v_u_97.Value == true or v_u_95.Value == true)))
            v_u_155 = false
            v_u_28[v159]:Stop(0)
        end
    end
    local v_u_160 = false
    function v_u_37.on_reload()
        -- upvalues: (copy) v_u_94, (copy) v_u_95, (ref) v_u_27, (copy) v_u_64, (copy) v_u_37, (copy) v_u_97, (copy) v_u_28, (copy) v_u_96, (copy) v_u_11, (copy) v_u_32, (copy) v_u_5, (ref) v_u_7, (ref) v_u_160, (copy) v_u_6, (ref) v_u_17, (copy) v_u_38, (copy) v_u_20, (copy) v_u_21, (copy) v_u_54, (ref) v_u_29
        if v_u_94.Value == true then
            return
        end
        if v_u_95.Value == true and v_u_27.special_attributes.sprint_shoot == nil then
            return
        end
        if v_u_27.special == "melee" then
            return
        end
        local v161 = v_u_64.no_chamber == nil and (v_u_27.special_attributes.akimbo == true and 2 or 1) or 0
        if v_u_37.current_magazine == v_u_37.weapon_max_magazine + v161 then
            return
        end
        if v_u_97.Value == true then
            return
        end
        if v_u_37.reserve_ammo <= 0 then
            return
        end
        if v_u_28.reload == nil then
            return
        end
        v_u_28.shoot:Stop(0)
        v_u_97.Value = true
        if v_u_27.special_attributes.sprint_shoot then
            v_u_96.Value = true
        end
        local v162 = v_u_28.reload
        if v_u_28.reload_empty and v_u_37.current_magazine <= 0 then
            v162 = v_u_28.reload_empty
        end
        if v_u_28.reload_specempty and (v_u_37.current_magazine <= 0 and v_u_37.reserve_ammo <= 1) then
            v162 = v_u_28.reload_specempty
        end
        local v163 = v162.Length * v_u_27.reload
        local v164 = math.clamp(v163, 0.1, 20)
        local v165 = 1 / v_u_27.reload
        local v166 = v_u_28.empty.Length * v_u_27.empty_reload
        local v_u_167 = math.clamp(v166, 0.1, 20)
        local v_u_168 = 1 / v_u_27.empty_reload
        local v169
        if v_u_32.standing_reload and v_u_5.Character.HumanoidRootPart.Velocity.magnitude <= 0.1 then
            local v170 = v_u_32.standing_reload
            v164 = v164 - v_u_11:handle_perc(v164, v170)
            v_u_167 = v_u_167 - v_u_11:handle_perc(v_u_167, v170)
            v165 = v165 + v165 * (v170 / 60)
            v_u_168 = v_u_168 + v_u_168 * (v170 / 60)
            v169 = v164
        else
            v169 = v164
        end
        if v_u_32.gun_reload then
            local v171 = v_u_32.gun_reload
            v164 = v169 - v_u_11:handle_perc(v169, v171)
            v_u_167 = v_u_167 - v_u_11:handle_perc(v_u_167, v171)
            v165 = v165 + v165 * (v171 / 60)
            v_u_168 = v_u_168 + v_u_168 * (v171 / 60)
            v169 = v164
        end
        if v_u_32.pistol_reload and v_u_27.large == false then
            local v172 = v_u_32.pistol_reload
            v164 = v169 - v_u_11:handle_perc(v169, v172)
            v_u_167 = v_u_167 - v_u_11:handle_perc(v_u_167, v172)
            v165 = v165 + v165 * (v172 / 60)
            v_u_168 = v_u_168 + v_u_168 * (v172 / 60)
            v169 = v164
        end
        if v_u_7.player_skills:FindFirstChild("medic_massivebuff") then
            v164 = v169 - v_u_11:handle_perc(v169, 50)
            v_u_167 = v_u_167 - v_u_11:handle_perc(v_u_167, 50)
            v165 = v165 + v165 * 0.8333333333333334
            v_u_168 = v_u_168 + v_u_168 * 0.8333333333333334
            v169 = v164
        end
        if v_u_7.player_skills:FindFirstChild("reloadspeedBoost") then
            local v173 = v_u_7.player_skills.reloadspeedBoost.Value
            v164 = v169 - v_u_11:handle_perc(v169, v173)
            v_u_167 = v_u_167 - v_u_11:handle_perc(v_u_167, v173)
            v165 = v165 + v165 * (v173 / 60)
            v_u_168 = v_u_168 + v_u_168 * (v173 / 60)
            v169 = v164
        end
        local v_u_174 = tick()
        local v_u_175 = true
        local v_u_176 = false
        v_u_160 = false
        local function v177()
            -- upvalues: (ref) v_u_28, (ref) v_u_174, (ref) v_u_176, (ref) v_u_37, (ref) v_u_168, (ref) v_u_6, (ref) v_u_17, (ref) v_u_175, (ref) v_u_167
            if v_u_28.empty then
                v_u_174 = tick()
                v_u_176 = true
                v_u_28[v_u_37.buff_gun and (tick() - v_u_37.buff_gun <= v_u_37.buff_gun_time and v_u_28.speed_empty) and "speed_empty" or "empty"]:Play(0.1, 1, v_u_168)
                while true do
                    v_u_6:wait()
                    if v_u_17 == false then
                        v_u_175 = false
                        return
                    end
                    if v_u_167 <= tick() - v_u_174 then
                        goto l2
                    end
                end
            else
                ::l2::
                return
            end
        end
        if v_u_37.buff_gun then
            if tick() - v_u_37.buff_gun <= v_u_37.buff_gun_time then
                v164 = v169 * (1 - v_u_37.buff_gun_effect)
                v165 = v165 / (1 - v_u_37.buff_gun_effect)
                v_u_167 = v_u_167 * (1 - v_u_37.buff_gun_effect)
                v_u_168 = v_u_168 / (1 - v_u_37.buff_gun_effect)
                v169 = v164
            else
                v_u_37.buff_gun = nil
                v_u_37.buff_gun_time = nil
                v_u_37.buff_gun_effect = nil
            end
        end
        v_u_11:soundHandler({
            ["directory"] = { "weapon_manips" },
            ["soundfile"] = "reloadstart",
            ["location"] = v_u_7.Head
        })
        if v_u_64.empty_reload_first == true and (v_u_37.current_magazine <= 0 and v_u_64.no_bolt_reload ~= true) then
            v177()
            if v_u_27.single_load == true then
                v_u_37.current_magazine = v_u_37.current_magazine + 1
                local v178 = v_u_38.ammo_frame.main
                local v179 = v_u_37.current_magazine
                v178.Text = tostring(v179)
                v_u_37.reserve_ammo = v_u_37.reserve_ammo - 1
                local v180 = v_u_38.ammo_frame.reserve
                local v181 = v_u_37.reserve_ammo
                v180.Text = tostring(v181)
                v_u_20.Value = false
                if v_u_64.no_mag_check ~= true then
                    v_u_21.vfx("magcheck", (v_u_54()))
                end
            end
        end
        local v182
        if v_u_27.single_load == true and v_u_64.shell_load_max ~= true then
            if v_u_37.reserve_ammo > 0 then
                local v183 = v_u_37.weapon_max_magazine - v_u_37.current_magazine
                local v184 = v_u_37.reserve_ammo
                v182 = math.clamp(v183, 1, v184)
            else
                v182 = 0
            end
        else
            v182 = 1
        end
        v_u_174 = tick()
        local v185, v186
        if v182 > 0 then
            v185 = v_u_176
            v186 = v_u_175
            local v187 = v_u_174
            for _ = 1, v182 do
                if v182 > 1 and v_u_160 == true then
                    v_u_175 = false
                    v186 = v_u_175
                end
                local v188 = 0.15
                local v189
                if v_u_28.reload_toggle1 then
                    v189 = v162
                    for v190 = 1, 8 do
                        if not v_u_28["reload_toggle" .. v190] then
                            break
                        end
                        if v_u_29.model:FindFirstChild("parts") and (v_u_29.model.parts:FindFirstChild("toggle" .. v190 .. "A") and v_u_29.model.parts:FindFirstChild("toggle" .. v190 .. "A").Transparency == 0) then
                            v162 = v_u_28["reload_toggle" .. v190]
                            v188 = 0.15
                            break
                        end
                    end
                else
                    v189 = v162
                end
                v162:Play(v188, 1, v165)
                while true do
                    v_u_6:wait()
                    if v_u_17 == false then
                        v_u_175 = false
                        v186 = v_u_175
                        break
                    end
                    if v169 <= tick() - v187 then
                        break
                    end
                end
                if v_u_17 == true and (v186 == true and v_u_27.single_load == true) then
                    v_u_37.current_magazine = v_u_37.current_magazine + 1
                    if v_u_64.shell_load_max == true then
                        v_u_37.reserve_ammo = v_u_37.reserve_ammo - (v_u_37.weapon_max_magazine - v_u_37.current_magazine)
                        local v191 = v_u_37
                        local v192 = v_u_37.weapon_max_magazine
                        local v193 = v_u_37.current_magazine + v_u_37.reserve_ammo
                        v191.current_magazine = math.clamp(v192, 0, v193)
                    end
                    local v194 = v_u_38.ammo_frame.main
                    local v195 = v_u_37.current_magazine
                    v194.Text = tostring(v195)
                    local v196 = v_u_37
                    local v197 = v_u_37.reserve_ammo - 1
                    v196.reserve_ammo = math.clamp(v197, 0, 100)
                    local v198 = v_u_38.ammo_frame.reserve
                    local v199 = v_u_37.reserve_ammo
                    v198.Text = tostring(v199)
                    if v_u_64.no_mag_check ~= true then
                        v_u_21.vfx("magcheck", (v_u_54()))
                    end
                    v_u_20.Value = false
                end
                v_u_174 = tick()
                if v_u_17 == false then
                    v_u_175 = false
                    v186 = v_u_175
                end
                v187 = v_u_174
                v162 = v189
            end
        else
            v185 = v_u_176
            v186 = v_u_175
        end
        if v_u_64.empty_reload_first ~= true and (v_u_37.current_magazine <= 0 and (v186 == true and v_u_64.no_bolt_reload ~= true)) then
            v177()
        end
        v_u_96.Value = false
        if v186 == true and v_u_27.single_load == false then
            v_u_11:soundHandler({
                ["directory"] = { "weapon_manips" },
                ["soundfile"] = "reloadend",
                ["location"] = v_u_7.Head
            })
            local v200 = v_u_37
            local v201 = v_u_27.magazine
            local v202 = v_u_37.weapon_max_magazine
            v200.current_magazine = math.clamp(v201, 1, v202)
            local v203 = v_u_38.ammo_frame.main
            local v204 = v_u_37.current_magazine
            v203.Text = tostring(v204)
            if v185 == false and v_u_64.no_chamber == nil then
                v_u_37.current_magazine = v_u_37.current_magazine + 1
                if v_u_27.special_attributes.akimbo == true then
                    v_u_37.current_magazine = v_u_37.current_magazine + 1
                end
                v_u_38.ammo_frame.chambericon.Visible = true
            end
            if v_u_27.single_load ~= true then
                v_u_37.reserve_ammo = v_u_37.reserve_ammo - 1
            end
            v_u_38.ammo_frame.reserve.Text = v_u_37.reserve_ammo
            v_u_20.Value = false
        end
        v_u_97.Value = false
    end
    local function v_u_208()
        -- upvalues: (copy) v_u_37, (ref) v_u_7, (copy) v_u_24, (copy) v_u_5, (copy) v_u_14, (copy) v_u_47, (copy) v_u_10, (copy) v_u_21, (ref) v_u_29, (ref) v_u_27
        if v_u_37.current_magazine <= 0 then
            local v205 = (not v_u_7:FindFirstChild("lastWeapon") or (v_u_7:FindFirstChild("lastWeapon").Value == nil or (not v_u_24.inv:FindFirstChild(v_u_7:FindFirstChild("lastWeapon").Value) or v_u_24.inv:FindFirstChild(v_u_7:FindFirstChild("lastWeapon").Value).item.TextColor3 == Color3.new(1, 0, 0)))) and "1" or v_u_7:FindFirstChild("lastWeapon").Value
            local v206
            if v_u_24.inv:FindFirstChild(v205) and (v_u_24.inv:FindFirstChild(v205):FindFirstChild("assigned") and v_u_5.Backpack:FindFirstChild(v_u_24.inv:FindFirstChild(v205):FindFirstChild("assigned").Value)) then
                v_u_14:EquipTool(v_u_5.Backpack:FindFirstChild(v_u_24.inv:FindFirstChild(v205):FindFirstChild("assigned").Value))
                v206 = true
            else
                v206 = false
            end
            if v206 == false then
                v_u_14:UnequipTools()
                return
            end
        else
            if v_u_47.deployable == true then
                v_u_47.pause_point = false
                if v_u_47 and v_u_47.holo_obj then
                    v_u_47.holo_obj.Parent = v_u_10
                end
            end
            local v207 = {
                ["wep"] = v_u_29,
                ["wep_handler"] = v_u_37,
                ["transp"] = 0
            }
            v_u_21.vfx("weapon_visibility", v207)
            if v_u_27.firing_sound == "glauncher" then
                v_u_21.vfx("glcheck", {
                    ["rounds"] = v_u_37.current_magazine,
                    ["shells"] = v_u_29.model.shells
                })
            end
        end
    end
    local function v_u_225()
        -- upvalues: (copy) v_u_94, (copy) v_u_37, (copy) v_u_97, (copy) v_u_47, (ref) v_u_7, (copy) v_u_9, (copy) v_u_14, (ref) v_u_27, (copy) v_u_34, (copy) v_u_11, (copy) v_u_13, (copy) v_u_28, (copy) v_u_6, (ref) v_u_17, (ref) v_u_39, (copy) v_u_8, (copy) v_u_21, (ref) v_u_29, (copy) v_u_10, (copy) v_u_81, (copy) v_u_1, (copy) v_u_32, (copy) v_u_38, (copy) v_u_208
        if v_u_94.Value == true or v_u_37.current_magazine <= 0 then
            return
        end
        if v_u_97.Value == true then
            return
        end
        if v_u_47.can_deploy == false then
            return
        end
        if v_u_7:FindFirstChild("Torso") and v_u_7.Torso:FindFirstChild("sword_buff") then
            return
        end
        if v_u_9 == "platepiece" and (v_u_14:FindFirstChild("plate_resist") and v_u_14.plate_resist.Value >= v_u_14.plate_resist.max.Value) then
            return
        end
        local v209 = v_u_47.pos_deploy
        if v_u_47.deployable == true then
            v_u_47.pause_point = true
        end
        local v210 = "use"
        local v211 = v_u_27.special_attributes.equipment_speed
        if v_u_34.box_deployspeed and v_u_9 == "ammobox" then
            v211 = v211 + v_u_11:handle_perc(v211, v_u_34.box_deployspeed)
        end
        if v_u_34.faster_equipment_use and v_u_27.special_attributes.regen == nil then
            v211 = v211 + v_u_11:handle_perc(v211, v_u_34.faster_equipment_use)
        end
        local v212 = 0.5 / v211
        local v213 = tick()
        local v214 = true
        if v_u_9 == "platepiece" and v_u_7:FindFirstChild("plateRemoved") == nil then
            v212 = 1.25 / v211
            delay(1, function()
                -- upvalues: (ref) v_u_11, (ref) v_u_27, (ref) v_u_7, (ref) v_u_13
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "plateremove",
                    ["location"] = v_u_7.Head
                })
                v_u_13("plate_throw", {
                    ["source"] = v_u_7
                })
            end)
            v210 = "removeplate"
        end
        v_u_94.Value = true
        v_u_28[v210]:Play(0.05, 1, v211)
        delay(0.1, function()
            -- upvalues: (ref) v_u_27, (ref) v_u_11, (ref) v_u_7
            if v_u_27.special_attributes.quiet_equipment == nil then
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "use",
                    ["location"] = v_u_7.Head
                })
            end
        end)
        if v_u_27.firing_sound == "needle" then
            delay(0.425, function()
                -- upvalues: (ref) v_u_11, (ref) v_u_27, (ref) v_u_7
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "inject",
                    ["location"] = v_u_7.Head
                })
            end)
            delay(0.85, function()
                -- upvalues: (ref) v_u_11, (ref) v_u_27, (ref) v_u_7
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "remove",
                    ["location"] = v_u_7.Head
                })
            end)
        elseif v_u_27.firing_sound == "plate" then
            local v215 = v_u_7:FindFirstChild("plateRemoved") == nil and 2.1 or 1.05
            delay(v215, function()
                -- upvalues: (ref) v_u_11, (ref) v_u_27, (ref) v_u_7
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "close",
                    ["location"] = v_u_7.Head
                })
            end)
        end
        if v_u_27.special_attributes.instant_activation == true then
            v212 = 0
        end
        while true do
            v_u_6:wait()
            if v_u_17 == false then
                v_u_94.Value = false
                v214 = false
                break
            end
            if v212 <= tick() - v213 then
                break
            end
        end
        if v214 ~= true then
            ::l39::
            return
        end
        if v_u_27.special_attributes.quiet_equipment == nil then
            v_u_11:soundHandler({
                ["directory"] = { "weapons", v_u_27.firing_sound },
                ["soundfile"] = "prep",
                ["location"] = v_u_7.Head
            })
        end
        if v_u_27.special_attributes.equipment_held == true then
            v_u_28.use:AdjustSpeed(0)
            while true do
                v_u_28.use.TimePosition = 0.5
                v_u_6:wait()
                if v_u_17 == false then
                    v_u_94.Value = false
                    return
                end
                if v_u_39 == false then
                    v_u_28.use:AdjustSpeed(v211)
                    goto l43
                end
            end
        else
            ::l43::
            if v_u_27.special_attributes.client_effect == true then
                v_u_8.client_effect:Fire(v_u_9, v_u_27)
            end
            if v_u_27.special_attributes.keep_visibility ~= true then
                local v216 = {
                    ["wep"] = v_u_29,
                    ["wep_handler"] = v_u_37,
                    ["transp"] = 1
                }
                v_u_21.vfx("weapon_visibility", v216)
            end
            if v_u_27.firing_sound == "injector" then
                v_u_13("muzzle_flash_general", {
                    ["source"] = v_u_29.model.smoke.Position,
                    ["suppressed"] = true,
                    ["caliber"] = "large"
                })
            end
            if v_u_27.firing_sound == "glauncher" then
                v_u_13("muzzle_flash_general", {
                    ["source"] = v_u_29.model.smoke.Position,
                    ["suppressed"] = true,
                    ["caliber"] = "large"
                })
            end
            if v_u_27.special_attributes.quiet_equipment == nil then
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", v_u_27.firing_sound },
                    ["soundfile"] = "done",
                    ["location"] = v_u_7.Head
                })
            end
            local v217, v218 = v_u_11:raycastline({
                ["point"] = v_u_10.CFrame.p,
                ["destination"] = v_u_10.CFrame.LookVector,
                ["range"] = 100000,
                ["layermask"] = v_u_81
            })
            local v219 = (v_u_9 ~= "laserpoint" or not v_u_1.mainGame.noTarget:FindFirstChild("warlock_noaudio")) and true or false
            if v219 == true then
                v_u_8.equipment_handler:FireServer(v_u_9, {
                    ["cam_point"] = v_u_10.CFrame,
                    ["deploy_point"] = v209,
                    ["hit_targ"] = v217,
                    ["hit_pos"] = v218
                })
                if v_u_9 == "platepiece" and (v_u_7:FindFirstChild("plateRemoved") and v_u_32.armour_plate_heals == nil) then
                    v_u_7.plateRemoved:Destroy()
                end
            end
            if v_u_47 and v_u_47.holo_obj then
                v_u_47.holo_obj.Parent = nil
            end
            if v219 == true then
                v_u_37.current_magazine = v_u_37.current_magazine - 1
                local v220 = v_u_38.ammo_frame.main
                local v221 = v_u_37.current_magazine
                v220.Text = tostring(v221)
            end
            if v_u_37.current_magazine <= 0 and (v_u_27.special_equipment ~= true and v219 == true) then
                v_u_38.get_current_ui().item.TextColor3 = Color3.new(1, 0, 0)
            end
            local v222 = v_u_34.box_deployspeed and v_u_9 == "ammobox" and true or false
            local v223 = v_u_34.no_equipment_winddown and (v_u_9 ~= "platepiece" and v_u_27.special_attributes.regen == nil) and true or v222
            if v_u_27.special_attributes.slowdown ~= nil and v223 == false then
                v_u_28[v210]:AdjustSpeed(v_u_27.special_attributes.slowdown)
            end
            if v_u_27.firing_sound == "glauncher" then
                v_u_21.vfx("glcheck", {
                    ["rounds"] = v_u_37.current_magazine,
                    ["shells"] = v_u_29.model.shells
                })
            end
            local v224 = tick()
            while true do
                v_u_6:wait()
                if v_u_17 == false then
                    v_u_94.Value = false
                    break
                end
                if tick() - v224 >= 3 or v_u_28[v210].isPlaying == false then
                    break
                end
            end
            v_u_208()
            v_u_94.Value = false
            v_u_28[v210]:Stop(0.4, 1, 1)
            goto l39
        end
    end
    local v_u_226 = 1
    local function v_u_272(p_u_227)
        -- upvalues: (copy) v_u_95, (ref) v_u_27, (copy) v_u_97, (copy) v_u_94, (ref) v_u_7, (copy) v_u_37, (copy) v_u_11, (copy) v_u_82, (copy) v_u_32, (copy) v_u_98, (ref) v_u_100, (copy) v_u_22, (copy) v_u_6, (copy) v_u_36, (copy) v_u_5, (copy) v_u_12, (ref) v_u_29, (copy) v_u_38, (copy) v_u_10, (copy) v_u_13, (copy) v_u_21, (copy) v_u_28, (copy) v_u_64, (copy) v_u_9, (copy) v_u_54, (copy) v_u_3, (copy) v_u_26, (copy) v_u_127, (ref) v_u_226, (copy) v_u_18, (copy) v_u_40, (ref) v_u_17, (copy) v_u_8, (copy) v_u_142, (ref) v_u_39
        if v_u_95.Value == true and v_u_27.special_attributes.sprint_shoot == nil then
            return
        end
        if v_u_97.Value == true then
            return
        end
        if v_u_94.Value == true then
            return
        end
        if v_u_7:FindFirstChild("Torso") and (v_u_7.Torso:FindFirstChild("sword_buff") and v_u_27.special ~= "melee") then
            return
        end
        if v_u_37.current_magazine <= 0 and v_u_27.special ~= "melee" then
            v_u_11:soundHandler({
                ["directory"] = { "weapons", "effects" },
                ["soundfile"] = "click",
                ["pitchvariation"] = 0.1,
                ["location"] = v_u_7.HumanoidRootPart
            })
            return
        end
        local v228 = v_u_82
        if v_u_32.pistol_semi_hip_firerate and (v_u_27.large == false and (v_u_27.special ~= "melee" and v_u_98.Value == false)) then
            v228 = v228 - v_u_11:handle_perc(v228, v_u_32.pistol_semi_hip_firerate)
        end
        if tick() - v_u_100 < v228 then
            return
        end
        if v_u_27.special ~= "melee" then
            if v_u_22 == "anomaly" then
                return
            end
            v_u_11:soundHandler({
                ["directory"] = { "weapons", "effects" },
                ["soundfile"] = "trigger",
                ["pitchvariation"] = 0.1,
                ["location"] = v_u_7.HumanoidRootPart
            }, true)
        end
        if v_u_32.no_shooting_large and v_u_27.large == true then
            return
        end
        v_u_94.Value = true
        if v_u_27.special_attributes.trigger_delay ~= nil then
            local v229 = tick()
            repeat
                v_u_6:wait()
            until tick() - v229 >= v_u_27.special_attributes.trigger_delay
        end
        local v230 = v_u_27.semi_automatic == true and 0 or 1
        local v231 = 0
        local v232 = v_u_27.pellets
        local v233 = v_u_27.ballistic_type
        local v234 = v_u_27.special == "suppressed" and "quiet" or "loud"
        if v_u_27.special_attributes.burst_rpm_mod ~= nil then
            v228 = v_u_27.special_attributes.burst_rpm_mod
        end
        local v235 = not v_u_27.special_attributes.burst_count and 0 or v_u_27.special_attributes.burst_count
        local v236 = v_u_27.special_attributes.akimbo == true and 2 or v235
        local v_u_237 = false
        while true do
            local v238 = v_u_27.base_recoil - v_u_36.recoil
            if v_u_32.standing_recoil and v_u_5.Character.HumanoidRootPart.Velocity.magnitude <= 0.1 then
                v238 = v238 - v_u_11:handle_perc(v238, v_u_32.standing_recoil)
            end
            if v_u_32.brace_recoil and v_u_98.Value == true then
                v238 = v238 - v_u_11:handle_perc(v238, v_u_32.brace_recoil)
            end
            local v_u_239 = math.clamp(v238, 1, 100) / 8
            if v_u_27.special_attributes.burst_recoil_mod ~= nil and v231 < v236 then
                v_u_239 = (v_u_27.base_recoil + v_u_27.special_attributes.burst_recoil_mod) / 8
            end
            if v_u_98.Value == true or v_u_32.hip_ads_bonus then
                v_u_239 = v_u_239 / v_u_12.brace_recoil_reduction
            end
            if v_u_37.buff_gun ~= nil then
                if tick() - v_u_37.buff_gun <= v_u_37.buff_gun_time then
                    v_u_239 = v_u_239 * (1 - v_u_37.buff_gun_effect)
                else
                    v_u_37.buff_gun = nil
                    v_u_37.buff_gun_time = nil
                    v_u_37.buff_gun_effect = nil
                end
            end
            if v228 <= tick() - v_u_100 then
                v231 = v231 + 1
                local v_u_240 = v_u_29
                if v_u_27.special_attributes.akimbo == true and v231 > 1 then
                    v_u_240 = v_u_29.model.akimbo
                end
                if v_u_27.special == "melee" then
                    local v241
                    if v_u_28.swing2 == nil then
                        v241 = "swing1"
                    else
                        v241 = "swing" .. v_u_226
                        if v_u_226 == 1 then
                            v_u_226 = 2
                        else
                            v_u_226 = 1
                        end
                    end
                    local v242 = 0.5 / v_u_27.fire_rate
                    local v243 = v_u_27.special_attributes.hidden == true and 0 or v242
                    local v244 = 0.5 / v_u_27.fire_rate
                    local v245 = v_u_18:FindFirstChild("stamina")
                    if v_u_98.Value == true and (v_u_9 ~= "fists" and v245) then
                        local v246 = v245.max.Value * 0.15
                        local v247 = math.ceil(v246)
                        if v247 <= v245.Value then
                            v245.Value = v245.Value - v247
                            v243 = v243 * 2.2
                            v244 = v244 * 0.75
                            v_u_237 = true
                        end
                    end
                    if p_u_227 == true then
                        v241 = "swingalt"
                        v243 = 3
                    end
                    if v_u_27.firing_sound == "fists" then
                        v_u_11:soundHandler({
                            ["directory"] = { "weapons", "fists_sounds" },
                            ["soundfile"] = "fist" .. math.random(1, 3),
                            ["pitchvariation"] = 0.1,
                            ["location"] = v_u_7.HumanoidRootPart,
                            ["soundgroup"] = v_u_40
                        }, nil)
                    end
                    delay(0.175 / v243, function()
                        -- upvalues: (ref) v_u_17, (ref) v_u_27, (ref) v_u_11, (ref) v_u_7, (ref) v_u_40, (copy) p_u_227, (ref) v_u_8
                        if v_u_17 ~= false then
                            if v_u_27.firing_sound ~= "fists" then
                                v_u_11:soundHandler({
                                    ["directory"] = { "weapons", "firing_sounds" },
                                    ["soundfile"] = v_u_27.firing_sound,
                                    ["pitchvariation"] = 0.1,
                                    ["location"] = v_u_7.HumanoidRootPart,
                                    ["soundgroup"] = v_u_40
                                }, nil)
                            end
                            if p_u_227 == true and v_u_27.special_attributes.hidden == true then
                                v_u_8.voices_handler:FireServer("Fake Attack")
                            end
                        end
                    end)
                    delay(0.2 / v243, function()
                        -- upvalues: (ref) v_u_17, (ref) v_u_142, (ref) v_u_237
                        if v_u_17 ~= false then
                            v_u_142(v_u_237)
                        end
                    end)
                    v_u_28[v241]:Play(0.1, 1, v244)
                    v_u_37.current_magazine = v_u_37.current_magazine + 1
                else
                    v_u_38.ammo_frame.chambericon.Visible = false
                    if v_u_27.special_attributes.akimbo == true and (v231 == 1 and v_u_37.current_magazine > v_u_37.weapon_max_magazine) then
                        v_u_38.ammo_frame.chambericon.Visible = true
                    end
                    local v248 = v_u_10.CFrame
                    spawn(function()
                        -- upvalues: (ref) v_u_27, (ref) v_u_239, (ref) v_u_10, (ref) v_u_6
                        local v249 = v_u_27.base_recoil / 5
                        local v250 = math.ceil(v249)
                        local v251 = math.clamp(v250, 3, 6)
                        local v252 = v_u_239 / v251
                        local v253 = CFrame.Angles
                        local v254 = math.rad(v252)
                        local v255 = math.random(-v252 * 10, v252 * 10) / 20
                        local v256 = v253(v254, math.rad(v255), 0)
                        local v257 = tick()
                        for _ = 1, v251 do
                            v_u_10.CFrame = v_u_10.CFrame * v256
                            repeat
                                v_u_6:wait()
                            until tick() - v257 >= 0.01666
                            v257 = tick()
                        end
                    end)
                    if v_u_240.model:FindFirstChild("parts") then
                        v_u_13("muzzle_flash_general", {
                            ["source"] = v_u_240.model.parts.muzzle.Position,
                            ["suppressed"] = v_u_27.special == "suppressed",
                            ["caliber"] = v_u_27.ballistic_type
                        })
                        v_u_21.vfx("muzzle_smoke", {
                            ["source"] = v_u_240.model.parts
                        }, true)
                    end
                    local v258 = v_u_27.special_attributes.akimbo == true and v231 > 1 and "shoot_akimbo" or "shoot"
                    if v_u_28.aimed ~= nil then
                        if v_u_98.Value == true then
                            v258 = "aimed"
                        else
                            v_u_28.aimed:Stop(0)
                        end
                    end
                    if v_u_27.special_attributes.sprint_shoot ~= nil then
                        if v_u_95.Value == true then
                            v_u_28.shoot:Stop(0)
                            v258 = "sprint_shoot"
                        else
                            v_u_28.sprint_shoot:Stop(0)
                        end
                    end
                    v_u_28[v258]:Play(0.1)
                    v_u_11:soundHandler({
                        ["directory"] = { "weapons", "firing_sounds" },
                        ["soundfile"] = v_u_27.firing_sound,
                        ["pitchvariation"] = 0.05,
                        ["volume_adjust"] = v230,
                        ["pitch_adjust"] = -v230 / 10,
                        ["location"] = v_u_7.HumanoidRootPart
                    })
                    if v_u_27.firing_sound == "dmr" or v_u_27.firing_sound == "dmr_fd" then
                        v_u_11:soundHandler({
                            ["directory"] = { "weapons" },
                            ["soundfile"] = "dmr_air",
                            ["pitchvariation"] = 0.05,
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    end
                    if v_u_7.player_skills:FindFirstChild("box_damage_boost") then
                        v_u_11:soundHandler({
                            ["directory"] = { "spec_sounds" },
                            ["soundfile"] = "damageboost_ammobox",
                            ["pitchvariation"] = 0.05,
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    end
                    if v_u_7.player_skills:FindFirstChild("incendiary_bullets") then
                        v_u_11:soundHandler({
                            ["directory"] = { "spec_sounds" },
                            ["soundfile"] = "turret_incendiary",
                            ["pitchvariation"] = 0.05,
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    end
                    v230 = v230 == 1 and 0 or v230
                    v_u_11:soundHandler({
                        ["directory"] = { "weapons", "effects" },
                        ["soundfile"] = "bass",
                        ["location"] = v_u_7.HumanoidRootPart
                    }, true)
                    local v259, v260
                    if v_u_37.current_magazine <= 5 then
                        v259 = 0 + (6 - v_u_37.current_magazine) / 2
                        v260 = 1 + (6 - v_u_37.current_magazine) / 5
                    else
                        v260 = 1
                        v259 = 0
                    end
                    v_u_11:soundHandler({
                        ["directory"] = { "weapons", "effects" },
                        ["soundfile"] = "mech",
                        ["location"] = v_u_7.HumanoidRootPart,
                        ["pitch"] = v260,
                        ["volume_adjust"] = v259
                    }, true)
                    if v233 ~= "none" then
                        v_u_11:soundHandler({
                            ["directory"] = {
                                "weapons",
                                "atmos",
                                v233,
                                _G.indoors == true and "indoors" or "outdoors"
                            },
                            ["soundfile"] = v234 .. "_" .. math.random(1, 3),
                            ["pitchvariation"] = 0.05,
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    end
                    if v_u_27.special == "suppressed" then
                        v_u_11:soundHandler({
                            ["directory"] = { "weapons", "effects" },
                            ["soundfile"] = "suppressed",
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                        v_u_11:soundHandler({
                            ["directory"] = { "weapons", "effects" },
                            ["soundfile"] = "suppressed2",
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    elseif v236 > 0 and v231 < v236 then
                        v_u_11:soundHandler({
                            ["directory"] = { "weapons", "firing_sounds" },
                            ["soundfile"] = v_u_27.firing_sound .. "_burst",
                            ["pitchvariation"] = 0.05,
                            ["location"] = v_u_7.HumanoidRootPart
                        })
                    end
                    if v_u_64 then
                        local v261 = v_u_27.special_attributes.akimbo == true and 2 or 1
                        if v_u_64.no_firing_bolting ~= true and v_u_240.weld:FindFirstChild("bolt") then
                            v_u_21.vfx("boltback", {
                                ["source"] = v_u_240.model.parts,
                                ["wep"] = v_u_9,
                                ["wep_handler"] = v_u_37,
                                ["char"] = v_u_7,
                                ["body"] = v_u_240.weld,
                                ["no_sound"] = true
                            })
                            if v261 < v_u_37.current_magazine or v_u_64.no_bolt_lock == true then
                                local v262 = delay
                                local v263 = v_u_27.fire_rate / 2
                                v262(math.clamp(v263, 0.01, 0.05), function()
                                    -- upvalues: (ref) v_u_21, (ref) v_u_240, (ref) v_u_9, (ref) v_u_37, (ref) v_u_7
                                    v_u_21.vfx("boltforward", {
                                        ["source"] = v_u_240.model.parts,
                                        ["wep"] = v_u_9,
                                        ["wep_handler"] = v_u_37,
                                        ["char"] = v_u_7,
                                        ["body"] = v_u_240.weld,
                                        ["no_sound"] = true
                                    })
                                end)
                            end
                        end
                        if v_u_240.weld:FindFirstChild("chamber") and v_u_37.current_magazine <= v261 then
                            local v264 = v_u_54()
                            v264.source = v_u_240.model.parts
                            v_u_21.vfx("chamberempty", v264)
                        end
                    end
                    if v_u_64 and (v_u_240.model:FindFirstChild("parts") and v_u_64.no_firing_ejection ~= true) then
                        local v265 = v_u_54()
                        v265.source = v_u_240.model.parts
                        v_u_21.vfx("ejection", v265)
                    end
                    v_u_27 = v_u_3(v_u_26)
                    for _ = 1, v232 do
                        v_u_127(v248, v_u_240)
                    end
                end
                v_u_100 = tick()
                if v_u_27.special_attributes.slowed_aimed ~= nil and v_u_98.Value == true then
                    v_u_100 = v_u_100 + v_u_27.special_attributes.slowed_aimed
                end
                if v_u_7:FindFirstChild("Torso") and (v_u_7.Torso:FindFirstChild("sword_buff") and (v_u_27.special == "melee" and v_u_9 == "sword")) then
                    v_u_100 = v_u_100 - 0.2
                end
                if v_u_237 == true then
                    v_u_100 = v_u_100 + v_u_27.fire_rate * 0.5
                end
                if p_u_227 == true then
                    v_u_100 = v_u_100 + 0.75
                end
                local v266 = 0
                if v_u_32.pistols_no_ammo_consume and (v_u_27.large == false and v_u_27.special ~= "melee") then
                    v266 = v266 + v_u_32.pistols_no_ammo_consume
                end
                v_u_37.current_magazine = v_u_37.current_magazine - 1
                local v267 = v266 <= 0 or math.random(1, 100) > v266
                if v_u_7.player_skills:FindFirstChild("box_inf_ammo") then
                    v267 = false
                end
                if v267 == false then
                    v_u_37.current_magazine = v_u_37.current_magazine + 1
                end
                if v_u_64 and (v_u_240.model:FindFirstChild("parts") and v_u_64.no_mag_check ~= true) then
                    v_u_21.vfx("magcheck", (v_u_54()))
                end
                local v268 = v_u_38.ammo_frame.main
                local v269 = v_u_37.current_magazine
                local v270 = v_u_37.weapon_max_magazine
                local v271 = math.clamp(v269, 0, v270)
                v268.Text = tostring(v271)
                if v_u_27.special_attributes.burst_rpm_mod ~= nil then
                    if v231 < v236 then
                        v228 = v_u_27.special_attributes.burst_rpm_mod
                    else
                        v228 = v_u_82
                    end
                end
                if v_u_27.special_attributes.rpm_increase ~= nil and v231 < v_u_27.special_attributes.rpm_max_increase then
                    v228 = v228 - v_u_27.special_attributes.rpm_increase
                end
            end
            if v_u_7:FindFirstChild("Torso") and (v_u_7.Torso:FindFirstChild("sword_buff") and v_u_27.special ~= "melee") then
                break
            end
            v_u_6:wait()
            if v_u_39 == false and v236 == 0 then
                break
            end
            if v236 > 0 then
                if v236 <= v231 and (v_u_27.special_attributes.burst_allow_auto == nil or v_u_39 == false) then
                    break
                end
            elseif v_u_39 == false then
                break
            end
            if v_u_37.current_magazine <= 0 or (v_u_17 == false or (v_u_27.semi_automatic == true or v_u_27.special_attributes.hidden == true)) then
                break
            end
        end
        if v_u_27.special_attributes.akimbo == true and (v231 == 1 and (v_u_37.current_magazine > 1 and v_u_17 == false)) then
            v_u_37.current_magazine = v_u_37.current_magazine - 1
        end
        if v_u_37.current_magazine <= 0 then
            v_u_11:soundHandler({
                ["directory"] = { "weapons", "effects" },
                ["soundfile"] = "empty",
                ["location"] = v_u_7.HumanoidRootPart
            })
        end
        if v_u_27.special ~= "melee" and v_u_27.special_attributes.slowed_aimed == nil then
            v_u_100 = tick()
        end
        v_u_94.Value = false
        if _G.disable_pings == true and (v_u_27.special ~= "melee" and v_u_37.current_magazine <= 0) then
            v_u_37.on_reload()
        end
    end
    function v_u_37.onClickAlt()
        -- upvalues: (copy) v_u_94, (ref) v_u_17, (ref) v_u_55, (ref) v_u_57, (copy) v_u_95, (copy) v_u_97, (copy) v_u_1, (copy) v_u_10, (copy) v_u_14, (ref) v_u_27, (copy) v_u_272
        if v_u_94.Value == true or (v_u_17 == false or tick() - v_u_55 <= v_u_57) then
            return
        elseif v_u_95.Value == true then
            return
        elseif v_u_97.Value == true then
            return
        elseif v_u_1.mainGame.perks_active:FindFirstChild("no_pigstick") then
            return
        elseif v_u_10.CameraSubject == v_u_14 then
            if v_u_27.special_attributes.hidden == true and v_u_27.special == "melee" then
                v_u_272(true)
            end
        end
    end
    function v_u_37.onClick()
        -- upvalues: (copy) v_u_94, (ref) v_u_17, (ref) v_u_55, (ref) v_u_57, (copy) v_u_97, (ref) v_u_160, (copy) v_u_1, (ref) v_u_27, (copy) v_u_10, (copy) v_u_14, (copy) v_u_225, (copy) v_u_272
        if v_u_94.Value == true or (v_u_17 == false or tick() - v_u_55 <= v_u_57) then
            return
        elseif v_u_97.Value == true then
            v_u_160 = true
            return
        elseif v_u_1.mainGame.perks_active:FindFirstChild("no_light_swings") and (v_u_27.special_attributes.hidden == true and v_u_27.special == "melee") then
            return
        elseif v_u_10.CameraSubject == v_u_14 then
            if v_u_27.equipment == true then
                v_u_225()
            else
                v_u_272()
            end
        else
            return
        end
    end
    v_u_37.handle_equipment_swap = v_u_208
    local function v_u_281(p273, p274)
        -- upvalues: (ref) v_u_27, (copy) v_u_37, (copy) v_u_20, (ref) v_u_17, (copy) v_u_11, (ref) v_u_7, (copy) v_u_10, (copy) v_u_38
        local v275 = v_u_27.single_load ~= true and 1 or v_u_27.magazine
        local v276 = v_u_37
        local v277 = v_u_37.reserve_ammo + v275 * p273
        local v278 = v_u_37.weapon_reserve_max
        v276.reserve_ammo = math.clamp(v277, 0, v278)
        if v_u_37.reserve_ammo >= v_u_37.weapon_reserve_max then
            v_u_20.Value = true
        end
        if v_u_17 == true then
            if p274 == "trader" then
                v_u_11:soundHandler({
                    ["directory"] = { "trader_sounds" },
                    ["soundfile"] = "ammo_buy",
                    ["pitchvariation"] = 0.1,
                    ["location"] = v_u_7.HumanoidRootPart
                })
            else
                v_u_11:soundHandler({
                    ["directory"] = { "weapons", "ammobox" },
                    ["soundfile"] = "refill",
                    ["location"] = v_u_10
                }, true)
            end
            local v279 = v_u_38.ammo_frame.reserve
            local v280 = v_u_37.reserve_ammo
            v279.Text = tostring(v280)
        end
    end
    v19.Event:Connect(v_u_281)
    v_u_8.game_handler.OnClientEvent:connect(function(p282, p283)
        -- upvalues: (ref) v_u_27, (ref) v_u_17, (copy) v_u_281, (copy) v_u_37, (copy) v_u_16, (ref) v_u_7, (copy) v_u_28
        if p282 == "ammobox" then
            if v_u_27.special ~= "melee" and v_u_27.equipment == false and ((not p283.currently_held or v_u_17 == true) and true or false) == true then
                v_u_281(p283.mags)
                return
            end
        else
            if p282 == "invil_boost" then
                v_u_37.buff_gun = tick()
                v_u_37.buff_gun_time = p283.duration
                v_u_37.buff_gun_effect = p283.effect
                local v284 = Instance.new("IntValue")
                v_u_16:AddItem(v284, p283.duration)
                local v285 = Instance.new("StringValue")
                v285.Name = "buffname"
                v285.Value = "SYRINGE"
                v285.Parent = v284
                v284.Name = "syringefakebuff"
                v284.Parent = v_u_7.player_skills
                return
            end
            if p282 == "melee_blocked" and (v_u_27.special == "melee" and (v_u_28.block1 and v_u_28.block2)) then
                v_u_28["block" .. math.random(1, 2)]:Play(0.05, 1, 1.2)
            end
        end
    end)
    local v_u_286 = false
    v_u_18.Equipped:Connect(function()
        -- upvalues: (copy) v_u_14, (ref) v_u_7, (copy) v_u_28, (ref) v_u_27, (copy) v_u_38, (copy) v_u_15, (copy) v_u_23, (copy) v_u_24, (ref) v_u_57, (ref) v_u_56, (copy) v_u_36, (copy) v_u_37, (copy) v_u_9, (copy) v_u_32, (copy) v_u_11, (ref) v_u_55, (ref) v_u_286, (copy) v_u_47, (ref) v_u_29, (copy) v_u_21, (copy) v_u_64, (copy) v_u_54, (ref) v_u_17, (copy) v_u_8
        if v_u_14.Health > 0 then
            if v_u_7.sprintAnim.Value and v_u_7.sprintAnim.Value:IsA("AnimationTrack") then
                v_u_7.sprintAnim.Value:Stop()
            end
            if v_u_28.sprint == nil then
                v_u_7.sprintAnim.Value = nil
            else
                v_u_7.sprintAnim.Value = v_u_28.sprint
            end
            if v_u_27.name ~= "Fists" and v_u_27.special_equipment ~= true then
                v_u_38.get_current_ui().gradient.Visible = true
            end
            v_u_15.MouseIconEnabled = false
            if v_u_7:FindFirstChild("braceBlock") and v_u_7.braceBlock.Value ~= true then
                v_u_23.crosshair.Visible = true
            end
            v_u_23.crosshair.Size = UDim2.new(0, 40, 0, 40)
            v_u_24.lower_right.item_name.Text = v_u_27.name
            v_u_24.lower_right.ammo_frame.Visible = false
            v_u_24.lower_right.usesframe.Visible = false
            v_u_24.lower_right.melee_frame.Visible = false
            local v287 = "large"
            v_u_57 = v_u_56
            if v_u_27.special == "melee" then
                v287 = "knife"
                v_u_56 = 0.5
                v_u_57 = v_u_56
                if v_u_9 == "knife" then
                    v_u_56 = 0.25
                    v_u_57 = v_u_56
                end
                if v_u_27.melee_stamina > 0 then
                    v_u_38.ammo_frame.Visible = true
                    spawn(v_u_38.update_melee_stam)
                end
            else
                v_u_38.ammo_frame.Visible = true
                local v288 = v_u_27.pellets > 2 and 0 or v_u_36.spread
                local v289 = (v_u_27.spread - v288) * 5
                local v290 = math.clamp(v289, 30, 300)
                v_u_23.crosshair.Size = UDim2.new(0, v290, 0, v290)
                if v_u_27.equipment == false then
                    v_u_38.ammo_frame.chambericon.Visible = false
                    if v_u_27.large == false then
                        v287 = "small"
                        v_u_56 = 0.5
                        v_u_57 = v_u_56
                    end
                    if v_u_37.current_magazine then
                        local v291 = v_u_38.ammo_frame.main
                        local v292 = v_u_37.current_magazine
                        v291.Text = tostring(v292)
                        if v_u_37.current_magazine > v_u_37.weapon_max_magazine then
                            local v293 = v_u_38.ammo_frame.main
                            local v294 = v_u_37.weapon_max_magazine
                            v293.Text = tostring(v294)
                            v_u_38.ammo_frame.chambericon.Visible = true
                        end
                        local v295 = v_u_38.ammo_frame.reserve
                        local v296 = v_u_37.reserve_ammo
                        v295.Text = tostring(v296)
                        v_u_38.ammo_frame.magicon.Image = "rbxassetid://8156103728"
                        if v_u_27.single_load == true then
                            if v_u_27.pellets > 2 then
                                v_u_38.ammo_frame.magicon.Image = "rbxassetid://8164762607"
                            else
                                v_u_38.ammo_frame.magicon.Image = "rbxassetid://10479075810"
                            end
                        end
                    end
                else
                    v287 = "equipment"
                    if v_u_37.current_magazine then
                        v_u_38.ammo_frame.main.Text = v_u_37.current_magazine
                    end
                end
            end
            if v_u_27.animation == "fists" then
                v287 = "fists"
                v_u_56 = 0.5
                v_u_57 = v_u_56
            end
            if v_u_27.animation == "sword" then
                v_u_56 = 1
                v_u_57 = v_u_56
            end
            if v_u_27.unique_equip_sound then
                v287 = v_u_27.unique_equip_sound
            end
            if v_u_9 == "medic" then
                v_u_56 = 0.5
                v_u_57 = v_u_56
            end
            if v_u_32.swap_speed then
                v_u_57 = v_u_57 - v_u_11:handle_perc(v_u_57, v_u_32.swap_speed)
            end
            v_u_11:soundHandler({
                ["directory"] = { "weapon_manips", "draws" },
                ["soundfile"] = v287,
                ["location"] = v_u_7.Head
            })
            if v_u_24.lower_right:FindFirstChild("item_tip") then
                v_u_24.lower_right:FindFirstChild("item_tip").Text = v_u_27.desc
            end
            v_u_7:FindFirstChild("Left Arm").Transparency = 0
            v_u_7:FindFirstChild("Right Arm").Transparency = 0
            v_u_28.equip:Play(0.1, 1, 1 / v_u_57)
            v_u_55 = tick()
            if v_u_286 == false then
                v_u_286 = true
                delay(0.2, function()
                    -- upvalues: (ref) v_u_28
                    if v_u_28.empty then
                        v_u_28.empty:Play(0.2, 1, 1.2)
                    end
                end)
            end
            if v_u_47.deployable == true then
                v_u_47.create_holo()
            end
            if v_u_29 then
                for _, v297 in ipairs(v_u_29:GetDescendants()) do
                    if v297:IsA("BasePart") then
                        v_u_11:localizeTransparency(v297)
                    end
                end
            end
            v_u_11:fast_spawn(function()
                -- upvalues: (ref) v_u_21, (ref) v_u_29, (ref) v_u_37, (ref) v_u_27, (ref) v_u_64, (ref) v_u_54, (ref) v_u_9
                local v298 = {
                    ["wep"] = v_u_29,
                    ["wep_handler"] = v_u_37,
                    ["transp"] = 0
                }
                v_u_21.vfx("weapon_visibility", v298)
                if v_u_27.special ~= "melee" and v_u_27.equipment == false then
                    if v_u_64.no_mag_check ~= true then
                        v_u_21.vfx("magcheck", (v_u_54()))
                    end
                    if v_u_64.toggle_keeper then
                        v_u_21.vfx("togglecheck", (v_u_54()))
                    end
                end
                if v_u_9 == "glauncher" then
                    v_u_21.vfx("glcheck", {
                        ["rounds"] = v_u_37.current_magazine,
                        ["shells"] = v_u_29.model.shells
                    })
                end
            end)
            v_u_17 = true
            v_u_8.weapon_handler:FireServer(v_u_9, "show")
        end
    end)
    local function v_u_301()
        -- upvalues: (copy) v_u_14, (ref) v_u_7, (ref) v_u_27, (copy) v_u_38, (copy) v_u_21, (copy) v_u_54, (ref) v_u_29, (copy) v_u_37, (copy) v_u_24, (copy) v_u_15, (copy) v_u_23, (copy) v_u_28, (ref) v_u_17, (copy) v_u_8, (copy) v_u_9
        if v_u_14.Health > 0 then
            if v_u_7:FindFirstChild("lastWeapon") and v_u_27.special_equipment ~= true then
                v_u_7:FindFirstChild("lastWeapon").Value = v_u_38.get_current_ui().Name
            end
            v_u_21.vfx("clear_allparticles", (v_u_54()))
            local v299 = {
                ["wep"] = v_u_29,
                ["wep_handler"] = v_u_37,
                ["transp"] = 1
            }
            v_u_21.vfx("weapon_visibility", v299)
            if v_u_27.special_equipment == true then
                v_u_24.lower_left.special_equipment.gradient.Visible = false
            else
                v_u_38.get_current_ui().gradient.Visible = false
            end
            v_u_15.MouseIconEnabled = true
            v_u_23.crosshair.Visible = false
            for _, v300 in pairs(v_u_28) do
                v300:Stop(0.1)
            end
            v_u_17 = false
            v_u_8.weapon_handler:FireServer(v_u_9, "hide")
        end
    end
    v_u_18.Unequipped:Connect(v_u_301)
    v_u_18.Activated:Connect(function()
        -- upvalues: (copy) v_u_14, (ref) v_u_7, (copy) v_u_23, (ref) v_u_39, (ref) v_u_17, (copy) v_u_37
        if v_u_14.Health <= 0 then
            return
        elseif v_u_7:FindFirstChild("terror_form") and (v_u_7.terror_form:FindFirstChild("transformed") and v_u_7.terror_form.transformed.Value == true) then
            return
        elseif v_u_23.trader_frame.Visible ~= true then
            v_u_39 = true
            if v_u_17 == true then
                v_u_37.onClick()
            end
        end
    end)
    v_u_18.Deactivated:Connect(function()
        -- upvalues: (copy) v_u_14, (ref) v_u_39
        if v_u_14.Health > 0 then
            if v_u_39 == true then
                v_u_39 = false
            end
        end
    end)
    local v_u_307 = v_u_15.InputBegan:connect(function(p302, p303)
        -- upvalues: (ref) v_u_7, (copy) v_u_18, (copy) v_u_47, (copy) v_u_9, (ref) v_u_17, (ref) v_u_55, (ref) v_u_57, (copy) v_u_14, (copy) v_u_37, (copy) v_u_301
        if p303 == true then
            return
        elseif v_u_7:FindFirstChild("terror_form") and (v_u_7.terror_form:FindFirstChild("transformed") and v_u_7.terror_form.transformed.Value == true) then
            return
        else
            local v304 = p302.KeyCode
            if v_u_18 ~= nil and (v304 == Enum.KeyCode.X and (v_u_47.alt_equipment[v_u_9] ~= nil and (v_u_17 == true and tick() - v_u_47.alt_tick >= 1))) then
                v_u_47.alt_tick = tick()
                v_u_47.alt_equipment[v_u_9]()
            end
            if v_u_17 == false then
                return
            elseif tick() - v_u_55 <= v_u_57 then
                return
            else
                local v305 = p302.KeyCode
                if v_u_14.Health > 0 then
                    if v305 == Enum.KeyCode.R then
                        v_u_37.on_reload()
                    end
                    if v305 == Enum.KeyCode.Q then
                        v_u_37.melee_bash()
                    end
                    if v305 == Enum.KeyCode.L then
                        v_u_37.inspect_anim()
                    end
                    if v305 == Enum.KeyCode.Backspace then
                        local v306 = v_u_7:FindFirstChild("terror_form")
                        if v306 and v306:FindFirstChild("transformed").Value == true then
                            return
                        end
                        v_u_301()
                    end
                    if p302.UserInputType == Enum.UserInputType.MouseButton2 then
                        v_u_37.onClickAlt()
                    end
                end
            end
        end
    end)
    v_u_14.Died:connect(function()
        -- upvalues: (copy) v_u_307, (ref) v_u_17, (copy) v_u_28
        v_u_307:Disconnect()
        v_u_17 = false
        for _, v308 in ipairs(v_u_28) do
            if v308.isPlaying == true then
                v308:AdjustSpeed(0)
            end
        end
    end)
    return
end
