
class "Block"
{
	name = "minecraft:air";
	data = 0;
	tag = {};
	solid = true;
}

function Block:place( x, y, z )
	commands.setblock( x .. " " .. y .. " " .. z .. " " .. self.name .. " " .. self.data .. " replace " .. textutils.serializeJSON( self.tag ) )
end

function Block:placeAsync( x, y, z )
	commands.async.setblock( x .. " " .. y .. " " .. z .. " " .. self.name .. " " .. self.data .. " replace " .. textutils.serializeJSON( self.tag ) )
end

function Block:duplicate()
	local d = Block()
	d.name = self.name
	d.data = self.data
	d.tag = {}

	for k, v in pairs( self.tag ) do
		d.tag[ k ] = v
	end

	return d
end

function Block:tostring()
	return 
[[ {
	type = "]] .. self:type() .. [[";
	name = "]] .. self.name .. [[";
	data = ]] .. self.data .. [[;
	tag = ]] .. textutils.serialize( self.tag ) .. [[
} ]]
end
