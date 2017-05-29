game.reload_script()

for index, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()
	
	local technologies = force.technologies
	local recipes = force.recipes
	
	if technologies["turret-mk1-unlock"].researched then
		recipes["small-coal-cannon-shell"].enabled = true
		recipes["small-coal-rocket"].reload()
	end
	
end