
dofile "Classes/Wall.lua"

class "WallWithWindows" extends "Wall"
{
	windows = {};
}

function WallWithWindows:WallWithWindows( from, to, fill, window )
	self.windows = {}

	-- Generate windows


	return self:Wall( from, to, fill )
end
