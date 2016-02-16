
dofile "Classes/Mutator.lua"

local function mut( block, x, y, z, grid )
	if y / grid.size.y >= 0.75 and block.name == "minecraft:planks" then
		block.data = 1
	end

	return block
end

TopRowsSpruce = Mutator( mut )
