
-- Reset dofile
loaded = {}

dofile "class.lua"

dofile "Classes/Structure.lua"
dofile "Classes/Block.lua"
dofile "Classes/Point3D.lua"
dofile "Classes/Wall.lua"
dofile "Classes/Room.lua"
dofile "Classes/Building.lua"
dofile "Classes/MaterialPalette.lua"

dofile "Classes/ObjectFactory.lua"

dofile "Assets/Materials/OakWoodPlanks.lua"
dofile "Assets/Materials/SpruceWoodPlanks.lua"
dofile "Assets/Materials/Glass.lua"

dofile "Assets/Mutators/EvenRowsSpruce.lua"
dofile "Assets/Mutators/TopRowsSpruce.lua"

local testOrigin = Point3D( 191, 4, 835 )

commands.fill( testOrigin:getCoordinatesForCommand() .. " " .. ( testOrigin + 25 ):getCoordinatesForCommand() .. " minecraft:air" )

local stoneBlock = Block()
stoneBlock.name = "minecraft:stone"

local stoneFactory = ObjectFactory( stoneBlock )

local glassBlock = Block()
glassBlock.name = "minecraft:glass"

local glassFactory = ObjectFactory( glassBlock )


--[[
	local test = Structure( "test", 50, 2, 50, 191, 4, 835, function()
		local x = Block()
		x.name = "minecraft:stone"
		return x
	end )

	print( test )

	-- test:build(  )

	print( "Test Wall" )

	local w = Wall( testOrigin, Point3D( 201, 5, 836 ), function()
		local x = Block()
		x.name = "minecraft:glass"
		return x
	end )

	-- w:build()

	print( w )

	print( "Test Point3D" )
	local a = Point3D( 5, 5, 5 )
	local b = Point3D( 2, 3, 4 )

	print( a )
	print( b )

	print( a - b )
]]

--[[print( "Waht tha fcuk" )
local w = Wall( testOrigin, testOrigin + 4, stoneFactory:getPortableConstructor() )
]]
-- w:build()

--[[
	print( "Test Room" )

	local p = MaterialPalette( { SpruceWoodPlanks }, { SpruceWoodPlanks }, { OakWoodPlanks }, {}, {} )

	local roomTestPoint2 = Point3D( testOrigin.x + 10, testOrigin.y + 5, testOrigin.z + 7 )

	local r = Room( testOrigin, roomTestPoint2, p )
	r:build()
]]


print( "Test Building!" )

local p = MaterialPalette( { SpruceWoodPlanks }, { SpruceWoodPlanks }, { OakWoodPlanks }, {}, {} )
--p:addMutator( "wall", TopRowsSpruce )

local b = Building( Point3D( 15 ), "House" )
local r = Room( Point3D( 1 ), Point3D( 5 ), p )

b:populate( r )
b:build( testOrigin )

os.startTimer( 1 )
os.pullEvent "timer"
