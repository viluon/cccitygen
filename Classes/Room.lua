
dofile "Classes/Structure.lua"
dofile "Classes/Wall.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Block.lua"

dofile "Interfaces/IHasChildren.lua"

class "Room" extends "Structure" implements "IHasChildren"
{
	walls = {};
	floor = {};
	ceiling = {};
	palette = {};
}

function Room:Room( a, b, palette )
	if not a:typeOf( Point3D ) or not b:typeOf( Point3D ) or type( palette ) ~= "table" or not palette:typeOf( MaterialPalette ) then
		error( "Expected Point3D, Point3D, MaterialPalette", 3 )
	end

	self.palette = palette

	print( palette )

	-- Generate walls
	self.walls = {}

	local fill = function() local x = Block() x.name = "minecraft:glass" return x end

	self.walls[ 1 ] = Wall( a, Point3D( b.x, b.y, a.z ), palette:getRandomMaterialForKey( "wall" ) )
	self.walls[ 2 ] = Wall( a, Point3D( a.x, b.y, b.z ), palette:getRandomMaterialForKey( "wall" ) )
	self.walls[ 3 ] = Wall( Point3D( b.x, a.y, a.z ), b, palette:getRandomMaterialForKey( "wall" ) )
	self.walls[ 4 ] = Wall( Point3D( a.x, a.y, b.z ), b, palette:getRandomMaterialForKey( "wall" ) )

	-- Generate floor and ceiling
	self.floor = Wall( a, Point3D( b.x, a.y, b.z ), fill )
	self.ceiling = Wall( Point3D( a.x, b.y, a.z ), b, fill )

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

	print( "Building floor" )
	self.floor:build()

	for i, wall in ipairs( self.walls ) do
		print( "Building wall", i )
		wall:build()
	end

	print( "Building ceiling" )
	self.ceiling:build()

	for child in self:iterOverChildren() do
		child:build()
	end

	return self.super:build( x, y, z )
end
