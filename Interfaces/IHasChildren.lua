
interface "IHasChildren"
{
	children = {};
}

function IHasChildren:IHasChildren()
	self.children = {}
end

function IHasChildren:addChild( child )
	table.insert( self.children, child )
end

function IHasChildren:removeChild( child )
	for k, c in pairs( self.children ) do
		if c == child then
			return table.remove( self.children, k )
		end
	end
end

function IHasChildren:iterOverChildren()
	return pairs( self.children )
end
