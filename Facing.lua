
class "Facing"
{
	direction = 0;
}

local orientations = {
	"north", "east", "south", "west",
}

function Facing:Facing( d )
	d = d or 1

	if type( d ) == "string" then
		for i = 1, #orientations do
			if orientations[ i ] == d:lower() then
				self.direction = i
				return
			end
		end

		error( "Unknown orientation '" .. d:lower() .. "'", 2 )
	elseif type( d ) == "number" then
		self.direction = d % #orientations
	else
		error( "Expected string, number or nil", 2 )
	end
end

function Facing:tostring()
	return orientations[ self.direction ]
end

function Facing:turnRight( n )
	n = n or 1
	n = n % #orientations

	if self.direction + n > #orientations then
		self.direction = self.direction - #orientations + n		
	else
		self.direction = self.direction + n
	end
end

function Facing:turnLeft( n )
	n = n or 1
	n = n % #orientations

	if self.direction - n < 1 then
		self.direction = self.direction + #orientations - n
	else
		self.direction = self.direction - n
	end
end
