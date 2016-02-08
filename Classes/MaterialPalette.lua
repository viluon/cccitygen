
dofile "Classes/Material.lua"
dofile "Classes/Mutator.lua"

class "MaterialPalette" {}

local subpalettes = {
	"ceiling", "floor", "wall", "decorativeWall", "window",
}

function MaterialPalette:MaterialPalette( ... )
	local args = { ... }
	if #args < #subpalettes then
		error( "Expected " .. string.rep( "table, ", #subpalettes - 1 ) .. "table", 3 )
	end

	for i, key in ipairs( subpalettes ) do
		self[ key ] = {}

		for k, material in pairs( args[ i ] ) do
			if not material:typeOf( Material ) then
				error( "Key '" .. tostring( k ) .. "' of '" .. key .. "' is not a Material.", 3 )
			end

			self[ key ][ k ] = material:duplicate()
		end
	end
end

function MaterialPalette:addMutator( subpalette, mut )
	if type( mut ) ~= "table" or not mut:typeOf( Mutator ) or type( subpalette ) ~= "string" then
		error( "Expected subpalette, Mutator", 2 )
	end

	if not self[ subpalette ] then
		error( "No such subpalette '" .. tostring( subpalette ) .. "'", 2 )
	end

	for i, material in ipairs( self[ subpalette ] ) do
		material:addMutator( mut )
	end
end

function MaterialPalette:addMutatorToAll( mut )
	if type( mut ) ~= "table" or not mut:typeOf( Mutator ) then
		error( "Expected Mutator", 2 )
	end

	for i, key in ipairs( subpalettes ) do
		self:addMutator( key, mut )
	end
end

-- Imports a sub-palette from another MaterialPalette
function MaterialPalette:import( mp, key )
	self[ key ] = self[ key ] or {}
	for k, v in pairs( mp[ key ] ) do
		self[ key ][ k ] = v:duplicate()
	end
end

function MaterialPalette:tostring()
	local str = ""

	for k, v in pairs( self.wall ) do
		str = str .. tostring( k ) .. " = " .. tostring( v ) .. "\n"
	end

	return str
end

function MaterialPalette:getRandomMaterialForKey( key )
	if not self[ key ] then
		error( "No such key " .. tostring( key ), 2 )
	end

	return self[ key ][ math.random( #self[ key ] ) ]
end

function MaterialPalette:getFillFunctionForKey( key )
	return function( ... )
		return self:getRandomMaterialForKey( key )( ... )
	end
end

function MaterialPalette:duplicate()
	local args = {}

	for i, key in ipairs( subpalettes ) do
		args[ i ] = {}

		for k, material in pairs( self[ key ] ) do
			args[ i ][ k ] = material:duplicate()
		end
	end

	return MaterialPalette( unpack( args ) )
end
