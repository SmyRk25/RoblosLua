-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local _ = game:GetService("RunService").RenderStepped
local v_u_2 = workspace.mainGame.remotes
function v_u_1.debugline(_, p3, p4)
    local v5 = Instance.new("Part")
    game:GetService("Debris"):AddItem(v5, 1)
    v5.Material = "Neon"
    v5.BrickColor = BrickColor.new("Bright red")
    v5.Name = "debugRay"
    v5.Transparency = 0.5
    v5.Anchored = true
    v5.CanCollide = false
    v5.Locked = true
    local v6 = (p3 - p4).magnitude
    v5.CFrame = CFrame.new(p3, p4) * CFrame.new(0, 0, -v6 / 2)
    v5.Size = Vector3.new(0.25, 0.25, v6)
    v5.BrickColor = BrickColor.new("Bright red")
    v5.Material = "Neon"
    v5.Parent = workspace.mainGame.noTarget
    return v5
end
function v_u_1.fast_spawn(_, p_u_7, ...)
    local v8 = type(p_u_7) == "function"
    assert(v8)
    local v_u_9 = { ... }
    local v_u_10 = select("#", ...)
    local v11 = Instance.new("BindableEvent")
    v11.Event:Connect(function()
        -- upvalues: (copy) p_u_7, (copy) v_u_9, (copy) v_u_10
        local v12 = v_u_9
        local v13 = v_u_10
        p_u_7(unpack(v12, 1, v13))
    end)
    v11:Fire()
    v11:Destroy()
end
function v_u_1.localizeTransparency(_, p_u_14)
    p_u_14.LocalTransparencyModifier = 0
    if not table.find(_G.connections, p_u_14) then
        p_u_14:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
            -- upvalues: (copy) p_u_14
            p_u_14.LocalTransparencyModifier = 0
        end)
        local v15 = _G.connections
        table.insert(v15, p_u_14)
    end
end
function v_u_1.lerp(_, p16, p17, p18)
    return p16 * (1 - p18) + p17 * p18
end
function v_u_1.handle_perc(_, p19, p20)
    return p19 * (p20 / 100)
