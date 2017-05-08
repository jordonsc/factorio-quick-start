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
	
	kits["small"] = {}
	kits["small"]["quickbar"] = {
		{1, "transport-belt"},
		{2, "underground-belt"},
		{3, "splitter"},
		{4, "inserter"},
		{5, "medium-electric-pole"},
		{6, "deconstruction-planner"},
		{10, "car"}
	}
	kits["small"]["items"] = {
		{"steel-axe", 10},
		{"iron-plate", 192},
		{"copper-plate", 200},
		{"iron-gear-wheel", 50},
		{"transport-belt", 500},
		{"splitter", 50},
		{"underground-belt", 50},
		{"burner-mining-drill", 20},
		{"coal", 100}
	}
		
	kits["medium"] = {}
	kits["medium"]["quickbar"] = {
		{1, "transport-belt"},
		{2, "underground-belt"},
		{3, "splitter"},
		{4, "inserter"},
		{5, "medium-electric-pole"},
		{6, "deconstruction-planner"},
		{10, "car"}
	}
	kits["medium"]["items"] = {
		{"steel-axe", 10},
		{"iron-plate", 592},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 200},
		{"transport-belt", 1100},
		{"underground-belt", 50},
		{"splitter", 50},
		{"stone-furnace", 100},
		{"assembling-machine-1", 20},
		{"inserter", 300},
		{"long-handed-inserter", 50},
		{"steel-chest", 50},
		{"electric-mining-drill", 50},
		{"medium-electric-pole", 200},
		{"boiler", 10},
		{"steam-engine", 20},
		{"offshore-pump", 1},
		{"pipe-to-ground", 50},
		{"pipe", 50},
		{"car", 1},
		{"coal", 200},
		{"construction-robot", 50},
		{"lab", 10},
		{"deconstruction-planner", 1},
		{"power-armor", 1}
	}
	kits["medium"]["armorItems"] = {
		{"fusion-reactor-equipment"},
		{"personal-roboport-equipment"},
		{"personal-roboport-equipment"},
		{"personal-roboport-equipment"},
		{"personal-roboport-equipment"},
		{"personal-roboport-equipment"},
		{"battery-equipment"},
		{"battery-equipment"},
		{"battery-equipment"}
	}
	
	kits["big"] = {}
	kits["big"]["quickbar"] = {
		{1, "transport-belt"},
		{2, "underground-belt"},
		{3, "splitter"},
		{4, "inserter"},
		{5, "medium-electric-pole"},
		{6, "deconstruction-planner"},
		{10, "car"}
	}
	kits["big"]["items"] = {
		{"power-armor", 1},
		{"steel-axe", 10},
		{"iron-plate", 592},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 200},
		{"advanced-circuit", 200},
		{"transport-belt", 1500},
		{"underground-belt", 50},
		{"splitter", 50},
		{"steel-furnace", 100},
		{"assembling-machine-2", 100},
		{"inserter", 300},
		{"long-handed-inserter", 50},
		{"steel-chest", 50},
		{"electric-mining-drill", 50},
		{"medium-electric-pole", 400},
		{"big-electric-pole", 100},
		{"logistic-chest-requester", 100},
		{"logistic-chest-passive-provider", 100},
		{"boiler", 20},
		{"steam-engine", 40},
		{"offshore-pump", 10},
		{"pipe-to-ground", 100},
		{"pipe", 100},
		{"chemical-plant", 20},
		{"oil-refinery", 10}, 
		{"car", 1},
		{"coal", 50},
		{"roboport", 20},
		{"construction-robot", 50},
		{"logistic-robot", 300},
		{"lab", 10},
		{"deconstruction-planner", 1}
	}
	kits["big"]["armorItems"] = kits["medium"]["armorItems"]
	kits["big"]["technologies"] = {
		{"automation"},
		{"steel-processing"},
		{"automation-2"},
		{"oil-processing"},
		{"plastics"},
		{"advanced-electronics"},
		{"sulfur-processing"},
		{"battery"},
		{"electronics"},
		{"engine"},
		{"electric-engine"},
		{"flying"},
		{"robotics"},
		{"logistic-robotics"},
		{"construction-robotics"},
		{"logistic-system"}
	}

    -- Mega
    kits["mega"] = {}
	kits["mega"]["quickbar"] = {
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
	kits["mega"]["items"] = {
		{"power-armor-mk2", 1},
		{"steel-axe", 10},
		{"iron-plate", 500},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 400},
		{"advanced-circuit", 200},
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
		{"chemical-plant", 20},
		{"oil-refinery", 10},
		{"construction-robot", 150},
        {"lab", 10},
        {"stone-wall", 300},
        {"gate", 100},
        {"deconstruction-planner", 1},
        {"car", 1}
    }
	kits["mega"]["armorItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"}
    }

	kits["mega"]["technologies"] = {
		{"circuit-network"},
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

    -- end kits
	
	local kitSetting = settings.startup["quick-start-kit"].value
	local kit = kits[kitSetting]
	if kit == nil then
		kit = kits["mega"]
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
	
	if kit["armorItems"] ~= nil then
		-- Find armor in one of the inventories
		-- Usually ends up in the armor slot. But that one does not exist in sandbox mode
		for k,v in pairs(inventories) do
			local inventory = player.get_inventory(v)
			if inventory ~= nil then
				local armor = inventory.find_item_stack("power-armor")
				if armor ~= nil then
					-- Add items to armor grid
					local grid = armor.grid
					for k,v in pairs(kit["armorItems"]) do
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