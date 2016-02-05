
dofile "Classes/Structure.lua"
dofile "Classes/Wall.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Block.lua"

dofile "Interfaces/IHasChildren.lua"

class "Room" extends "Structure" implements "IHasChildren"
{
	floor = 0;
	walls = {};
	floor = {};
	ceiling = {};
	palette = {};
}

function Room:Room( floor, a, b, palette )
	self.floor = tonumber( floor ) or error( "Expected number, Point3D, MaterialPalette", 3 )
	self.palette = palette

	-- Generate walls
	self.walls = {}

	local fill = function() local x = Block() x.name = "minecraft:glass" return x end

	self.walls[ 1 ] = Wall( a, Point3D( b.x, b.y, a.z ), fill )
	self.walls[ 2 ] = Wall( a, Point3D( a.x, b.y, b.z ), fill )
	self.walls[ 3 ] = Wall( Point3D( b.x, a.y, a.z ), b, fill )
	self.walls[ 4 ] = Wall( Point3D( a.x, a.y, b.z ), b, fill )

	self:IHasChildren()
end

function Room:build( x, y, z )
	if not x then
		x = self.origin.x
	end
	if not y then
		y = self.origin.y
	end
	if not z then
		z = self.origin.z
	end

	-- self.floor:build()

	for i, wall in ipairs( self.walls ) do
		print( "Building wall", i )
		wall:build()
	end

	-- self.ceiling:build()

	for child in self:iterOverChildren() do
		child:build()
	end

	return self.super:build( x, y, z )
end
