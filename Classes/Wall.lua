
dofile "Classes/Grid3D.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Structure.lua"
dofile "Classes/Material.lua"
dofile "Classes/Facing.lua"

class "Wall" extends "Structure"
{
	a = {};
	b = {};
	facing = {};
}

function Wall:Wall( from, to, facing, fill )
	if not from:typeOf( Point3D ) or not to:typeOf( Point3D ) or not facing:typeOf( Facing ) or not ( type( fill ) == "function" or fill:typeOf( Grid3D ) or fill:typeOf( Material ) ) then
		error( "Expected Point3D, Point3D, Facing, (Grid3D or Material or fill (function))", 3 )
	end

	from = from:duplicate()
	to = to:duplicate()
	facing = facing:duplicate()

	self.a = from
	self.b = to

	self.facing = facing

	size = ( to - from ) + 1

	return self:Structure( "Wall", size, from, fill )
end

function Wall:tostring()
	return "[Wall] \n from " .. tostring( self.a ) .. " to " .. tostring( self.b ) .. " " .. self.super:tostring()
end

--TODO: Update this!!
function Wall:updateGrid( fill )
	self.grid = Grid3D( self.a.x - self.b.x, self.a.y - self.b.y, self.a.z - self.b.z, from.x, from.y, from.z, fill )
end

--TODO: Wall:cover( block ) -- Resizes the Grid3D (y++) and adds a block on the highest free position in every column
--		Wait, shouldn't this ^ be implemented in Structure instead?
