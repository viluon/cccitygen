
dofile "Classes/Point3D.lua"

class "Window" extends "Wall"
{
	align = "";
}

function Window:Window( size, fill )
	if type( size ) ~= "table" or not size:typeOf( Point3D ) then
		error( "Expected Point3D, (Grid3D or Material or fill (function))", 3 )
	end
end