end
function v_u_1.get_damage_total(_, p21, p22, p23, p24)
    -- upvalues: (copy) v_u_1, (copy) v_u_2
    local v25 = p21:FindFirstChild("player_skills")
    local v26 = p21:FindFirstChild("player_specs")
    local v27 = p22.damage
    local v28 = p22.falloff_damage
    local v29
    if p22.falloff <= p23.distance then
        if v25:FindFirstChild("pistols_no_falloff") and p22.large == false then
            if p22.special == "melee" then
                v29 = v28
            else
                v29 = v27
            end
        else
            v29 = v28
        end
    else
        v29 = v27
    end
    if v25:FindFirstChild("headshot_ignore_falloff") and (v28 < v27 and p23.part_that_hit) then
        if p23.part_that_hit.Name == "Head" then
            v29 = v27
        end
    end
    if v25:FindFirstChild("headshot_bonus_damage") and (p23.part_that_hit and p23.part_that_hit.Name == "Head") then
        local v30 = v29 + v_u_1:handle_perc(v29, v25.headshot_bonus_damage.Value)
        v29 = math.ceil(v30)
    end
    if v26:FindFirstChild("armour_havearmour_damage") and p21.Humanoid:FindFirstChild("plate_resist") == nil then
        local v31 = v29 + v_u_1:handle_perc(v29, v26.armour_havearmour_damage.Value)
        v29 = math.ceil(v31)
    end
    if v25:FindFirstChild("box_damage_boost") and p22.special ~= "melee" then
        local v32 = v29 + v_u_1:handle_perc(v29, 75)
        v29 = math.ceil(v32)
    end
    if v25:FindFirstChild("gun_base_damage") and p22.special ~= "melee" then
        local v33 = v29 + v_u_1:handle_perc(v29, v25.gun_base_damage.Value)
        v29 = math.ceil(v33)
    end
    if v25:FindFirstChild("medic_atkbuff") then
        local v34 = v29 + v_u_1:handle_perc(v29, v25.medic_atkbuff.Value)
        v29 = math.ceil(v34)
    end
    local v35 = p23.part_that_hit and (p23.part_that_hit.Name == "Left Leg" or p23.part_that_hit.Name == "Right Leg") and true or false
    if game:GetService("RunService"):IsServer() then
        if v25:FindFirstChild("leg_cripple") and v35 == true then
            v_u_2.ai_interact:Fire(p24, "cripple_leg", v25.leg_cripple.Value)
        end
        if v25:FindFirstChild("incendiary_bullets") and p22.special ~= "melee" then
            v_u_2.ai_interact:Fire(p24, "incendiary")
        end
        if v25:FindFirstChild("medic_all_cripple") then
            v_u_2.ai_interact:Fire(p24, "cripple_leg", 0.35)
        end
        if v25:FindFirstChild("melee_damage_lifeleech") and p22.special == "melee" then
            local v36 = p21.Humanoid
            local v37 = p21.Humanoid.Health
            local v38 = v_u_1:handle_perc(v27, v25.melee_damage_lifeleech.Value)
            v36.Health = v37 + math.ceil(v38)
        end
        if v25:FindFirstChild("cam_bonus_flashed") and (p24:FindFirstChild("Head") and (p24.Head:FindFirstChild("flash_sparkle") and p24.Head.flash_sparkle.Enabled == true)) then
            local v39 = v29 + v_u_1:handle_perc(v29, v25.cam_bonus_flashed.Value)
            v29 = math.ceil(v39)
        end
        if v25:FindFirstChild("medic_healtharmour_leech") then
            local v40 = p21.Humanoid
            local v41 = p21.Humanoid.Health
            local v42 = v_u_1:handle_perc(v27, v25.medic_healtharmour_leech.Value)
            v40.Health = v41 + math.ceil(v42)
            if p21.Humanoid:FindFirstChild("plate_resist") and p21.Humanoid.plate_resist.Value < p21.Humanoid.plate_resist.max.Value then
                local v43 = p21.Humanoid.plate_resist
                local v44 = p21.Humanoid.plate_resist.Value
                local v45 = v_u_1:handle_perc(v27, v25.medic_healtharmour_leech.Value)
                v43.Value = v44 + math.ceil(v45)
                if p21.Humanoid.plate_resist.Value > p21.Humanoid.plate_resist.max.Value then
                    p21.Humanoid.plate_resist.Value = p21.Humanoid.plate_resist.max.Value
                end
            end
        end
        if v25:FindFirstChild("medic_teammate_linked") and (v25.medic_teammate_linked.Value and (v25.medic_teammate_linked.Value:FindFirstChild("Humanoid") and v25.medic_teammate_linked.Value.Humanoid.Health > 0)) then
            local v46 = v25.medic_teammate_linked.Value.Humanoid
            local v47 = v46.Health
            local v48 = v_u_1:handle_perc(v27, 4)
            v46.Health = v47 + math.ceil(v48)
            if v46:FindFirstChild("plate_resist") and v46.plate_resist.Value < v46.plate_resist.max.Value then
                local v49 = v46.plate_resist
                local v50 = v46.plate_resist.Value
                local v51 = v_u_1:handle_perc(v27, 4)
                v49.Value = v50 + math.ceil(v51)
                if v46.plate_resist.Value > v46.plate_resist.max.Value then
                    v46.plate_resist.Value = v46.plate_resist.max.Value
                end
            end
            local v52 = p21.Humanoid
            local v53 = v52.Health
            local v54 = v_u_1:handle_perc(v27, 4)
            v52.Health = v53 + math.ceil(v54)
            if v52:FindFirstChild("plate_resist") and v52.plate_resist.Value < v52.plate_resist.max.Value then
                local v55 = v52.plate_resist
                local v56 = v52.plate_resist.Value
                local v57 = v_u_1:handle_perc(v27, 4)
                v55.Value = v56 + math.ceil(v57)
                if v52.plate_resist.Value > v52.plate_resist.max.Value then
                    v52.plate_resist.Value = v52.plate_resist.max.Value
                end
            end
        end
        if v25:FindFirstChild("pistol_lifeleech") and (p22.special ~= "melee" and p22.large == false) then
            local v58 = p21.Humanoid
            local v59 = p21.Humanoid.Health
            local v60 = v_u_1:handle_perc(v27, v25.pistol_lifeleech.Value)
            v58.Health = v59 + math.ceil(v60)
        end
        if v25:FindFirstChild("basedamage_to_armour") and (p21.Humanoid:FindFirstChild("plate_resist") and p21.Humanoid.plate_resist.Value < p21.Humanoid.plate_resist.max.Value) then
            local v61 = p21.Humanoid.plate_resist
            local v62 = p21.Humanoid.plate_resist.Value
            local v63 = v_u_1:handle_perc(v27, v25.basedamage_to_armour.Value)
            v61.Value = v62 + math.ceil(v63)
            if p21.Humanoid.plate_resist.Value > p21.Humanoid.plate_resist.max.Value then
                p21.Humanoid.plate_resist.Value = p21.Humanoid.plate_resist.max.Value
            end
        end
        local v64 = 0
        if v25:FindFirstChild("pistol_crit_chance") and (p22.large == false and p22.special ~= "melee") then
            v64 = v64 + v25.pistol_crit_chance.Value
        end
        if v25:FindFirstChild("gun_base_crit") and p22.special ~= "melee" then
            v64 = v64 + v25.gun_base_crit.Value
        end
        local v65 = v25:FindFirstChild("medic_massivebuff") and 100 or v64
        if v65 > 0 and math.random(1, 100) <= v65 then
            local v66 = v29 * 3
            v29 = math.ceil(v66)
            v_u_2.effects_relay:FireAllClients("critical_hit", {
                ["position"] = p24.Head.Position
            })
        end
    end
    if v25:FindFirstChild("leg_full_damage") then
        v35 = false
    end
    if v25:FindFirstChild("fists_damage_bonus") and (p21:FindFirstChildOfClass("Tool") and (p21:FindFirstChildOfClass("Tool").Name == "Fists" and p22.name == "Fists")) then
        local v67 = v29 + v_u_1:handle_perc(v29, v25.fists_damage_bonus.Value)
        v29 = math.ceil(v67)
    end
    if v25:FindFirstChild("inner_range_bonus_damage") and (p23.distance <= v25.inner_range_size.Value and p22.special ~= "melee") then
        local v68 = v29 + v_u_1:handle_perc(v29, v25.inner_range_bonus_damage.Value)
        v29 = math.ceil(v68)
    end
    if v25:FindFirstChild("melee_damage_boost") and p22.special == "melee" then
        local v69 = v29 + v_u_1:handle_perc(v29, v25.melee_damage_boost.Value)
        v29 = math.ceil(v69)
    end
    if v25:FindFirstChild("pistol_damage") and (p22.special ~= "melee" and p22.large == false) then
        local v70 = v29 + v_u_1:handle_perc(v29, v25.pistol_damage.Value)
        v29 = math.ceil(v70)
    end
    if v25:FindFirstChild("elite_damage_bonus") and (p24:FindFirstChild("ai_type") and (p24.ai_type.Value ~= "" and (p24.ai_type.Value ~= " " and (p24.ai_type.Value ~= "creature" and p24.ai_type.Value ~= "armoured")))) then
        local v71 = v29 + v_u_1:handle_perc(v29, v25.elite_damage_bonus.Value)
        v29 = math.ceil(v71)
    end
    if v25:FindFirstChild("lowhealth_damage") and p21.Humanoid.Health <= p21.Humanoid.MaxHealth / 2 then
        local v72 = v29 + v_u_1:handle_perc(v29, v25.lowhealth_damage.Value)
        v29 = math.ceil(v72)
    end
    if v35 == true then
        local v73 = v29 / 1.5
        v29 = math.ceil(v73)
    end
    if p24:FindFirstChild("gladiator") and p22.special == "melee" then
        local v74 = v29 / 2
        v29 = math.ceil(v74)
    end
    if game:GetService("RunService"):IsServer() then
        local v75 = p21:FindFirstChildOfClass("Tool")
        if p24.Humanoid.Health > 0 and p24.Humanoid.Health - v29 <= 0 then
            if v25:FindFirstChild("melee_damage_kill_lifeleech") and p22.special == "melee" then
                local v76 = p21.Humanoid
                local v77 = p21.Humanoid.Health
                local v78 = v_u_1:handle_perc(v27, v25.melee_damage_kill_lifeleech.Value)
                v76.Health = v77 + math.ceil(v78)
            end
            if v25:FindFirstChild("pistol_boostspeed") and (p22.large == false and p22.special ~= "melee") then
                v_u_2.ability_handler:FireClient(game.Players:GetPlayerFromCharacter(p21), "speedboost_pistol", v25.pistol_boostspeed.Value)
            end
            if v25:FindFirstChild("credits_bonus_kill") and p22.special ~= "melee" then
                p21.credits.Value = p21.credits.Value + v25.credits_bonus_kill.Value
                v_u_2.game_handler:FireClient(game.Players:GetPlayerFromCharacter(p21), "add_credits", v25.credits_bonus_kill.Value)
            end
            if v25:FindFirstChild("pistols_bonus_money") and (p22.large == false and p22.special ~= "melee") then
                p21.credits.Value = p21.credits.Value + v25.pistols_bonus_money.Value
                v_u_2.game_handler:FireClient(game.Players:GetPlayerFromCharacter(p21), "add_credits", v25.pistols_bonus_money.Value)
            end
            if v75 then
                if v75.Name == "Karambit Blade" and p22.name == "Karambit Blade" then
                    p21.Humanoid.Health = p21.Humanoid.Health + p22.special_attributes.heal_on_kill
                end
                if v75.Name == "KA-BAR D2" and p22.name == "KA-BAR D2" then
                    v_u_2.ability_handler:FireClient(game.Players:GetPlayerFromCharacter(p21), "speedboost_pistol", p22.special_attributes.speed_on_kill)
                end
                if v75.Name == "Combat Bayonet" and (p22.name == "Combat Bayonet" and (p21.Humanoid:FindFirstChild("plate_resist") and p21.Humanoid.plate_resist.Value < p21.Humanoid.plate_resist.max.Value)) then
                    p21.Humanoid.plate_resist.Value = p21.Humanoid.plate_resist.Value + p22.special_attributes.armour_on_kill
                    if p21.Humanoid.plate_resist.Value > p21.Humanoid.plate_resist.max.Value then
                        p21.Humanoid.plate_resist.Value = p21.Humanoid.plate_resist.max.Value
                    end
                end
                if v75:FindFirstChild("stamina") and v75.stamina.Value < v75.stamina.max.Value then
                    local v79 = p24.Humanoid.MaxHealth * 0.05
                    v75.stamina.Value = v75.stamina.Value + math.ceil(v79)
                    if v75.stamina.Value > v75.stamina.max.Value then
                        v75.stamina.Value = v75.stamina.max.Value
                    end
                end
            end
        end
        if v75 then
            if v75.Name == "M2 Stun Baton" and p22.name == "M2 Stun Baton" then
                v_u_2.ai_interact:Fire(p24, "stunned")
            end
            if v75:FindFirstChild("stamina") and v75.stamina.Value < v75.stamina.max.Value then
                local v80 = v75.stamina
                local v81 = v75.stamina.Value
                local v82 = v75.stamina.max.Value * 0.05
                v80.Value = v81 + math.ceil(v82)
                if v75.stamina.Value > v75.stamina.max.Value then
                    v75.stamina.Value = v75.stamina.max.Value
                end
            end
        end
    end
    return p24:FindFirstChild("invuln") and 0 or v29, v35
