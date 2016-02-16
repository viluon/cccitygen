
dofile "Classes/Point3D.lua"

class "Grid3D"
{
	size = {};
	data = {};
	origin = {};
}

function Grid3D:Grid3D( size, origin, fill )
	if not size then
		print( "Warning: Initializing Grid3D with zero size isn't recommended." )

		self.size = Point3D( 0 )
		self.origin = origin and origin:duplicate() or Point3D( 0 )
		self.data = {}
		return
	end

	if type( size ) ~= "table" or not size:typeOf( Point3D ) or type( origin ) ~= "table" or not origin:typeOf( Point3D ) then
		error( "Expected (Point3D or nil), Point3D, fill (function)", 3 )
	end

	self.size = size:duplicate()

	self.size.x = math.abs( self.size.x )
	self.size.y = math.abs( self.size.y )
	self.size.z = math.abs( self.size.z )

	self.origin = origin:duplicate()

	self.data = {}

	local fill = fill or function() return false end

	for z = 1, self.size.z do
		self.data[ z ] = {}
		for y = 1, self.size.y do
			self.data[ z ][ y ] = {}
			for x = 1, self.size.x do
				self.data[ z ][ y ][ x ] = fill( x, y, z, self )
			end
		end
	end
end

-- Iterates over the grid, returning data and relative coords
function Grid3D:iter()
	local x, y, z = 0, 1, 1

	return function()
		x = x + 1

		if x > self.size.x then
			x = 1
			y = y + 1
		end
		if y > self.size.y then
			y = 1
			z = z + 1
		end
		if z > self.size.z then
			return nil
		end

		return self.data[ z ][ y ][ x ], x, y, z
	end
end

-- Converts coordinates from self to parent grid
function Grid3D:getAbsoluteCoordinates( x, y, z )
	return x + self.origin.x, y + self.origin.y, z + self.origin.z
end

-- Converts coordinates from parent grid to self
function Grid3D:getRelativeCoordinates( x, y, z )
	return x - self.origin.x, y - self.origin.y, z - self.origin.z
end

function Grid3D:loadFromFile( path )
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

	self = Grid3D( #data[ 1 ][ 1 ], #data[ 1 ], #data, self.origin.x, self.origin.y, self.origin.z )
	for _, x, y, z in self:iter() do
		self.data[ x ][ y ][ z ] = data[ x ][ y ][ z ]
	end
end

Grid3D.unserialize = Grid3D.loadFromFile
Grid3D.unserialise = Grid3D.loadFromFile

function Grid3D:saveToFile( path )
	local f = fs.open( path, "w" )

	if not f then error( "Unable to write to " .. path .. ", " .. tostring( err ), 2 ) end

	local res = "{\n"
	for k, v in pairs( self.data ) do
		res = res .. "  [" .. tostring( k ) .. "] = {\n"
		for kk, vv in pairs( v ) do
			res = res .. "    [" .. tostring( kk ) .. "] = {\n"
			for kkk, vvv in pairs( vv ) do
				res = res .. "      [" .. tostring( kkk ) .. "] = " .. tostring( vvv ) .. "\n"
			end
			res = res .. "    }\n"
		end
		res = res .. "  }\n"
	end

	f.write( res .. "}" ) --textutils.serialize( self.data ) )
	f.close()
end

Grid3D.serialize = Grid3D.saveToFile
Grid3D.serialise = Grid3D.saveToFile

function Grid3D:tostring()
	return "[Grid3D] size = " .. textutils.serialize( self.size ) .. "\n origin = " .. textutils.serialize( self.origin )
end

--[==[

	-- Tests

	print( "Testing", Grid3D )

	local world = Grid3D( 10, 10, 10, 5, 0, 0 )

	print( world:getAbsoluteCoordinates( 1, 1, 1 ) )
	print( world:getRelativeCoordinates( 10, 12, -3 ) )

	world.data[ 10 ][ 10 ][ 10 ] = true

	for data in world:iter() do
		print( data )
	end
]==]
