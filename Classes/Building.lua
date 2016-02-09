
dofile "Interfaces/IHasChildren.lua"
dofile "Classes/Point3D.lua"

class "Building" implements "IHasChildren"
{
	-- a = {};
	-- b = {};
	size = {};
	name = "";
	roomOffset = {
		x = 0;
		y = 0;
		z = 0;
	};
}

function Building:Building( size, name, roomOffset ) -- from, to, name )
	--[[
		if type( from ) ~= "table" or not from:typeOf( Point3D ) or type( to ) ~= "table" or not to:typeOf( Point3D ) then
			error( "Expected Point3D, Point3D, optional name", 3 )
		end
	]]

	self:IHasChildren()

	if roomOffset then
		self.roomOffset = roomOffset:duplicate()
	else
		self.roomOffset = Point3D( 0 )
	end

	self.size = size -- ( to - from ) + 1

	-- self.a = from
	-- self.b = to
end

function Building:populate( room )
	local x, y, z = 1, 1, 1

	while z < self.size.z do
		while y < self.size.y do
			while x < self.size.x do
				print( "Adding room at", x, y, z )
				local r = room:duplicate()

				r.origin.x, r.origin.y, r.origin.z = ( Point3D( x, y, z ) - 1 ):unpack()

				self:addChild( r )

				if x == 1 or y == 1 or z == 1 or x + room.size.x > self.size.x or y + room.size.y > self.size.y or z + room.size.z > self.size.z then
					self.children[ #self.children ].side = true
				end

				x = x + room.size.x - 1 + self.roomOffset.x
			end
			y = y + room.size.y - 1 + self.roomOffset.y
			x = 1
		end
		z = z + room.size.z - 1 + self.roomOffset.z
		y = 1
	end
end

function Building:build( x, y, z )
	if type( x ) == "table" and x:typeOf( Point3D ) then
		x, y, z = x:unpack()
	elseif type( x ) == "number" then
		if not y or not z then
			error( "Expected (number, number, number) or Point3D", 2 )
		end
	elseif not x and not y and not z then
		x, y, z = self.a:unpack()
	else
		error( "Expected (number, number, number) or Point3D", 2 )
	end

	x, y, z = x + 1, y + 1, z + 1

	for _, child in self:iterOverChildren() do
		print( "Building child at", x, y, z )
		child:build( x, y, z )
	end
end
