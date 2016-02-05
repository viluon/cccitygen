
dofile "Classes/Block.lua"
dofile "Interfaces/IHasChildren.lua"

class "Material"
{
	baseBlock = {};
	mutators = {};
}

function Material:Material( base )
	if not base:typeOf( Block ) then
		error( "Expected Block", 2 )
	end

	self.baseBlock = base:duplicate()

	self.mutators = {}
end

function Material:addMutator( mut, pos )
	if type( pos ) then
		self.mutators[ #self.mutators + 1 ] = mut
		return true, "Added mutator to the end of mutator chain."
	end

	pos = math.floor( pos )

	if pos < 1 or pos > #self.mutators + 1 then
		error( "Invalid position", 2 )
	end

	return table.insert( self.mutators, pos, mut )
end

function Material:removeMutator( mut )
	for i, m in ipairs( self.mutators ) do
		if m == mut then
			return table.remove( self.mutators, i )
		end
	end

	error( "No mutator found", 2 )
end

function Material:apply( x, y, z )
	local result = self.baseBlock:duplicate()

	for i, mutator in ipairs( self.mutators ) do
		result = mutator:apply( result, x, y, z )
	end

	return result
end

--TODO: Material:applyToGrid3D (+ overloads for __add)
