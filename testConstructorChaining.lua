
-- Reset dofile
loaded = {}

dofile "class.lua"

dofile "Classes/Point3D.lua"

local a, b, c = Point3D( 1 ) ( 2 ) ( 3 )

print( a, b, c )
