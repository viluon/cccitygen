
loaded = {}

rawdofile = dofile

function dofile( path )
	if not loaded[ path ] then
		loaded[ path ] = { rawdofile( path ) }
	end

	return unpack( loaded[ path ] )
end
