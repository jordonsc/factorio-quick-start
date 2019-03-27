-- Time in seconds between attack (30 seconds)
ATTACK_INTERVAL = 1800
-- Level of darkness required for attacks to begin
ATTACK_DARKNESS = 0.5
-- Probability of an attack every ATTACK_INTERVAL during night
ATTACK_CHANCE = 0.5
-- Required amount of pollution for a base to be in, in order to trigger an attack
ATTACK_MIN_POLLUTION = 0.1
-- Scan x chunks every tick when preparing an attack
CHUNKS_PER_TICK = 100

-- Various different types of attacks we can have
ATTACK_MODE_POLLUTION = 0
ATTACK_MODE_PLAYER = 1
ATTACK_MODE_MAX = ATTACK_MODE_PLAYER

GAME_MODE_IDLE = 0
GAME_MODE_PREPARING = 1
GAME_MODE_ATTACKING = 2

-- Game init: prep the attack engine
script.on_init(function()
    m_debug("game init")

    global.bases = {}
    global.chunk_list = {}
    global.state = GAME_MODE_IDLE

    --prevents attacks from happening too often
    global.last_attack = 0

    -- This means we've been added to an existing save, instead of a new map so, we'll need to get a list of existing
    -- chunks instead of only tracking new ones.
    if game.tick > 0 then
        m_debug("first-run chunk search")
        find_chunks()
        m_debug("chunk search complete")
    end
    global.chunk_index = 1
    global.attack_mode = ATTACK_MODE_POLLUTION
end)


-- Player init: give the player cool shit
script.on_event(defines.events.on_player_created, function(event)
    m_debug("begin player init")

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

    kit["items"] = {
        { kit["armourType"], 1 },
        { "submachine-gun", 1 },
        { "piercing-rounds-magazine", 100 },

        { "iron-plate", 492 },
        { "iron-gear-wheel", 200 },
        { "copper-plate", 400 },
        { "copper-cable", 400 },
        { "electronic-circuit", 400 },
        { "fast-transport-belt", 2400 },
        { "fast-underground-belt", 150 },
        { "fast-splitter", 150 },
        { "electric-furnace", 300 },
        { "assembling-machine-2", 300 },
        { "fast-inserter", 300 },
        { "long-handed-inserter", 150 },
        { "filter-inserter", 50 },
        { "stack-filter-inserter", 50 },
        { "steel-chest", 150 },
        { "electric-mining-drill", 150 },
        { "medium-electric-pole", 150 },
        { "big-electric-pole", 100 },
        { "substation", 100 },
        { "boiler", 20 },
        { "steam-engine", 40 },
        { "offshore-pump", 10 },
        { "pipe-to-ground", 200 },
        { "pipe", 200 },
        { "construction-robot", 150 },
        { "small-lamp", 100 },
        { "deconstruction-planner", 1 },
        { "repair-pack", 100 },
        { "rail", 100 },
        { "stone-wall", 100 },
        { "gate", 50 },
        { "rail-signal", 50 },
        { "rail-chain-signal", 50 },
    }

    kit["cars"] = {
        {
            { "iron-plate", 2000 },
            { "iron-gear-wheel", 1000 },
            { "copper-plate", 2000 },
            { "electronic-circuit", 2000 },
            { "advanced-circuit", 2000 },
            { "rail", 1000 },
        },
        {
            { "fast-transport-belt", 3000 },
            { "fast-underground-belt", 250 },
            { "fast-splitter", 250 },
            { "fast-inserter", 250 },
            { "stack-inserter", 250 },
            { "stack-filter-inserter", 50 },
            { "long-handed-inserter", 100 },
            { "steel-chest", 250 },
            { "small-lamp", 100 },
            { "medium-electric-pole", 100 },
            { "big-electric-pole", 300 },
            { "substation", 350 },
            { "stone-wall", 500 },
        },
    }

    kit["armourItems"] = {
        { "fusion-reactor-equipment" },
        { "fusion-reactor-equipment" },
        { "personal-roboport-mk2-equipment" },
        { "personal-roboport-mk2-equipment" },
        { "battery-mk2-equipment" },
        { "battery-mk2-equipment" },
        { "exoskeleton-equipment" },
        { "exoskeleton-equipment" },
    }

    kit["technologies"] = {
        { "toolbelt" },
        { "construction-robotics" },
        { "personal-roboport-equipment" },
        { "exoskeleton-equipment" },
        { "character-logistic-slots-1" },
        { "character-logistic-slots-2" },
        { "character-logistic-slots-3" },
        { "character-logistic-slots-4" },
        { "character-logistic-slots-5" },
        { "character-logistic-slots-6" },
        { "auto-character-logistic-trash-slots" },
        { "worker-robots-speed-1" },
        { "worker-robots-speed-2" },
        { "worker-robots-speed-3" },
        { "worker-robots-speed-4" },
        { "worker-robots-speed-5" },
        { "worker-robots-speed-6" },
        { "worker-robots-storage-1" },
        { "worker-robots-storage-2" },
        { "worker-robots-storage-3" },
    }

    -- end kits

    -- Unlock technologies
    if kit["technologies"] ~= nil then
        for k, v in pairs(kit["technologies"]) do
            player.force.technologies[v[1]].researched = true
        end
    end

    -- Add items
    for k, v in pairs(kit["items"]) do
        c = player.insert { name = v[1], count = v[2] }
    end

    -- Kit out armour
    if kit["armourItems"] ~= nil then
        -- Find armour in one of the inventories
        -- Usually ends up in the armour slot. But that one does not exist in sandbox mode
        for k, v in pairs(inventories) do
            local inventory = player.get_inventory(v)
            if inventory ~= nil then
                local armor = inventory.find_item_stack(kit["armourType"])
                if armor ~= nil then
                    -- Add items to armor grid
                    local grid = armor.grid
                    for k, v in pairs(kit["armourItems"]) do
                        grid.put { name = v[1] }
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

    for i, c in pairs(kit["cars"]) do
        local car = player.surface.create_entity { name = "car", position = pos, force = player.force }
        car.insert { name = "solid-fuel", count = 50 }
        car.insert { name = "piercing-rounds-magazine", count = 100 }

        pos.x = pos.x + 4

        for k, v in pairs(c) do
            car.insert { name = v[1], count = v[2] }
        end
    end

    m_debug("player init complete")
end)


