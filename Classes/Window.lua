
dofile "Classes/Point3D.lua"
dofile "Classes/Align2D.lua"
dofile "Classes/Spacing.lua"

class "Window" extends "Wall"
{
	align = {};
	offset = {};
	spacing = {};
}

function Window:Window( from, to, spacing, align, fill )
	if type( from ) ~= "table" or not from:typeOf( Point3D ) or type( to ) ~= "table" or not to:typeOf( Point3D ) or
		type( spacing ) ~= "table" or not spacing:typeOf( Spacing ) or type( align ) ~= "table" or not align:typeOf( Align2D ) then
		error( "Expected Point3D, Spacing, Align2D, (Grid3D or Material or fill (function))", 3 )
	end

	self.offset = Point3D( 0 )
	self.spacing = spacing:duplicate()
	self.align = align:duplicate()

	return self:Wall( from, to, fill )
end

function Window:fitToWall( wall, index )
	--TODO: Current work
end

function Window:build( x, y, z )
	return self.super:build( ( Point3D( x, y, z ) + self.offset ):unpack() )
end
