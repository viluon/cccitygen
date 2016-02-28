
dofile "Classes/Point3D.lua"
dofile "Classes/Align2D.lua"
dofile "Classes/Spacing.lua"
dofile "Classes/Facing.lua"

class "Window" extends "Wall"
{
	align = {};
	offset = {};
	spacing = {};
}

function Window:Window( from, to, spacing, facing, align, fill )
	if type( from ) ~= "table" or not from:typeOf( Point3D ) or type( to ) ~= "table" or not to:typeOf( Point3D ) or
		type( facing ) ~= "table" or not facing:typeOf( Facing ) or type( spacing ) ~= "table" or not spacing:typeOf( Spacing ) or
		type( align ) ~= "table" or not align:typeOf( Align2D ) then
		error( "Expected Point3D, Point3D, Spacing, Facing, Align2D, (Grid3D or Material or fill (function))", 3 )
	end

	self.offset = Point3D( 0 )
	self.spacing = spacing:duplicate()
	self.align = align:duplicate()

	return self:Wall( from, to, facing, fill )
end

function Window:fitToWall( wall, index )
	local size = ( wall.b - wall.a ) + 1

	self.facing.direction = wall.facing.direction

	local a, b = self.a, self.b

	self.a = wall.a:duplicate()
	self.b = self.a + ( b - a ) * index
end

function Window:tostring()
	return "[Window] aligned to " .. tostring( self.align ) .. " with offset " .. tostring( self.offset ) .. " and spacing " .. tostring( self.spacing )
end

function Window:build( x, y, z )
	return self.super:build( ( Point3D( x, y, z ) + self.offset ):unpack() )
end
