data:extend({
{
	type = "recipe",
	name = "small-coal-cannon-shell",
	enabled = false,
	energy_required = 4,
	ingredients = 
	{
		{"coal", 15},
		{"iron-plate", 4},
		{"copper-plate", 4},
	},
	result = "small-coal-cannon-shell",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "small-cannon-shell",
	enabled = false,
	energy_required = 4,
	ingredients = 
	{
		{"steel-plate", 4},
		{"plastic-bar", 2},
		{"explosives", 1},
	},
	result = "small-cannon-shell",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "small-explosive-cannon-shell",
	enabled = false,
	energy_required = 4,
	ingredients = 
	{
		{"steel-plate", 4},
		{"plastic-bar", 2},
		{"explosives", 4},
	},
	result = "small-explosive-cannon-shell",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "cluster-cannon-shell",
	enabled = false,
	energy_required = 8,
	ingredients =
	{
		{"small-cannon-shell", 1},
		{"small-explosive-cannon-shell", 3},
		{"electronic-circuit", 2},
	},
	result = "cluster-cannon-shell",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "fire-cannon-shell",
	enabled = false,
	energy_required = 20,
	ingredients =
	{
		{"piranha-core", 3},
		{"explosives", 10},
		{"iron-plate", 7},
		{"small-explosive-cannon-shell", 5},
	},
	result = "fire-cannon-shell",
	result_count = 5,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "fire-cluster-cannon-shell",
	enabled = false,
	energy_required = 12,
	ingredients =
	{
		{"piranha-core", 1},
		{"explosives", 2},
		{"fire-cannon-shell", 2},
		{"cluster-cannon-shell", 1},
	},
	result = "fire-cluster-cannon-shell",
	result_count = 3,
	requester_paste_multiplier = 10,
},



{
	type = "recipe",
	name = "small-coal-rocket",
	enabled = false,
	energy_required = 4,
	ingredients =
	{
		{"coal", 15},
		{"iron-plate", 4},
		{"copper-plate", 4},
	},
	result = "small-coal-rocket",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "small-rocket",
	enabled = false,
	energy_required = 4,
	ingredients =
	{
		{"electronic-circuit", 1},
		{"explosives", 2},
		{"iron-plate", 2}
	},
	result = "small-rocket",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "small-explosive-rocket",
	enabled = false,
	energy_required = 4,
	ingredients =
	{
		{"rocket", 1},
		{"explosives", 5}
	},
	result = "small-explosive-rocket",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "explosive-multiple-rocket",
	enabled = false,
	energy_required = 8,
	ingredients =
	{
		{"small-rocket", 1},
		{"small-explosive-rocket", 3},
		{"electronic-circuit", 2},
	},
	result = "explosive-multiple-rocket",
	result_count = 2,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "acid-rocket",
	enabled = false,
	energy_required = 20,
	ingredients =
	{
		{"piranha-core", 3},
		{"explosives", 10},
		{"iron-plate", 7},
		{"small-explosive-rocket", 5},
	},
	result = "acid-rocket",
	result_count = 5,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "acid-multiple-rocket",
	enabled = false,
	energy_required = 12,
	ingredients =
	{
		{"piranha-core", 1},
		{"explosives", 2},
		{"acid-rocket", 2},
		{"explosive-multiple-rocket", 1},
	},
	result = "acid-multiple-rocket",
	result_count = 3,
	requester_paste_multiplier = 10,
},
{
	type = "recipe",
	name = "acid-thrower-ammo",
	category = "chemistry",
	enabled = false,
	energy_required = 15,
	ingredients =
	{
		{type="item", name="piranha-core", amount=1},
		{type="item", name="explosives", amount=2},
		{type="item", name="iron-plate", amount=5},
	},
	result = "acid-thrower-ammo",
	result_count = 6,
	requester_paste_multiplier = 10,
},
})