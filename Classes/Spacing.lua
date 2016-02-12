
dofile "Classes/Point3D.lua"
dofile "Classes/Grid3D.lua"

class "Spacing"
{
	top = 0;
	bottom = 0;
	right = 0;
	left = 0;
	front = 0;
	back = 0;

	link = nil;
}

function Spacing:Spacing( top, bottom, right, left, front, back, obj )
	self.top	=	top
	self.bottom	=	bottom
	self.right	=	right
	self.left	=	left
	self.front	=	front
	self.back	=	back

	if obj then
		self:linkTo( obj )
	end

	self.mt.__add = self.add
end

function Spacing:linkTo( obj )
	if type( obj ) ~= "table" or not obj:typeOf( Grid3D ) then
		error( "Expected object which is or extends Grid3D", 2 )
	end

	local oldObj = self.obj

	self.link = obj

	return oldObj
end

--TODO: Is this the right way to do this? :/
function Spacing:add( str )
	-- str is the direction in which the spacing should be used
	if not self.link then
		error( "This Spacing is not linked to any object.", 2 )
	end

	if type( str ) ~= "string" then
		error( "Expected string", 2 )
	end

	if not self[ str ] then
		error( "Unknown key '" .. str .. "'", 2 )
	end

	return self[ str ]
end

function Spacing:duplicate()
	return Spacing( self.top, self.bottom, self.right, self.left, self.front, self.back )
end
