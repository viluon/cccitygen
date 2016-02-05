
class "Mutator"
{
	mutate = function() end;
	link = {};
}

function Mutator:Mutator( fn )
	if type( fn ) ~= "function" then
		error( "Expected function", 2 )
	end

	self.mutate = fn

	self.link = nil
end

function Mutator:apply( ... )
	if self.link then
		return self.mutate( self.link:apply( ... ) )
	end
	return self.mutate( ... )
end

--TODO: Is this a good name?
--TODO: Shouldn't this be the other way around?
function Mutator:bindTo( mut )
	if not mut:typeOf( Mutator ) then
		error( "Expected Mutator", 2 )
	end

	if mut == self or mut.link == self then
		--TODO: This needs more checks
		error( "Cannot create a cyclic link", 2 )
	end

	local old = self.link
	self.link = mut

	return old
end
