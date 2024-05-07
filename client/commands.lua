---@diagnostic disable: undefined-global

local function toggleComp(hash, item, key)
	IsPedReadyToRender()
	if IsMetaPedUsingComponent(hash) then
		RemoveTagFromMetaPed(hash)
		UpdatePedVariation()
		SetResourceKvp(tostring(item.comp), "true")
		TriggerEvent("vorp_character:Client:OnClothingRemoved", key, item.comp)
	else
		ApplyShopItemToPed(item.comp)
		UpdatePedVariation()
		if item.drawable then
			SetMetaPedTag(PlayerPedId(), item.drawable, item.albedo, item.normal, item.material, item.palette, item.tint0, item.tint1, item.tint2)
		end
		SetResourceKvp(tostring(item.comp), "false")
		TriggerEvent("vorp_character:Client:OnClothingAdded", key, item.comp)
	end
	UpdatePedVariation()
end

function play_anim(dict, name, time, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 1.0, time, flag, 0, true, 0, false, 0, false)  
end

for key, v in pairs(Config.commands) do
	RegisterCommand(v.command, function()
		toggleComp(Config.HashList[key], CachedComponents[key], key)
		if key == "GunBelt" then
			toggleComp(Config.HashList.Holster, CachedComponents.Holster, key)
		end

		if key == "Vest" and IsMetaPedUsingComponent(Config.HashList.Shirt) then
			local item = CachedComponents.Shirt
			if item.drawable then
				SetTextureOutfitTints(PlayerPedId(), 'shirts_full', item)
			end
		end

		if key == "Coat" then
			if IsMetaPedUsingComponent(Config.HashList.Vest) then
				local item = CachedComponents.Vest
				if item.drawable then
					SetTextureOutfitTints(PlayerPedId(), 'vests', item)
				end
			end

			if IsMetaPedUsingComponent(Config.HashList.Shirt) then
				local item = CachedComponents.Shirt
				if item.drawable then
					SetTextureOutfitTints(PlayerPedId(), 'shirts_full', item)
				end
			end
		end
	end, false)
end

RegisterCommand("neckwear", function() -- Need take on and put on animation
	if not neckwearoff then
		play_anim('mech_inventory@clothing@bandana', 'neck_2_satchel', 3500, 25)
		Citizen.Wait(1900)
		toggleComp(0x5FC29285, CachedComponents.NeckWear)
		neckwearoff = true
	else
		play_anim('mech_inventory@clothing@bandana', 'satchel_2_neck', 4000, 25)
		Citizen.Wait(3900)
		toggleComp(0x5FC29285, CachedComponents.NeckWear)
		neckwearoff = true
	end
	-- //0xFB4891BD7578CDC1   -- _IS_PED_COMPONENT_EQUIPPED(ped_id,category_id)
	--Citizen.InvokeNative(0xFB4891BD7578CDC1 ,PlayerPedId(), 0x9925C067)  -- for example, check if hat is on.
end)

RegisterCommand("belt", function()
	play_anim('cnv_camp@rcdew@cnv@ccchr1', 'john_action_a', 1000, 25)
	Citizen.Wait(1000)
	toggleComp(0xA6D134C6, CachedComponents.Belt)
end)

RegisterCommand("gunbelt", function()
	play_anim('cnv_camp@rcdew@cnv@ccchr1', 'john_action_a', 1000, 25)
	Citizen.Wait(1000)
	toggleComp(0x9B2C8B89, CachedComponents.Gunbelt)
	toggleComp(0xB6B6122D, CachedComponents.Holster)
	toggleComp(0xFAE9107F, CachedComponents.Buckle)
	toggleComp(0xF1542D11, CachedComponents.GunbeltAccs)
end)

RegisterCommand("gloves", function()
	play_anim('mech_loco_m@character@arthur@fidgets@item_selection@gloves', 'gloves_b', 2000, 25)
	Citizen.Wait(1900)
	toggleComp(0xEABE0032, CachedComponents.Glove)
end)

