
loaded = {}

rawdofile = dofile

function dofile( path )
	if not fs.exists( path ) then
		error( "No such file", 2 )
	end

	if not loaded[ path ] then
		loaded[ path ] = { rawdofile( path ) }
	end

	return unpack( loaded[ path ] )
end
