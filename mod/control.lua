script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	local inventories = {
		defines.inventory.player_armor,
		defines.inventory.player_main,
		defines.inventory.player_quickbar,
		defines.inventory.player_guns,
		defines.inventory.player_ammo,
		defines.inventory.player_tools,
		defines.inventory.player_vehicle,
		defines.inventory.player_player_trash
	}
	
	-- Setup kit presets
	local kits = {}

    -- Alpha kit: quickstart + annoying stuff
    kits["alpha"] = {}

	kits["alpha"]["armourType"] = "power-armor-mk2"

	kits["alpha"]["quickbar"] = {
		{1, "fast-transport-belt"},
		{2, "fast-underground-belt"},
		{3, "fast-splitter"},
		{4, "fast-inserter"},
		{5, "long-handed-inserter"},
		{6, "filter-inserter"},
		{7, "stack-filter-inserter"},
		{8, "small-lamp"},
		{9, "steel-chest"},
		{10, "deconstruction-planner"}
	}

	kits["alpha"]["items"] = {
		{kits["alpha"]["armourType"], 1},
		{"steel-axe", 10},
		{"iron-plate", 500},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 400},
		{"fast-transport-belt", 1500},
		{"fast-underground-belt", 150},
		{"fast-splitter", 150},
		{"electric-furnace", 100},
		{"assembling-machine-2", 100},
		{"fast-inserter", 300},
		{"long-handed-inserter", 150},
		{"steel-chest", 250},
		{"electric-mining-drill", 150},
		{"medium-electric-pole", 400},
		{"big-electric-pole", 100},
		{"substation", 100},
		{"boiler", 20},
		{"steam-engine", 40},
		{"offshore-pump", 10},
		{"pipe-to-ground", 200},
		{"pipe", 200},
		{"construction-robot", 150},
        {"stone-wall", 300},
        {"gate", 50},
        {"deconstruction-planner", 1},
        {"car", 1}
    }

	kits["alpha"]["armourItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"}
    }

	kits["alpha"]["technologies"] = {
		{"toolbelt"},
		{"character-logistic-slots-1"},
		{"character-logistic-slots-2"},
		{"character-logistic-slots-3"},
		{"character-logistic-slots-4"},
		{"character-logistic-slots-5"},
		{"character-logistic-slots-6"},
		{"character-trash-slots-1"},
		{"character-trash-slots-2"},
		{"worker-robots-speed-1"},
		{"worker-robots-speed-2"},
		{"worker-robots-speed-3"},
		{"worker-robots-speed-4"},
		{"worker-robots-speed-5"},
		{"worker-robots-speed-6"},
		{"worker-robots-storage-1"},
		{"worker-robots-storage-2"},
		{"worker-robots-storage-3"}
	}

    -- Bravo kit: you lazy bastard.
    kits["bravo"] = kits["alpha"]

	table.insert(kits["bravo"]["items"], {"advanced-circuit", 200})
	table.insert(kits["bravo"]["items"], {"chemical-plant", 20})
	table.insert(kits["bravo"]["items"], {"oil-refinery", 10})
	table.insert(kits["bravo"]["items"], {"lab", 10})
    table.insert(kits["bravo"]["items"], {"rail", 300})
    table.insert(kits["bravo"]["items"], {"rail-chain-signal", 50})
    table.insert(kits["bravo"]["items"], {"rail-signal", 50})
    table.insert(kits["bravo"]["items"], {"train-stop", 10})
    table.insert(kits["bravo"]["items"], {"locomotive", 10})
    table.insert(kits["bravo"]["items"], {"cargo-wagon", 10})
    table.insert(kits["bravo"]["items"], {"fluid-wagon", 5})

    table.insert(kits["bravo"]["technologies"], {"circuit-network"})

    -- Omega kit: just the super basics
    kits["omega"] = {}

	kits["omega"]["quickbar"] = {
		{1, "transport-belt"},
		{2, "underground-belt"},
		{3, "splitter"},
		{4, "inserter"},
		{10, "deconstruction-planner"}
	}

	kits["omega"]["items"] = {
		{"steel-axe", 10},
		{"iron-plate", 100},
		{"copper-plate", 100},
		{"iron-gear-wheel", 100},
		{"transport-belt", 1500},
		{"underground-belt", 150},
		{"splitter", 150},
		{"assembling-machine-1", 100},
		{"inserter", 300},
		{"steel-chest", 50},
		{"electric-mining-drill", 50},
		{"medium-electric-pole", 100},
		{"boiler", 20},
		{"steam-engine", 40},
		{"offshore-pump", 10},
		{"pipe-to-ground", 100},
		{"pipe", 100},
        {"deconstruction-planner", 1},
    }

    -- end kits
	
	local kitSetting = settings.startup["quick-start-kit"].value
	local kit = kits[kitSetting]
	if kit == nil then
		kit = kits["alpha"]
	end
	
	-- Find quickbar (usually player_quickbar, but god_quickbar in sandbox mode)
	local quickbar = player.get_inventory(defines.inventory.player_quickbar)
	if quickbar ~= nil and not quickbar.can_set_filter(1, "transport-belt") then
		quickbar = player.get_inventory(defines.inventory.god_quickbar)
	end
	
	-- Setup quickbar favorites
	if quickbar ~= nil and quickbar.can_set_filter(1, "transport-belt") ~= nil then
		quickbar.clear()
		for k,v in pairs(kit["quickbar"]) do
			quickbar.set_filter(v[1], v[2])
		end
	end
	
	-- Add items
	for k,v in pairs(kit["items"]) do
		player.insert{name = v[1], count = v[2]}
	end


    -- Kit out armour
	if kit["armourItems"] ~= nil then
		-- Find armour in one of the inventories
		-- Usually ends up in the armour slot. But that one does not exist in sandbox mode
		for k,v in pairs(inventories) do
			local inventory = player.get_inventory(v)
			if inventory ~= nil then
				local armor = inventory.find_item_stack(kit["armourType"])
				if armor ~= nil then
					-- Add items to armor grid
					local grid = armor.grid
					for k,v in pairs(kit["armourItems"]) do
						grid.put{name = v[1]}
					end
					break
				end
			end
		end
	end
	
	-- Unlock technologies
	if kit["technologies"] ~= nil then
		for k,v in pairs(kit["technologies"]) do
			player.force.technologies[v[1]].researched = true
		end
	end
	
end)
