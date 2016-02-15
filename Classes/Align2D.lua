
local horizontalAligns = { "right", "center", "left" }
local verticalAligns = { "top", "center", "bottom" }

for i, v in ipairs( horizontalAligns ) do
	horizontalAligns[ v ] = v
end

for i, v in ipairs( verticalAligns ) do
	verticalAligns[ v ] = v
end

class "Align2D"
{
	horizontal = "";
	vertical = "";
}

function Align2D:Align2D( horizontal, vertical )
	local found
	
	if type( horizontal ) == "number" and type( vertical ) == "number" then
		horizontal = horizontalAligns[ horizontal % #horizontalAligns ]
		vertical = verticalAligns[ vertical % #verticalAligns ]

		found = true
	elseif type( horizontal ) == "string" and type( vertical ) == "string" then
		for i, v in ipairs( horizontalAligns ) do
			if v == horizontal then
				found = true
				break
			end
		end

		if found then
			found = false

			for i, v in ipairs( verticalAligns ) do
				if v == vertical then
					found = true
					break
				end
			end
		end
	end

	if not found then
		error( "Expected (number or string), (number or string); where number or string results to a valid align type", 3 )
	end

	self.horizontal = horizontal
	self.vertical = vertical

	self.meta.__call = self.align
end

function Align2D:align( width, height, parentWidth, parentHeight )
	if type( width ) ~= "number" or type( height ) ~= "number" or type( parentWidth ) ~= "number" or type( parentHeight ) ~= "number" then
		error( "Expected number, number, number, number", 2 )
	end

	local x, y
	local warnings = {}

	local function warn( txt )
		warnings[ #warnings + 1 ] = txt
	end

	if width > parentWidth then
		warn "Width overflows parent!"
	end
	if height > parentHeight then
		warn "Height overflows parent!"
	end

	if self.horizontal == horizontalAligns.left then
		x = 0
	elseif self.horizontal == horizontalAligns.right then
		x = parentWidth - width
	elseif self.horizontal == horizontalAligns.center then
		x = parentWidth / 2 - width / 2
	end

	if self.vertical == horizontalAligns.top then
		y = 0
	elseif self.vertical == horizontalAligns.bottom then
		y = parentHeight - height
	elseif self.vertical == horizontalAligns.center then
		y = parentHeight / 2 - height / 2
	end

	return x, y, unpack( warnings )
end

function Align2D:duplicate()
	return Align2D( self.horizontal, self.vertical )
end