-- Game tick: cause havoc
script.on_event(defines.events.on_tick, function(event)
    -- We'll only do limited work each tick, so keep going until the state changes and we're back to GAME_MODE_IDLE
    if global.state == GAME_MODE_IDLE
            and (event.tick % ATTACK_INTERVAL == 0)
            and game.surfaces[1].darkness > ATTACK_DARKNESS
            and math.random() > ATTACK_CHANCE then
        --	Search for bases then attack
        m_log("The enemy grows restless..")
        global.state = GAME_MODE_PREPARING
    end
    if global.state == GAME_MODE_PREPARING then
        -- Every tick scan CHUNKS_PER_TICK chunks for bases to use for an attack
        find_bases()
    elseif global.state == GAME_MODE_ATTACKING then
        -- Prep the attack
        attack()
    end
end)

-- Record new chucks being generated
script.on_event(defines.events.on_chunk_generated, function(event)
    -- Record new chunks as they are created to save performance
    if event.surface == game.surfaces[1] then
        local chunk = {}
        local coords = event.area.left_top
        chunk.x = coords.x + 16
        chunk.y = coords.y + 16
        table.insert(global.chunk_list, chunk)
        m_debug("add chunk")
    end
end)

-- Pre-attack preparation: scan bases
function find_bases()
    if global.chunk_index == 1 then
        global.bases = {}
    end

    local max_index = #global.chunk_list

    for i = global.chunk_index, global.chunk_index + CHUNKS_PER_TICK, 1 do
        if i > max_index then
            -- We're done with the search, move on to attack mode
            global.state = GAME_MODE_ATTACKING
            global.chunk_index = 1
            shuffle_table(global.bases)
            global.attack_mode = math.random(0, ATTACK_MODE_MAX)
            m_debug("base scan complete (" .. #global.bases .. "), attack mode: " .. global.attack_mode)
            return
        end

        if game.surfaces[1].get_pollution(global.chunk_list[i]) > ATTACK_MIN_POLLUTION then
            local chunk_coord = global.chunk_list[i]
            if (game.surfaces[1].count_entities_filtered { area = { { chunk_coord.x - 16, chunk_coord.y - 16 },
                                                                    { chunk_coord.x + 16, chunk_coord.y + 16 } },
                                                           type = "unit-spawner" }) > 0 then
                table.insert(global.bases, chunk_coord)
            end
        end
    end

    global.chunk_index = global.chunk_index + CHUNKS_PER_TICK
end

function attack()
    local max_index = #global.bases
    local surface = game.surfaces[1]

    for i = global.chunk_index, global.chunk_index + CHUNKS_PER_TICK, 1 do
        -- all bases accounted for, finish attack process
        if i > max_index then

            global.state = GAME_MODE_IDLE
            global.chunk_index = 1
            return
        end

        if math.random() < game.forces["enemy"].evolution_factor then
            local base = global.bases[i]
            local group = surface.create_unit_group { position = base }
            for _, biter in ipairs(surface.find_enemy_units(base, 16)) do
                group.add_member(biter)
            end

            if #group.members == 0 then
                group.destroy()
            else
                m_debug("dispatching attack of " .. #group.members)
                -- autonomous groups will attack polluted areas independently
                if global.attack_mode == ATTACK_MODE_POLLUTION then
                    m_log("Sending attack on pollution")
                    group.set_autonomous()
                elseif global.attack_mode == ATTACK_MODE_PLAYER then
                    m_log("Sending attack on player")
                    group.set_command { type = defines.command.attack_area, destination = game.players[1].position,
                                        radius = 50, distraction = defines.distraction.by_enemy }
                end
            end
        end
    end

    global.chunk_index = global.chunk_index + CHUNKS_PER_TICK
end

function find_chunks()
    global.chunk_list = {}
    for coords in game.surfaces[1].get_chunks() do
        if game.surfaces[1].is_chunk_generated(coords) then
            table.insert(global.chunk_list, chunk_to_tiles(coords))
        end
    end
end

function chunk_to_tiles(chunk)
    --transform chunk coords to coords of it's middle tile
    local tile = {}
    tile.x = math.floor((chunk.x + 0.5) * 32)
    tile.y = math.floor((chunk.y + 0.5) * 32)
    return tile
end

function shuffle_table(t)
    assert(t, "shuffleTable() expected a table, got nil")
    local iterations = #t
    local j

    for i = iterations, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

function m_log(msg)
    game.surfaces[1].print(msg)
    m_debug(msg)
end

function m_debug(msg)
    print("war-monger: " .. msg)
end