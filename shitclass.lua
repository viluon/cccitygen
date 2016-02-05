
local inProgress

local classes = {}

local function newClass( name )
	if classes[ name ] then
		error( "Class already exists", 2 )
	end

	local n = {}
	local mt = {
		__call = function( ... )
			return n.new( ... )
		end;
		__type = "name";
		__newindex = function( this, key, value )
			
		end;
	}

	n.new = function( ... )
		local instance = {}
		for k, v in pairs( classes[ name ].prototype ) do
			instance[ k ] = v
		end
	end

	n = setmetatable( n, mt )

	classes[ name ] = {
		mt = mt;
		object = n;
	}

	return n
end

local class_mt = {
	__call = function( name )
		if type( name ) ~= "string" then
			error( "Expected string, got " .. type( name ), 2 )
		end

		inProgress = name

		return function( prototype )
			classes[ name ].prototype = prototype
		end
	end;
}

class = {}
