
dofile "Classes/Structure.lua"
dofile "Interfaces/IHasChildren.lua"

class "Building"
	extends "Structure"
	implements "IHasChildren"
{}

function Building:Building( origin )
	
end
