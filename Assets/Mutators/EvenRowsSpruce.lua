
dofile "Classes/Mutator.lua"

local function mut( block, x, y, z )
	if y % 2 == 0 and block.name == "minecraft:planks" then
		block.data = 1
	end

	return block
end

EvenRowsSpruce = Mutator( mut )
