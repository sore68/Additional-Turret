function rocket_mk1_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__Additional-Turret__/graphics/entity/rocket-mk1-sheet.png",
      priority = "medium",
      scale = 1,
      width = 88,
      height = 80,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 16,
      axially_symmetrical = false,
	  run_mode = inputs.run_mode and inputs.run_mode or "forward",
      shift = { 0.1, -0.15 },  
    }
  }
}
end

function rocket_mk2_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__Additional-Turret__/graphics/entity/rocket-mk2-sheet.png",
      priority = "medium",
      scale = 1,
      width = 72,
      height = 80,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 16,
      axially_symmetrical = false,
	  run_mode = inputs.run_mode and inputs.run_mode or "forward",
      shift = { 0.25, -0.5 },  
    
    }
  }
}
end



data:extend({
{
  type = "ammo-turret",
  name = "at-rocket-turret-mk1",
  icon = "__Additional-Turret__/graphics/icon/turret-rocket-mk1-icon.png",
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 1, result = "at-rocket-turret-mk1"},
  max_health = 700,
  corpse = "small-remnants",
  collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
  selection_box = {{-1, -1 }, {1, 1}},
  rotation_speed = 0.012,
  preparing_speed = 0.08,
  folding_speed = 0.08,
  dying_explosion = "medium-explosion",
  inventory_size = 1,
  automated_ammo_count = 20,
  attacking_speed = 0.1,
  
  folded_animation = rocket_mk1_sheet{direction_count = 4, line_length = 1},
  preparing_animation = rocket_mk1_sheet{direction_count = 4, line_length = 1},
  prepared_animation = rocket_mk1_sheet{},
  attacking_animation = rocket_mk1_sheet{},
  folding_animation = rocket_mk1_sheet{direction_count = 4, line_length = 1, run_mode = "backward"},
  
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  
  attack_parameters =
  {
    type = "projectile",
    ammo_category = "rocket",
    cooldown = 60,
    projectile_creation_distance = 1.2,
    projectile_center = {-0.15625, -0.07812},
    damage_modifier = 1,
    shell_particle =
    {
      name = "shell-particle",
      direction_deviation = 0.1,
      speed = 0.1,
      speed_deviation = 0.03,
      center = {0, 0},
      creation_distance = -1.925,
      starting_frame_speed = 0.2,
      starting_frame_speed_deviation = 0.1
    },
    range = 22,
    min_range = 10,
    sound =
    {
      {
        filename = "__base__/sound/fight/rocket-launcher.ogg",
        volume = 0.7
      }
    },
  },
  call_for_help_radius = 50
},
{
  type = "ammo-turret",
  name = "at-rocket-turret-mk2",
  icon = "__Additional-Turret__/graphics/icon/turret-rocket-mk2-icon.png",
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 0.7, result = "at-rocket-turret-mk2"},
  max_health = 1500,
  corpse = "small-remnants",
  collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
  selection_box = {{-1, -1 }, {1, 1}},
  rotation_speed = 0.008,
  preparing_speed = 0.04,
  folding_speed = 0.04,
  dying_explosion = "medium-explosion",
  inventory_size = 1,
  automated_ammo_count = 10,
  attacking_speed = 0.1,
  
  folded_animation = rocket_mk2_sheet{direction_count = 4, line_length = 1},
  preparing_animation = rocket_mk2_sheet{direction_count = 4, line_length = 1},
  prepared_animation = rocket_mk2_sheet{},
  attacking_animation = rocket_mk2_sheet{},
  folding_animation = rocket_mk2_sheet{direction_count = 4, line_length = 1, run_mode = "backward"},
  
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  
  attack_parameters =
  {
    type = "projectile",
    ammo_category = "rocket",
    cooldown = 75,
    projectile_creation_distance = 1.2,
    projectile_center = {-0.15625, -0.07812},
    damage_modifier = 1,
    shell_particle =
    {
      name = "shell-particle",
      direction_deviation = 0.1,
      speed = 0.1,
      speed_deviation = 0.03,
      center = {0, 0},
      creation_distance = -1.925,
      starting_frame_speed = 0.2,
      starting_frame_speed_deviation = 0.1
    },
    range = 40,
    min_range = 15,
    sound =
    {
      {
        filename = "__base__/sound/fight/rocket-launcher.ogg",
        volume = 0.8
      }
    },
  },

  call_for_help_radius = 104
},
})


--item
data:extend({
{
  type = "item",
  name = "at-rocket-turret-mk1",
  icon = "__Additional-Turret__/graphics/icon/turret-rocket-mk1-icon.png",
  flags = {"goes-to-quickbar"},
  subgroup = "defensive-structure",
  order = "b[turret]-c[base]-c[rocket-mk1]",
  place_result = "at-rocket-turret-mk1",
  stack_size = 50,
},
{
  type = "item",
  name = "at-rocket-turret-mk2",
  icon = "__Additional-Turret__/graphics/icon/turret-rocket-mk2-icon.png",
  flags = {"goes-to-quickbar"},
  subgroup = "defensive-structure",
  order = "b[turret]-c[base]-d[rocket-mk2]",
  place_result = "at-rocket-turret-mk2",
  stack_size = 30,
},
})


--recipe
data:extend({
{
  type = "recipe",
  name = "at-rocket-turret-mk1",
  enabled = false,
  energy_required = 10,
  ingredients =
  {
    {"gun-turret", 2},
    {"steel-plate", 2},
    {"electronic-circuit", 2}
  },
  result = "at-rocket-turret-mk1",
},
{
  type = "recipe",
  name = "at-rocket-turret-mk2",
  enabled = false,
  energy_required = 10,
  ingredients =
  {
    {"gun-turret", 1},
    {"at-rocket-turret-mk1", 1},
    {"electronic-circuit", 4}
  },
  result = "at-rocket-turret-mk2",
},
})