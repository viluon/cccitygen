
dofile "Classes/Block.lua"

local woodPlanksBlock = Block()
woodPlanksBlock.name = "minecraft:planks"
woodPlanksBlock.data = 1

local function mut( block, x, y, z )
	-- Note:	There is no need for a mutator, as a wood planks wall simply
	--			consists of woodPlanksBlocks.
end

SpruceWoodPlanks = Material( woodPlanksBlock )	-- :addMutator( mut )