RegisterCommand("hat", function()
	play_anim('mech_loco_m@character@arthur@fidgets@weather@sunny_hot@unarmed@variations@hat', 'hat_cool_c', 1000, 25)
    Citizen.Wait(950)
	toggleComp(0x9925C067, CachedComponents.Hat)
end)

RegisterCommand("ccoat", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 5000, 25)
    Citizen.Wait(4500)
	toggleComp(0x0662AC34, CachedComponents.CoatClosed)
end)

RegisterCommand("eyewear", function()
	play_anim('mech_inventory@binoculars', 'look', 600, 25)
	Citizen.Wait(600)
	toggleComp(0x5E47CA6, CachedComponents.EyeWear)
end)

RegisterCommand("mask", function()
	play_anim('mech_loco_m@character@arthur@dehydrated@unarmed@idle@fidgets', 'idle_i', 1000, 25)
	Citizen.Wait(1000)
	toggleComp(0x7505EF42, CachedComponents.Mask)
end)

RegisterCommand("spats", function()
	play_anim('mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle', 'idle', 1000, 1)
	Citizen.Wait(1000)
	toggleComp(0x514ADCEA, CachedComponents.Spats)
end)

RegisterCommand("necktie", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_a', 3000, 25)
	Citizen.Wait(3000)
	toggleComp(0x7A96FACA, CachedComponents.NeckTies)
end)

RegisterCommand("shirt", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 3000, 25)
	Citizen.Wait(3000)
	toggleComp(0x2026C46D, CachedComponents.Shirt)
end)

RegisterCommand("skirt", function()
	play_anim('script_re@burning_bodies', 'push_two_bodies_undertaker', 3000, 25)
	Citizen.Wait(2900)
	toggleComp(0x8E84A2AA, CachedComponents.Skirt)
end)

RegisterCommand("pants", function()
	play_anim('script_re@burning_bodies', 'push_two_bodies_undertaker', 3000, 25)
	Citizen.Wait(2900)
	toggleComp(0x1D4C528A, CachedComponents.Pant)
end)

RegisterCommand("suspenders", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_02', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0x877A2CF7, CachedComponents.Suspender)
end)

RegisterCommand("vest", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 5000, 25)
	Citizen.Wait(4500)
	toggleComp(0x485EE834, CachedComponents.Vest)
end)

RegisterCommand("coat", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 5000, 25)
	Citizen.Wait(4500)
	toggleComp(0xE06D30CE, CachedComponents.Coat)
end)

RegisterCommand("poncho", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_01', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0xAF14310B, CachedComponents.Poncho)
end)

RegisterCommand("cloak", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_01', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0x3C1A74CD, CachedComponents.Cloak)
end)

RegisterCommand("gauntlet", function()
	play_anim('mech_loco_m@character@arthur@fidgets@item_selection@gloves', 'gloves_b', 2000, 25)
	Citizen.Wait(1900)
	toggleComp(0x91CE9B20, CachedComponents.Gauntlets)
end)

RegisterCommand("boots", function()
	play_anim('mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle', 'idle', 1000, 1)
	Citizen.Wait(950)
	toggleComp(0x777EC6EF, CachedComponents.Boots)
	toggleComp(0x18729F39, CachedComponents.Spurs)
end)

RegisterCommand("loadout", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_01', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0x83887E88, CachedComponents.Loadouts)
end)

RegisterCommand("satchels", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_01', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0x94504D26, CachedComponents.Satchels)
end)

RegisterCommand("accessories", function()
	play_anim('script_proc@loansharking@undertaker@female_mourner', 'idle_01', 1000, 25)
	Citizen.Wait(950)
	toggleComp(0x79D7DF96, CachedComponents.Accessories)
end)

RegisterCommand("bracelet", function()
	play_anim('mech_loco_m@character@arthur@fidgets@item_selection@gloves', 'gloves_b', 2000, 25)
	Citizen.Wait(1900)
	toggleComp(0x7BC10759, CachedComponents.Bracelet)
end)

RegisterCommand("chaps", function()
	play_anim('script_re@burning_bodies', 'push_two_bodies_undertaker', 3000, 25)
	Citizen.Wait(2900)
	toggleComp(0x3107499B, CachedComponents.Chap)
end)

