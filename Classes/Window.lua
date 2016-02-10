
dofile "Classes/Point3D.lua"
dofile "Classes/Spacing.lua"

class "Window" extends "Wall"
{
	align = "";
	spacing = {};
}

function Window:Window( from, to, spacing, fill )
	if type( from ) ~= "table" or not from:typeOf( Point3D ) or type( to ) ~= "table" or not to:typeOf( Point3D ) or
		type( spacing ) ~= "table" or not spacing:typeOf( Spacing ) then
		error( "Expected Point3D, Spacing, (Grid3D or Material or fill (function))", 3 )
	end

	self.spacing = spacing:duplicate()

	return self:Wall( from, to, fill )
end
