
dofile "Classes/Material.lua"

class "MaterialPalette" {}

local subpalettes = {
	"ceiling", "floor", "wall", "decorativeWall",
}

function MaterialPalette:MaterialPalette( ... ) -- ceiling, floor, wall, decorativeWall )
	local args = { ... }
	if #args < #subpalettes then
		error( "Expected " .. string.rep( "table, ", #subpalettes - 1 ) .. "table.", 2 )
	end

	for i, key in ipairs( subpalettes ) do
		self[ key ] = {}

		for k, material in pairs( args[ i ] ) do
			if not material:typeOf( Material ) then
				error( "Key '" .. tostring( k ) .. "'' of '" .. key .. "' is not a Material.", 2 )
			end

			self[ key ][ k ] = material:duplicate()
		end
	end

	--[[
		if type( ceiling ) ~= "table" or type( floor ) ~= "table" or type( wall ) ~= "table" or type( decorativeWall ) ~= "table" then
				error( "Expected table, table, table, table.", 2 )
			end
		
			for k, v in pairs( ceiling ) do
				if not v:typeOf( Material ) then
					error( "Key " .. tostring( k ) .. " of 'ceiling' is not a Material.", 2 )
				end
		
				table.insert( self.ceiling, v:duplicate() )
			end
		
			for k, v in pairs( floor ) do
				if not v:typeOf( Material ) then
					error( "Key " .. tostring( k ) .. " of 'floor' is not a Material.", 2 )
				end
		
				table.insert( self.floor, v:duplicate() )
			end
		
			for k, v in pairs( wall ) do
				if not v:typeOf( Material ) then
					error( "Key " .. tostring( k ) .. " of 'wall' is not a Material.", 2 )
				end
		
				table.insert( self.wall, v:duplicate() )
			end
		
			for k, v in pairs( decorativeWall ) do
				if not v:typeOf( Material ) then
					error( "Key " .. tostring( k ) .. " of 'decorativeWall' is not a Material.", 2 )
				end
		
				table.insert( self.decorativeWall, v:duplicate() )
			end
	]]
end

-- Imports a sub-palette from another MaterialPalette
function MaterialPalette:import( mp, key )
	self[ key ] = self[ key ] or {}
	for k, v in pairs( mp[ key ] ) do
		self[ key ][ k ] = v:duplicate()
	end
end