RegisterCommand("spurs", function()
	play_anim('mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle', 'idle', 1000, 1)
	Citizen.Wait(950)
	toggleComp(0x18729F39, CachedComponents.Spurs)
end)

RegisterCommand("armor", function()
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 2000, 25)
	Citizen.Wait(1900)
	toggleComp(0x72E6EF74, CachedComponents.armor)
end)

RegisterCommand("ringsL", function()
	if CachedComponents.RingLh.comp ~= -1 then
		return
	end
	play_anim('mech_loco_m@character@arthur@fidgets@item_selection@gloves', 'gloves_a', 2000, 25)
	toggleComp(0x7A6BBD0B, CachedComponents.RingLh, "RingLh")
end, false)

RegisterCommand("ringsR", function()
	if CachedComponents.RingRh.comp ~= -1 then
		return
	end
	play_anim('mech_loco_m@character@arthur@fidgets@item_selection@gloves', 'gloves_a', 2000, 25)
	toggleComp(0xF16A1D23, CachedComponents.RingRh, "RingRh")
end, false)

RegisterCommand("undress", function()
	if not next(CachedComponents) then
		return
	end
	play_anim('mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle', 'idle', 1000, 1)
	Citizen.Wait(500)
	play_anim('script_re@burning_bodies', 'push_two_bodies_undertaker', 2000, 25)
	Citizen.Wait(2000)
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 2000, 25)
	Citizen.Wait(2000)
	play_anim('mech_loco_m@character@arthur@fidgets@weather@sunny_hot@unarmed@variations@hat', 'hat_cool_c', 1000, 25)
	Citizen.Wait(500)
	IsPedReadyToRender()
	for Category, Components in pairs(CachedComponents) do
		if Components.comp ~= -1 then
			if IsMetaPedUsingComponent(Config.HashList[Category]) then
				RemoveTagFromMetaPed(Config.HashList[Category])
			end
		end
	end
	UpdatePedVariation()
end, false)

RegisterCommand("dress", function()
	if not next(CachedComponents) then
		return
	end
	play_anim('mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle', 'idle', 1000, 1)
	Citizen.Wait(500)
	play_anim('script_re@burning_bodies', 'push_two_bodies_undertaker', 2000, 25)
	Citizen.Wait(2000)
	play_anim('mech_loco_m@character@arthur@fancy@unarmed@idle@_variations', 'idle_b', 2000, 25)
	Citizen.Wait(2000)
	play_anim('mech_loco_m@character@arthur@fidgets@weather@sunny_hot@unarmed@variations@hat', 'hat_cool_c', 1000, 25)
	Citizen.Wait(500)
	IsPedReadyToRender()
	for _, Components in pairs(CachedComponents) do
		if Components.comp ~= -1 then
			ApplyShopItemToPed(Components.comp)
			UpdatePedVariation()
			if Components.drawable then
				SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material, Components.palette, Components.tint0, Components.tint1, Components.tint2)
			end
			UpdatePedVariation()
		end
	end
end, false)

