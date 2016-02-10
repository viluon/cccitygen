
dofile "Classes/Grid3D.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Structure.lua"
dofile "Classes/Material.lua"

class "Wall" extends "Structure"
{
	a = {};
	b = {};
}

function Wall:Wall( from, to, fill )
	if not from:typeOf( Point3D ) or not to:typeOf( Point3D ) or not ( type( fill ) == "function" or fill:typeOf( Grid3D ) or fill:typeOf( Material ) ) then
		error( "Expected Point3D, Point3D, (Grid3D or Material or fill (function))", 3 )
	end

	self.a = from
	self.b = to

	size = ( to - from ) + 1

	return self:Structure( "Wall", size.x, size.y, size.z, from.x, from.y, from.z, fill )
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
