game.reload_script()

for index, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()
	
	-- local technologies = force.technologies
	-- local modifier = 0
	
	-- for i = 1, 6 do
		-- local md = 0.2
	
		-- if technologies["turret-mk3-damage-"..i].researched then
			-- modifier = modifier + md
		-- end
	-- end
	
	-- force.set_turret_attack_modifier("at_CR_turret", modifier)
	-- force.set_turret_attack_modifier("at_CR_turretr", modifier)
end