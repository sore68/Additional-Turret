function cannon_mk1_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__Additional-Turret__/graphics/entity/cannon-mk1-sheet.png",
      priority = "medium",
      scale = 0.75,
      width = 128,
      height = 128,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 8,
      axially_symmetrical = false,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
    shift = { 0.35, -0.5 },
    }
  }
}
end

function cannon_mk2_place(inputs)
return
{
  layers = 
  {
    {
      filename = "__Additional-Turret__/graphics/entity/cannon-mk2-place.png",
      priority = "medium",
      scale = 1,
      width = 128,
      height = 128,
      frame_count = inputs.frame_count and inputs.frame_count or 8,
      line_length = inputs.line_length and inputs.line_length or 0,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
      direction_count = 4,
      axially_symmetrical = false,
      shift = { 0.5, -0.75}, --{ 0.4375, -0.375},
    },
  },
}

end

function cannon_mk2_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__Additional-Turret__/graphics/entity/cannon-mk2-sheet.png",
      priority = "medium",
      scale = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 64,
      line_length = 8,
      axially_symmetrical = false,
      shift = { 0.5, -0.75},
    }
  }
}
end



data:extend({
{
  type = "ammo-turret",
  name = "at-cannon-turret-mk1",
  icon = "__Additional-Turret__/graphics/icon/turret-cannon-mk1-icon.png",
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 1, result = "at-cannon-turret-mk1"},
  max_health = 1200,
  corpse = "medium-remnants",
  collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
  selection_box = {{-1, -1 }, {1, 1}},
  rotation_speed = 0.012,
  preparing_speed = 0.08,
  folding_speed = 0.08,
  dying_explosion = "medium-explosion",
  inventory_size = 1,
  automated_ammo_count = 20,
  attacking_speed = 0.5,
  
  folded_animation = cannon_mk1_sheet{direction_count = 8, line_length = 1},
  preparing_animation = cannon_mk1_sheet{direction_count = 8, line_length = 1},
  prepared_animation = cannon_mk1_sheet{},
  attacking_animation = cannon_mk1_sheet{},
  folding_animation = cannon_mk1_sheet{direction_count = 8, line_length = 1, run_mode = "backward"},
  
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  
  attack_parameters =
  {
    type = "projectile",
    ammo_category = "cannon-shell",
    cooldown = 90,
    projectile_creation_distance = 1.75,
    projectile_center = {0, 0},
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
    range = 27,
    min_range = 15,
    sound =
    {
      {
        filename = "__Additional-Turret__/sound/cannon_1_sound.ogg",
        volume = 0.7
      }
    },
  },
  call_for_help_radius = 46
},
{
  type = "ammo-turret",
  name = "at-cannon-turret-mk2",
  icon = "__Additional-Turret__/graphics/icon/turret-cannon-mk2-icon.png",
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 2.5, result = "at-cannon-turret-mk2"},
  max_health = 2100,
  corpse = "big-remnants",
  collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
  selection_box = {{-1, -1 }, {1, 1}},
  rotation_speed = 0.008,
  preparing_speed = 0.04,
  folding_speed = 0.04,
  dying_explosion = "big-explosion",
  inventory_size = 1,
  automated_ammo_count = 20,
  attacking_speed = 0.5,
    
  folded_animation = cannon_mk2_place{frame_count=1, line_length = 1},
  preparing_animation = cannon_mk2_place{},
  prepared_animation = cannon_mk2_sheet{},
  attacking_animation = cannon_mk2_sheet{},
  folding_animation = cannon_mk2_place{run_mode = "backward"},
  
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  
  attack_parameters =
  {
    type = "projectile",
    ammo_category = "cannon-shell",
    cooldown = 45,
    projectile_creation_distance = 1.5,
    projectile_center = {0, 0},
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
    range = 37,
    min_range = 17,
    sound =
    {
      {
        filename = "__Additional-Turret__/sound/cannon_2_sound.ogg",
        volume = 0.8
      }
    },
  },

  call_for_help_radius = 100
},
})


--item
data:extend({
{
  type = "item",
  name = "at-cannon-turret-mk1",
  icon = "__Additional-Turret__/graphics/icon/turret-cannon-mk1-icon.png",
  flags = {"goes-to-quickbar"},
  subgroup = "defensive-structure",
  order = "b[turret]-c[base]-a[cannon-mk1]",
  place_result = "at-cannon-turret-mk1",
  stack_size = 50,
},
{
  type = "item",
  name = "at-cannon-turret-mk2",
  icon = "__Additional-Turret__/graphics/icon/turret-cannon-mk2-icon.png",
  flags = {"goes-to-quickbar"},
  subgroup = "defensive-structure",
  order = "b[turret]-c[base]-b[cannon-mk2]",
  place_result = "at-cannon-turret-mk2",
  stack_size = 20,
},
})  


--recipe
data:extend({
{
  type = "recipe",
  name = "at-cannon-turret-mk1",
  enabled = false,
  energy_required = 10,
  ingredients =
  {
    {"gun-turret", 2},
    {"steel-plate", 2},
    {"electronic-circuit", 2}
  },
  result = "at-cannon-turret-mk1",
},
{
  type = "recipe",
  name = "at-cannon-turret-mk2",
  enabled = false,
  energy_required = 15,
  ingredients =
  {
    {"gun-turret", 1},
    {"at-cannon-turret-mk1", 1},
    {"electronic-circuit", 4}
  },
  result = "at-cannon-turret-mk2",
},
})