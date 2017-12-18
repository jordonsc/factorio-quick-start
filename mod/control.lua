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

	kits["alpha"]["items"] = {
		{kits["alpha"]["armourType"], 1},
		{"steel-axe", 10},
		{"iron-plate", 492},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 400},
		{"fast-transport-belt", 2600},
		{"fast-underground-belt", 150},
		{"fast-splitter", 150},
		{"electric-furnace", 100},
		{"assembling-machine-2", 100},
		{"fast-inserter", 300},
		{"long-handed-inserter", 150},
		{"filter-inserter", 50},
		{"stack-filter-inserter", 50},
		{"steel-chest", 200},
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
        {"car", 1},
    }

	kits["alpha"]["armourItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
    }

    kits["alpha"]["technologies"] = {
        {"toolbelt"},
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

    -- Bravo kit: you lazy bastard.
    kits["bravo"] = {}

	kits["bravo"]["armourType"] = "power-armor-mk2"

	kits["bravo"]["quickbar"] = {
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

	kits["bravo"]["items"] = {
		{kits["bravo"]["armourType"], 1},
		{"steel-axe", 10},
		{"iron-plate", 492},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 400},
		{"fast-transport-belt", 2600},
		{"fast-underground-belt", 150},
		{"fast-splitter", 150},
		{"electric-furnace", 100},
		{"assembling-machine-2", 100},
		{"fast-inserter", 300},
		{"long-handed-inserter", 150},
		{"filter-inserter", 50},
		{"stack-filter-inserter", 50},
		{"steel-chest", 200},
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
        {"car", 1},

        {"advanced-circuit", 200},
        {"chemical-plant", 20},
        {"oil-refinery", 10},
        {"pumpjack", 60},
        {"lab", 10},
    }

	kits["bravo"]["armourItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
    }

    kits["bravo"]["technologies"] = {
        {"toolbelt"},
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

        {"circuit-network"},
        {"logistics"},
        {"logistics-2"},
        {"automation"},
        {"automation-2"},
        {"optics"},
    }


    -- Charlie kit: designed for quickly rebuilding after upgrading Factorio versions
    kits["charlie"] = {}

	kits["charlie"]["armourType"] = "power-armor-mk2"

	kits["charlie"]["quickbar"] = {
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

	kits["charlie"]["items"] = {
		{kits["charlie"]["armourType"], 1},
		{"steel-axe", 10},
		{"iron-plate", 492},
		{"copper-plate", 400},
		{"iron-gear-wheel", 200},
		{"electronic-circuit", 400},
		{"fast-transport-belt", 2600},
		{"fast-underground-belt", 150},
		{"fast-splitter", 150},
		{"electric-furnace", 100},
		{"assembling-machine-2", 100},
		{"fast-inserter", 300},
		{"long-handed-inserter", 150},
		{"filter-inserter", 50},
		{"stack-filter-inserter", 50},
		{"steel-chest", 200},
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
        {"car", 1},

        {"advanced-circuit", 200},
        {"chemical-plant", 20},
        {"oil-refinery", 10},
        {"pumpjack", 60},
        {"lab", 10},

        {"stone-wall", 100},
        {"gate", 50},
        {"rail-signal", 50},
        {"rail-chain-signal", 50},
    }

	kits["charlie"]["armourItems"] = {
		{"fusion-reactor-equipment"},
		{"fusion-reactor-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"personal-roboport-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"battery-mk2-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
		{"exoskeleton-equipment"},
		{"night-vision-equipment"},
		{"personal-laser-defense-equipment"},
		{"personal-laser-defense-equipment"},
		{"personal-laser-defense-equipment"},
		{"personal-laser-defense-equipment"},
		{"personal-laser-defense-equipment"},
    }

    kits["charlie"]["technologies"] = {
        {"toolbelt"},
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

        {"circuit-network"},
        {"logistics"},
        {"logistics-2"},
        {"automation"},
        {"automation-2"},
        {"optics"},
    }


    -- Omega kit: just the super basics
    kits["omega"] = {}

	kits["omega"]["quickbar"] = {
		{1, "transport-belt"},
		{2, "underground-belt"},
		{3, "splitter"},
		{4, "inserter"},
		{10, "deconstruction-planner"},
	}

	kits["omega"]["items"] = {
		{"steel-axe", 10},
		{"iron-plate", 192},
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
	
	local kitSetting = settings.startup["quick-start-boost-kit"].value
	local kit = kits[kitSetting]
	if kit == nil then
		kit = kits["alpha"]
	end
	
	-- Unlock technologies (must come before quickbar)
	if kit["technologies"] ~= nil then
		for k,v in pairs(kit["technologies"]) do
			player.force.technologies[v[1]].researched = true
		end
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

    -- Place some chests
    if kitSetting == "charlie" then
        local pos = player.position
        local max = 10000

        function createRow(item, rows, cols)
            for y=1,rows do
                for x=1,cols do
                    pos.x = pos.x + 1
                    local chest = player.surface.create_entity{name="logistic-chest-passive-provider", position=pos, force=player.force}
                    chest.insert{name = item, count = max}
                end

                if cols == 10 then
                    pos.x = pos.x - 10
                    pos.y = pos.y + 1
                end
            end
        end

        function createFullRow(item, rows)
            createRow(item, rows, 10)
        end

        -- Drop some roboports to stop the annoying notification
        local robopos = player.position
        robopos.x = robopos.x - 2
        robopos.y = robopos.y + 16
        player.surface.create_entity{name="roboport", position=robopos, force=player.force}
        robopos.x = robopos.x + 38
        player.surface.create_entity{name="roboport", position=robopos, force=player.force}


        -- COLUMN 1

        -- Red belts
        createFullRow("fast-transport-belt", 10)
        pos.y = pos.y + 1

        -- Inserters
        createFullRow("fast-inserter", 5)
        createFullRow("stack-inserter", 3)
        createFullRow("long-handed-inserter", 1)
        createRow("stack-filter-inserter", 1, 5)
        createRow("filter-inserter", 1, 5)
        pos.x = pos.x - 10
        pos.y = pos.y + 2

        -- Factories
        createFullRow("assembling-machine-2", 1)
        createFullRow("electric-mining-drill", 1)
        createFullRow("electric-furnace", 1)
        createFullRow("solar-panel", 1)
        createFullRow("accumulator", 1)
        createFullRow("fast-splitter", 1)
        createFullRow("fast-underground-belt", 1)
        createFullRow("concrete", 1)
        createFullRow("hazard-concrete", 1)

        createRow("oil-refinery", 1, 1)
        createRow("pumpjack", 1, 2)
        createRow("chemical-plant", 1, 1)
        createRow("boiler", 1, 1)
        createRow("steam-engine", 1, 1)
        createRow("stone-brick", 1, 1)
        createRow("radar", 1, 1)
        createRow("storage-tank", 1, 1)
        createRow("engine-unit", 1, 1)
        pos.x = pos.x - 10
        pos.y = pos.y + 1


        -- COLUMN 2
        pos.x = pos.x + 11
        pos.y = pos.y - 32

        -- Rail
        createFullRow("rail", 7)
        createFullRow("rail-signal", 2)
        createFullRow("rail-chain-signal", 1)
        pos.y = pos.y + 1

        -- Power Poles, Misc
        createFullRow("steel-chest", 3)
        createFullRow("small-lamp", 1)
        createFullRow("medium-electric-pole", 2)
        createFullRow("big-electric-pole", 2)
        createFullRow("substation", 2)
        pos.y = pos.y + 1

        -- Walls
        createFullRow("stone-wall", 8)
        createFullRow("gate", 2)


        -- COLUMN 3
        pos.x = pos.x + 11
        pos.y = pos.y - 32

        -- Defence
        createFullRow("laser-turret", 4)
        createFullRow("flamethrower-turret", 4)
        createFullRow("pipe", 1)
        createFullRow("pipe-to-ground", 1)
        pos.y = pos.y + 1

        -- Trains, robots
        createFullRow("locomotive", 1)
        createFullRow("cargo-wagon", 4)
        createFullRow("fluid-wagon", 1)
        createFullRow("train-stop", 1)
        createFullRow("roboport", 1)
        createFullRow("construction-robot", 1)
        createFullRow("logistic-robot", 1)
        pos.y = pos.y + 1

        -- Resources
        createFullRow("electronic-circuit", 2)
        createFullRow("advanced-circuit", 1)
        createFullRow("speed-module", 1)
        createFullRow("iron-plate", 1)
        createFullRow("iron-gear-wheel", 1)
        createFullRow("copper-plate", 1)
        createFullRow("copper-cable", 1)
        createFullRow("landfill", 1)
        createRow("battery", 1, 1)
        createRow("plastic-bar", 1, 1)
        createRow("constant-combinator", 1, 1)
        createRow("decider-combinator", 1, 1)
        createRow("arithmetic-combinator", 1, 1)
        createRow("steam-turbine", 1, 1)
        createRow("heat-exchanger", 1, 1)
        createRow("heat-pipe", 1, 1)
        createRow("logistic-chest-storage", 1, 1)
        createRow("logistic-chest-passive-provider", 1, 1)


    end
	
end)