local bandanaOn = true
RegisterCommand('bandanaon', function(source, args, rawCommand)
	local player = PlayerPedId()
	local Components = CachedComponents.NeckWear
	if Components.comp == -1 then return end
	bandanaOn = not bandanaOn

	if not bandanaOn then
		Citizen.InvokeNative(0xD3A7B003ED343FD9, player, CachedComponents.NeckWear.comp, true, true)
		Citizen.InvokeNative(0xAE72E7DF013AAA61, player, 0, joaat("BANDANA_ON_RIGHT_HAND"), 1, 0, -1.0) --START_TASK_ITEM_INTERACTION
		Wait(750)
		UpdateShopItemWearableState(Components.comp, -1829635046)

		if not bandanaOn and Components.drawable then
			SetTextureOutfitTints(PlayerPedId(), 94259016, Components)
		end

		UpdatePedVariation()
		LocalPlayer.state:set("IsBandanaOn", true, true)
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', CachedComponents.Shirt)
	else
		Citizen.InvokeNative(0xAE72E7DF013AAA61, player, 0, joaat("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1.0) --START_TASK_ITEM_INTERACTION
		Wait(750)
		UpdateShopItemWearableState(Components.comp, joaat("base"))

		if bandanaOn and Components.drawable then
			SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material, Components.palette, Components.tint0, Components.tint1, Components.tint2)
		end

		UpdatePedVariation()
		LocalPlayer.state:set("IsBandanaOn", false, true)
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', CachedComponents.Shirt)
	end
end, false)


local sleeves = true
RegisterCommand("sleeves", function(source, args)
	local Components = CachedComponents.Shirt
	if Components.comp == -1 then return end

	sleeves = not sleeves
	local wearableState = sleeves and joaat("base") or joaat("Closed_Collar_Rolled_Sleeve")
	UpdateShopItemWearableState(Components.comp, wearableState)

	if not sleeves and Components.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', Components)
	end

	if sleeves and Components.drawable then
		SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material,
			Components.palette, Components.tint0, Components.tint1, Components.tint2)
	end

	local value = not sleeves and "false" or "true"
	SetResourceKvp("sleeves", value)
	UpdatePedVariation()
end, false)

local collar = true
RegisterCommand("sleeves2", function(source, args)
	local Components = CachedComponents.Shirt
	if Components.comp == -1 then return end

	collar = not collar
	local wearableState = collar and joaat("base") or joaat("open_collar_rolled_sleeve")
	UpdateShopItemWearableState(Components.comp, wearableState)

	if not collar and Components.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', Components)
	end

	if collar and Components.drawable then
		SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material,
			Components.palette, Components.tint0, Components.tint1, Components.tint2)
	end

	local value = not collar and "false" or "true"
	SetResourceKvp("collar", value)
	UpdatePedVariation()
end, false)

local tuck = true
RegisterCommand("tuck", function(source, args)
	local ComponentB = CachedComponents.Boots
	if ComponentB.comp == -1 then return end
	local ComponentP = CachedComponents.Pant

	tuck = not tuck
	local wearableState = tuck and joaat("base") or -2081918609
	UpdateShopItemWearableState(ComponentB.comp, wearableState)

	if not tuck and ComponentP.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'pants', ComponentP)
	end
	if not tuck and ComponentB.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'boots', ComponentB)
	end

	if tuck and ComponentB.drawable then
		SetMetaPedTag(PlayerPedId(), ComponentB.drawable, ComponentB.albedo, ComponentB.normal, ComponentB.material,
			ComponentB.palette, ComponentB.tint0, ComponentB.tint1, ComponentB.tint2)
	end
	local value = not tuck and "false" or "true"
	SetResourceKvp("tuck", value)
	UpdatePedVariation()
end, false)

function ApplyRolledClothingStatus()
	local value = GetResourceKvpString("sleeves")
	local value2 = GetResourceKvpString("collar")
	local value3 = GetResourceKvpString("tuck")
	if value == "true" then
		sleeves = false
		ExecuteCommand("sleeves")
	else
		sleeves = true
		ExecuteCommand("sleeves")
	end

	if value2 == "true" then
		collar = false
		ExecuteCommand("sleeves2")
	else
		collar = true
		ExecuteCommand("sleeves2")
	end

	if value3 == "true" then
		tuck = false
		ExecuteCommand("tuck")
	else
		tuck = true
		ExecuteCommand("tuck")
	end
end

RegisterCommand("rc", function(source, args, rawCommand)
	local __player = PlayerPedId()
	local hogtied = Citizen.InvokeNative(0x3AA24CCC0D451379, __player)
	local cuffed = Citizen.InvokeNative(0x74E559B3BC910685, __player)
	local dead = IsEntityDead(__player)

	if not Config.CanRunReload() then
		return
	end

	if not hogtied and not cuffed and not dead then
		if not next(CachedSkin) and not next(CachedComponents) then
			return
		end

		if args[1] ~= "" then
			Custom = args[1]
		end
		LocalPlayer.state:set("IsBandanaOn", false, true)
		LoadPlayerComponents(__player, CachedSkin, CachedComponents, false)
	end
end, false)
