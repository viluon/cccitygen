
dofile "Classes/Structure.lua"
dofile "Classes/Wall.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Block.lua"

dofile "Interfaces/IHasChildren.lua"

class "Room" extends "Structure" implements "IHasChildren"
{
	a = {};
	b = {};
	size = {};
	side = false;
	walls = {};
	floor = {};
	ceiling = {};
	palette = {};
}

function Room:Room( a, b, palette )
	if not a:typeOf( Point3D ) or not b:typeOf( Point3D ) or type( palette ) ~= "table" or not palette:typeOf( MaterialPalette ) then
		error( "Expected Point3D, Point3D, MaterialPalette", 3 )
	end

	--TODO: IN_PROGRESS: just let a and b be relative (i.e. a = 0, 0, 0 (or 1?)), let the rest around here work the way it did

	self.palette = palette
	self.a = a
	self.b = b
	self.size = ( b - a ) + 1
	self.origin = { x = 0; y = 0; z = 0; }

	-- Generate walls
	self.walls = {}

	local fill = function() local x = Block() x.name = "minecraft:glass" return x end

	self.walls[ 1 ]	= Wall( a, Point3D( b.x, b.y, a.z ), palette:getFillFunctionForKey( "wall" ) )
	self.walls[ 2 ]	= Wall( a, Point3D( a.x, b.y, b.z ), palette:getFillFunctionForKey( "wall" ) )
	self.walls[ 3 ]	= Wall( Point3D( b.x, a.y, a.z ), b, palette:getFillFunctionForKey( "wall" ) )
	self.walls[ 4 ]	= Wall( Point3D( a.x, a.y, b.z ), b, palette:getFillFunctionForKey( "wall" ) )

	-- Generate floor and ceiling
	self.floor		= Wall( a, Point3D( b.x, a.y, b.z ), palette.floor[ 1 ] )
	self.ceiling	= Wall( Point3D( a.x, b.y, a.z ), b, palette.ceiling[ 1 ] )

	self:IHasChildren()
end

function Room:build( x, y, z )
	print( "  Building Room" )
	if not x then
		x = self.origin.x
	else
		x = x + self.origin.x - 1
	end

	if not y then
		y = self.origin.y
	else
		y = y + self.origin.y - 1
	end

	if not z then
		z = self.origin.z
	else
		z = z + self.origin.z - 1
	end

	print( "  at", x, y, z )

	print( "Building floor" )
	self.floor:build( x, y, z )
	print( "Building ceiling" )
	self.ceiling:build( x, y, z )

	for i, wall in ipairs( self.walls ) do
		print( "Building wall", i )
		wall:build( x, y, z )
	end

	for _, child in self:iterOverChildren() do
		print( "Building furniture", _ )
		child:build( x, y, z )
	end

	-- return self.super:build( x, y, z )
end

function Room:duplicate()
	local n = Room( self.a:duplicate(), self.b:duplicate(), self.palette:duplicate() )

	for _, child in self:iterOverChildren() do
		n:addChild( child )
	end

	return n
end

--TODO: Eugh, this is gonna be handled diferently
function Room:addFurniture( obj, x, y, z )
	return self:addChild( obj )
end
