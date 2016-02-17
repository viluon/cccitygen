
dofile "Interfaces/ISupportsConstructorChain.lua"

class "Point3D" implements "ISupportsConstructorChain"
{
	x = 0;
	y = 0;
	z = 0;
}

function Point3D:Point3D( x, y, z )
	if type( x ) ~= "number" then
		error( "Expected (number, number, number) or number", 3 )
	end
	if ( type( y ) ~= "number" and y ~= nil ) or ( type( z ) ~= "number" and z ~= nil ) then
		error( "Expected (number, number, number) or number", 3 )
	end

	if not y then
		y = x
	end
	if not z then
		z = y
	end
	
	self.x = x
	self.y = y
	self.z = z

	self.meta.__sub = self.sub
	self.meta.__add = self.add

	self:ISupportsConstructorChain()
end

function Point3D:sub( b )
	if type( b ) == "number" then
		return Point3D( self.x - b, self.y - b, self.z - b )
	elseif type( b ) == "table" and b:typeOf( Point3D ) then
		return Point3D( self.x - b.x, self.y - b.y, self.z - b.z )
	end
end

function Point3D:add( b )
	if type( b ) == "number" then
		return Point3D( self.x + b, self.y + b, self.z + b )
	elseif b:typeOf( Point3D ) then
		return Point3D( self.x + b.x, self.y + b.y, self.z + b.z )
	end
end

function Point3D:tostring()
	return "{ x = " .. self.x .. "; y = " .. self.y .. "; z = " .. self.z .. "; }"
end

function Point3D:unpack()
	return self.x, self.y, self.z
end

function Point3D:getCoordinatesForCommand()
	return self.x .. " " .. self.y .. " " .. self.z
end

function Point3D:duplicate()
	return Point3D( self:unpack() )
end
