
class "Point3D"
{
	x = 0;
	y = 0;
	z = 0;
}

function Point3D:Point3D( x, y, z )
	if type( x ) ~= "number" or type( y ) ~= "number" or type( z ) ~= "number" then
		error( "Expected number, number, number", 2 )
	end
	
	self.x = x
	self.y = y
	self.z = z

	self.meta.__sub = self.sub
	self.meta.__add = self.add
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
