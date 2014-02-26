function ulx.cinema_skip( calling_ply )
	
	if !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or there was an error.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	if !theater:IsPlaying() then
		ULib.tsayError( calling_ply, "There is no video playing.", true )
		return
	end
	
	local video = theater:VideoTitle()
	
	theater:SkipVideo()
	
	ulx.fancyLogAdmin( calling_ply, "#A skipped the video (#s) in #s", video, theater:Name() )

end
local cinema_skip = ulx.command( "Cinema", "ulx skipvideo", ulx.cinema_skip, {"!skipvideo", "!skip"}, true )
cinema_skip:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_skip:help( "Skips the current video." )

function ulx.cinema_seek( calling_ply, time )
	
	if !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or there was an error.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	if !theater:IsPlaying() then
		ULib.tsayError( calling_ply, "There is no video playing.", true )
		return
	end
	
	local video = theater:VideoTitle()
	
	theater:Seek(time)
	
	ulx.fancyLogAdmin( calling_ply, "#A set the video (#s) in #s to #s seconds", video, theater:Name(), time )

end
local cinema_seek = ulx.command( "Cinema", "ulx seekvideo", ulx.cinema_seek, {"!seekvideo", "!seek"}, true )
cinema_seek:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_seek:addParam{ type=ULib.cmds.NumArg, default=10, hint="time", min=0 }
cinema_seek:help( "Seeks to a certain point in the current video." )

function ulx.cinema_reset( calling_ply )
	
	if !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or there was an error.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	theater:Reset()
	
	ulx.fancyLogAdmin( calling_ply, "#A reset #s", theater:Name() )

end
local cinema_reset = ulx.command( "Cinema", "ulx resettheater", ulx.cinema_reset, {"!resettheater", "!reset"}, true )
cinema_reset:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_reset:help( "Resets the theater." )
