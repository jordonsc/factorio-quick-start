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

	-- Kit settings - change the loadout here
	local kit = {}

	kit["armourType"] = "power-armor-mk2"

	kit["quickbar"] = {
		{1, "fast-transport-belt"},
		{2, "fast-underground-belt"},
		{3, "fast-splitter"},
		{4, "fast-inserter"},
		{5, "long-handed-inserter"},

		{6, "stone-wall"},
		{7, "gate"},
		{8, "small-lamp"},
		{9, "steel-chest"},
		{10, "deconstruction-planner"},

		{11, "rail"},
        {12, "rail-signal"},
        {13, "rail-chain-signal"},
		{14, "filter-inserter"},
		{15, "stack-filter-inserter"},

		{16, "medium-electric-pole"},
		{17, "big-electric-pole"},
		{18, "substation"},
		{19, "car"},
		{20, "repair-pack"},
	}

	kit["items"] = {
		{ kit["armourType"], 1},
        {"submachine-gun", 1},
        {"piercing-rounds-magazine", 100},

		{"iron-plate", 492},
        {"iron-gear-wheel", 200},
        {"copper-plate", 400},
        {"copper-cable", 400},
        {"electronic-circuit", 400},
		{"fast-transport-belt", 2400},
		{"fast-underground-belt", 150},
		{"fast-splitter", 150},
		{"electric-furnace", 300},
		{"assembling-machine-2", 300},
		{"fast-inserter", 300},
		{"long-handed-inserter", 150},
		{"filter-inserter", 50},
		{"stack-filter-inserter", 50},
		{"steel-chest", 150},
		{"electric-mining-drill", 150},
		{"medium-electric-pole", 150},
		{"big-electric-pole", 100},
		{"substation", 100},
		{"boiler", 20},
		{"steam-engine", 40},
		{"offshore-pump", 10},
		{"pipe-to-ground", 200},
		{"pipe", 200},
		{"construction-robot", 150},
        {"small-lamp", 100},
        {"deconstruction-planner", 1},
        {"repair-pack", 100},
        {"rail", 100},
        {"stone-wall", 100},
        {"gate", 50},
        {"rail-signal", 50},
        {"rail-chain-signal", 50},
    }

    kit["cars"] = {
        {
            {"iron-plate", 2000},
            {"iron-gear-wheel", 1000},
            {"copper-plate", 2000},
            {"copper-cable", 2000},
            {"electronic-circuit", 2000},
            {"rail", 1000},
        },
        {
            {"fast-transport-belt", 3000},
            {"fast-underground-belt", 250},
            {"fast-splitter", 250},
            {"fast-inserter", 250},
            {"long-handed-inserter", 250},
            {"filter-inserter", 250},
            {"steel-chest", 250},
            {"small-lamp", 100},
            {"medium-electric-pole", 300},
            {"big-electric-pole", 300},
            {"substation", 150},
            {"stone-wall", 300},
        },
    }

	kit["armourItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
    }

    kit["technologies"] = {
        {"toolbelt"},
        {"construction-robotics"},
        {"personal-roboport-equipment"},
        {"exoskeleton-equipment"},
        {"character-logistic-slots-1"},
        {"character-logistic-slots-2"},
        {"character-logistic-slots-3"},
        {"character-logistic-slots-4"},
        {"character-logistic-slots-5"},
        {"character-logistic-slots-6"},
        {"auto-character-logistic-trash-slots"},
		{"worker-robots-speed-1"},
		{"worker-robots-speed-2"},
		{"worker-robots-speed-3"},
		{"worker-robots-speed-4"},
		{"worker-robots-speed-5"},
		{"worker-robots-speed-6"},
		{"worker-robots-storage-1"},
		{"worker-robots-storage-2"},
		{"worker-robots-storage-3"},
    }

    -- end kits

	-- Unlock technologies (must come before quickbar)
	if kit["technologies"] ~= nil then
		for k,v in pairs(kit["technologies"]) do
			player.force.technologies[v[1]].researched = true
		end
	end

	-- Add items
	for k,v in pairs(kit["items"]) do
        c = player.insert{name = v[1], count = v[2]}
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

    -- Place some cars full of goodies
    local pos = player.position
    pos.y = pos.y + 2
    pos.x = pos.x - 2

    for i,c in pairs(kit["cars"]) do
        local car = player.surface.create_entity{name="car", position=pos, force=player.force}
        car.insert{name = "solid-fuel", count = 50}
        car.insert{name = "piercing-rounds-magazine", count = 100}

        pos.x = pos.x + 4

        for k,v in pairs(c) do
            car.insert{name = v[1], count = v[2]}
        end
    end

end)
