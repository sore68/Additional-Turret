game.reload_script()

for index, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()
	
	-- local technologies = force.technologies
	-- local recipes = force.recipes
	
	-- if not technologies["turret-mk3-unlock"].researched then
		-- recipes["at_CR_turret_area"].enabled = false
		-- recipes["at_CR_turret_area"].reload()
	-- end
	
	-- if technologies["artillery-set"].researched then
		-- recipes["at_Artillery_mk1_area"].enabled = true
		-- recipes["at_Artillery_mk1_area"].reload()
	-- end
	
end