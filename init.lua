minetest.register_tool("alien_tools:flame", {
	description = "Alien Flame",
	range = 69,
	inventory_image = "alien_tools_flame.png",
	tool_capabilities = {
		full_punch_interval = 0.0,
		max_drop_level = 3,
		groupcaps = {
			unbreakable = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 2317},
	},
})

wielded_light.register_item_light("alien_tools:flame", 14)

armor:register_armor("alien_tools:shield", {
	description = "Alien Shield",
	inventory_image = "alien_tools_shield.png",
	groups = {armor_shield = 2317, armor_heal = 2317, armor_use = 0},
	on_use = function(itemstack, player, pointed_thing)
		player:set_physics_override({new_move = false, sneak_glitch = true})
		minetest.chat_send_player(player:get_player_name(), "Sneak Jump Power Enabled!")
	end,
})

wielded_light.register_item_light("alien_tools:shield", 3)

minetest.register_node("alien_tools:plant", {
	description = "Alien Plant",
	drawtype = "plantlike",
	tiles = {"default_dry_shrub.png^[colorize:#00FFD937"},
	inventory_image = "default_dry_shrub.png^[colorize:#00FFD937",
	wield_image = "default_dry_shrub.png^[colorize:#00FFD937",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
})

wielded_light.register_item_light("alien_tools:plant", 1)

minetest.register_node("alien_tools:soil", {
	description = "Alien Soil",
	tiles = {"default_grass.png^[colorize:#00FFFF69", "default_dirt.png^[colorize:#00FFFF69",
		{name = "(default_dirt.png^default_grass_side.png)^[colorize:#00FFFF69",
			tileable_vertical = false}},
	groups = {crumbly = 3},
})

minetest.register_node("alien_tools:stone", {
	description = "Alien Stone",
	tiles = {"default_stone.png^[colorize:#00FFFF69"},
	groups = {cracky = 3, stone = 1}
})

minetest.register_node("alien_tools:plasma_source", {
	description = "Alien Plasma Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {"default_water.png^[colorize:#33ff1769"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "alien_tools:plasma_flowing",
	liquid_alternative_source = "alien_tools:plasma_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	light_source = 14,
})

minetest.register_node("alien_tools:plasma_flowing", {
	description = "Alien Flowing Plasma",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"default_water.png^[colorize:#33ff1769"},
	special_tiles = {
		{
			name = "default_water.png^[colorize:#33ff1769",
		},
		{
			name = "default_water.png^[colorize:#33ff1769",
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "alien_tools:plasma_flowing",
	liquid_alternative_source = "alien_tools:plasma_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	light_source = 14,
})

minetest.register_craftitem("alien_tools:core", {
	description = "Alien Core",
	inventory_image = "default_obsidian.png^[colorize:#FF000322",
})

wielded_light.register_item_light("alien_tools:core", 4)

if minetest.settings:get_bool("alien_replace") == nil or minetest.settings:get_bool("alien_replace") == true then
	minetest.clear_registered_biomes()
	minetest.clear_registered_ores()
	minetest.clear_registered_decorations()
	minetest.set_mapgen_params({flags = "nocaves, nocaverns, nodungeons"})
end

minetest.register_biome({
	node_top = "alien_tools:soil",
	depth_top = 1,
	node_stone = "alien_tools:stone",
	node_water = "alien_tools:plasma_source",
	node_river_water = "alien_tools:plasma_source",
	y_min = -31000,
	y_max = 31000,
	heat_point = 0,
	humidity_point = 0,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "alien_tools:soil",
	sidelen = 16,
	fill_ratio = 0.023,
	decoration = "alien_tools:plant",
	height = 1,
})

minetest.register_craft({
	output = "alien_tools:core",
	recipe = {
		{"alien_tools:plant", "alien_tools:plant"},
		{"alien_tools:plant", "alien_tools:plant"},
	},
})

minetest.register_craft({
	output = "alien_tools:flame",
	recipe = {
		{"alien_tools:plant", "", ""},
		{"alien_tools:plant", "alien_tools:core", "alien_tools:core"},
		{"alien_tools:plant", "alien_tools:core", "alien_tools:core"},
	},
})

minetest.register_craft({
	output = "alien_tools:shield",
	recipe = {
		{"alien_tools:stone", "alien_tools:stone", "alien_tools:stone"},
		{"alien_tools:stone", "alien_tools:core", "alien_tools:stone"},
		{"", "alien_tools:stone", ""},
	},
})
