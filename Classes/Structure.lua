
dofile "Classes/Block.lua"
dofile "Classes/Grid3D.lua"

class "Structure" extends "Grid3D"
{
	name = "";
	grid = {};
}

-- New Structure, name, size x y z, origin coords x y z, fill function
function Structure:Structure( name, ... )
	self.name = name
	
	return self:Grid3D( ... )
end

--[[
	function Structure:loadFromFile( ... )
		return self.grid:loadFromFile( ... )
	end

	Structure.unserialize = Structure.loadFromFile
	Structure.unserialise = Structure.loadFromFile

	function Structure:saveToFile( ... )
		return self.grid:saveToFile( ... )
	end

	Structure.serialize = Structure.saveToFile
	Structure.serialise = Structure.saveToFile
]]

function Structure:build( x, y, z )
	if not x then
		x = self.origin.x
	end
	if not y then
		y = self.origin.y
	end
	if not z then
		z = self.origin.z
	end

	for block, _x, _y, _z in self:iter() do
		if type( block ) == "table" and block.typeOf and block:typeOf( Block ) then
			block:placeAsync( _x + x - 1, _y + y - 1, _z + z - 1 )
		else
			print( "Ouch!", type( block ) )
		end
	end
end

function Structure:tostring()
	return "[Structure] " .. self.name .. ":\n" .. self.super:tostring()
end

--[[
	function Structure:loadFromFile( path )
		if not fs.exists( path ) and not fs.isDir( path ) then
			error( "File doesn't exist or is a directory", 2 )
		end

		local f, err = fs.open( path, "r" )

		if not f then
			error( "Unable to open " .. path .. ", " .. tostring( err ), 2 )
		end

		local contents = f.readAll()
		f.close()

		local data = textutils.unserialize( contents )

		self.grid = Grid3D( #data[ 1 ][ 1 ], #data[ 1 ], #data, self.grid.origin.x, self.grid.origin.y, self.grid.origin.z )
		for _, x, y, z in self.grid:iter() do
			self.grid.data[ x ][ y ][ z ] = data[ x ][ y ][ z ]
		end
	end

	Structure.unserialize = Structure.loadFromFile
]]
