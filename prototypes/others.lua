-- fluid
data:extend({
{
	type = "fluid",
	name = "piranha-solution",
	default_temperature = 25,
	heat_capacity = "1KJ",
	base_color = {r=0, g=0.4, b=0.2},
	flow_color = {r=0, g=0.5, b=0.3},
	max_temperature = 100,
	icon = "__Additional-Turret__/graphics/icon/piranha-solution-icon.png",
	pressure_to_speed_ratio = 0.4,
	flow_to_energy_ratio = 0.59,
	order = "a[fluid]-g[piranha-solution]"
},
{
	type = "item",
	name = "piranha-core",
	icon = "__Additional-Turret__/graphics/icon/piranha-core-icon.png",
	flags = {"goes-to-main-inventory"},
	subgroup = "intermediate-product",
	order = "g[plastic-bar]-a[piranha-core]",
	stack_size = 10
},
})

-- category
data:extend({
{
	type = "ammo-category",
	name = "artillery-mk1-shell"
},
{
	type = "ammo-category",
	name = "artillery-mk2-shell"
},
{
	type = "ammo-category",
	name = "dummy"
},
})

-- damage type
data:extend(
{
	{
		type = "damage-type",
		name = "sore-acid"
	},
}
)


-- recipe
data:extend({
{
	type = "recipe",
	name = "piranha-solution",
	category = "chemistry",
	energy_required = 6,
	subgroup = "fluid-recipes",
	enabled = false,
	ingredients =
	{
		{type="item", name="piranha-core", amount=4},
		{type="item", name="alien-artifact", amount=2},
		{type="fluid", name="water", amount=50},
	},
	results=
	{
		{type="fluid", name="piranha-solution", amount=40},
	},
},

{
	type = "recipe",
	name = "piranha-core",
	category = "chemistry",	
	energy_required = 10,
	subgroup = "intermediate-product",
	order = "i[explosives]-a[piranha-core]",
	enabled = false,
	icon = "__Additional-Turret__/graphics/icon/piranha-core-icon.png",
	ingredients =
	{
		{type="item", name="sulfur", amount=30},
		{type="item", name="coal", amount=3},
		{type="item", name="stone", amount=5},
		{type="fluid", name="water", amount=5},
		{type="fluid", name="sulfuric-acid", amount=1}
	},
	results=
	{
		{type="fluid", name="petroleum-gas", amount=3},
		{type="item", name="piranha-core", amount=6},
	},
},
})

-- fire sound
function fire_sound(inputs)
return
{
	type = "explosion",
	name = inputs.name,
	flags = {"not-on-map"},
	animations =
	{
		{
			filename = "__base__/graphics/terrain/blank.png",
			priority = "low",
			width = 1,
			height = 1,
			frame_count = 1,
			line_length = 1,
			animation_speed = 1
		},
	},
	light = {intensity = 0, size = 0},
	sound =
	{
		{
			filename = inputs.filename,
			volume = inputs.volume,
		},
	},
}
end

data:extend({
fire_sound{name = "at_Artillery_shoot_sound", filename = "__Additional-Turret__/sound/Artillery_shoot_sound.ogg", volume = 1.0},
fire_sound{name = "at_LC_turret_sound", filename = "__Additional-Turret__/sound/LC_turret_sound.ogg", volume = 1.0},
fire_sound{name = "at_CR_turret_sound", filename = "__Additional-Turret__/sound/cannon_3_sound.ogg", volume = 1.0},
fire_sound{name = "capsule_sound", filename = "__Additional-Turret__/sound/uplink.ogg", volume = 1.0},
})