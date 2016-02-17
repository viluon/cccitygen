
dofile "class.lua"

interface "ISupportsConstructorChain" {}

local constructed = {}
local called = {}
local callInProgress = false

function ISupportsConstructorChain:ISupportsConstructorChain()
	self.meta.__call = self.call

	constructed[ self.class ] = constructed[ self.class ] or {}
	
	if not callInProgress and called[ self.class ] then
		constructed[ self.class ] = {}
		called[ self.class ] = false
	end

	constructed[ self.class ][ #constructed[ self.class ] + 1 ] = self
end

function ISupportsConstructorChain:call( ... )
	called[ self.class ] = true
	callInProgress = true
	constructed[ self.class ][ #constructed[ self.class ] + 1 ] = self.class( ... )
	callInProgress = false

	return unpack( constructed[ self.class ] )
end
