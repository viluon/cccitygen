
class "ObjectFactory"
{
	object = {};
}

function ObjectFactory:ObjectFactory( obj )
	if type( obj ) ~= "table" or not obj.duplicate then
		error( "Unsupported object", 2 )
	end

	self.object = obj
end

function ObjectFactory:create( ... )
	return self.object:duplicate( ... )
end

function ObjectFactory:getPortableConstructor( ... )
	local args = { ... }
	local obj = self.object
	return function()
		return obj:duplicate( unpack( args ) )
	end
end