end
function v_u_1.soundHandler(_, p_u_83, p84)
    local v85 = game.ReplicatedStorage.sound_library
    if p_u_83.directory then
        for _, v86 in ipairs(p_u_83.directory) do
            v85 = v85:FindFirstChild(v86)
        end
    end
    local v_u_87 = v85:FindFirstChild(p_u_83.soundfile)
    if v_u_87 then
        if workspace.CurrentCamera and (p_u_83.location and (p_u_83.location.Parent and (p_u_83.location.Parent:IsA("BasePart") and (workspace.CurrentCamera.CFrame.p - p_u_83.location.Parent.Position).magnitude > v_u_87.RollOffMaxDistance + 50))) then
            return
        end
        v_u_87 = v_u_87:Clone()
        if p_u_83.pitch then
            v_u_87.Pitch = p_u_83.pitch
        end
        if p_u_83.pitchvariation then
            local v88 = p_u_83.pitchvariation
            if typeof(v88) == "number" then
                local v89 = math.random(-p_u_83.pitchvariation * 100, p_u_83.pitchvariation * 100) / 100
                v_u_87.Pitch = v_u_87.Pitch + v89
            end
        end
        if p_u_83.pitch_adjust then
            v_u_87.Pitch = v_u_87.Pitch + p_u_83.pitch_adjust
        end
        if p_u_83.volume_adjust then
            v_u_87.Volume = v_u_87.Volume + p_u_83.volume_adjust
        end
        if p_u_83.location then
            v_u_87.Parent = p_u_83.location
        else
            v_u_87.Parent = workspace
        end
        if p_u_83.soundgroup then
            v_u_87.SoundGroup = game:GetService("SoundService"):FindFirstChild(p_u_83.soundgroup)
        else
            v_u_87.SoundGroup = game:GetService("SoundService"):FindFirstChild("mainSoundGroup")
        end
        v_u_87:Play()
        if v_u_87.Looped == false then
            spawn(function()
                -- upvalues: (copy) p_u_83, (ref) v_u_87
                if p_u_83.location then
                    local v90 = 1
                    for _, v91 in ipairs(p_u_83.location:GetChildren()) do
                        local v92
                        if v91.Name == v_u_87.Name then
                            v90 = v90 + 1
                            v92 = true
                        else
                            v92 = false
                        end
                        if v90 >= 8 and (v91 ~= v_u_87 and (v91:IsA("Sound") and (v91.TimePosition > 0.1 and v92 == true))) then
                            v91:Destroy()
                        end
                    end
                end
            end)
            v_u_87.Ended:connect(function()
                -- upvalues: (ref) v_u_87
                v_u_87:Destroy()
            end)
        end
    end
    if p84 ~= true then
        workspace.mainGame.remotes.audio_relay:FireServer(p_u_83)
    end
    return v_u_87
end
function v_u_1.deepCopy(_, p93)
    -- upvalues: (copy) v_u_1
    local v94 = {}
    for v95, v97 in pairs(p93) do
        if type(v97) == "table" then
            local v97 = v_u_1:deepCopy(v97)
        end
        v94[v95] = v97
    end
    return v94
end
function v_u_1.raycastline(_, p98)
    local v99 = p98.layermask == nil and {} or p98.layermask
    local v100 = {}
    for _ = 1, 200 do
        local v101, v102, v103 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p98.point, p98.destination.unit * (p98.range or 999.999)), v100)
        if not v101 then
            return v101, v102, v103
        end
        local v104 = true
        for _, v105 in pairs(v99) do
            if v101:IsDescendantOf(v105) then
                table.insert(v100, v101)
                v104 = false
            end
        end
        if v101.Locked == true and p98.hit_locked == nil then
            table.insert(v100, v101)
            v104 = false
        end
        if v104 == true then
            return v101, v102, v103
        end
    end
end
function v_u_1.inLoS(_, p106)
    -- upvalues: (copy) v_u_1
    return v_u_1:raycastline({
        ["point"] = p106.pointB,
        ["destination"] = -(p106.pointB - p106.pointA),
        ["range"] = p106.range,
        ["layermask"] = p106.mask,
        ["hit_locked"] = p106.hit_locked
    })
end
return v_u_1
